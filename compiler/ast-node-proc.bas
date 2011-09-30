''
'' AST proc body nodes
'' l = head node; r = tail node
''
'' note: an implicit scope block isn't created, because the
''		 implicit main() function (inside scope blocks only
''		 non-decl statements are allowed)
''


#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "lex.bi"
#include once "parser.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

type FB_GLOBINSTANCE
	sym				as FBSYMBOL_ ptr			'' for symbol
	initree			as ASTNODE ptr				'' can't store in sym, or emit will use it
	has_dtor		as integer
end type

declare function hNewProcNode _
	( _
		_
	) as ASTNODE ptr

declare function hModLevelIsEmpty _
	( _
		byval p as ASTNODE ptr _
	) as integer

declare sub hLoadProcResult _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare function hDeclProcParams _
	( _
		byval proc as FBSYMBOL ptr _
	) as integer

declare function hUpdScopeBreakList	_
	( _
		byval n as ASTNODE ptr _
	) as integer

declare sub	hCallCtors _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub hCallDtors _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub hDestroyVars _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub hGenStaticInstancesDtors _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub hGenGlobalInstancesCtor _
	( _
		_
	)

''::::
sub astProcListInit( )

	ast.proc.head = NULL
	ast.proc.tail = NULL
	ast.proc.curr = NULL

	''
	listNew( @ast.globinst.list, 32, len( FB_GLOBINSTANCE ), LIST_FLAGS_NOCLEAR )
	ast.globinst.ctorcnt = 0
	ast.globinst.dtorcnt = 0

end sub

''::::
sub astProcListEnd( )

	ast.globinst.dtorcnt = 0
	ast.globinst.ctorcnt = 0
	listFree( @ast.globinst.list )

	''
	ast.proc.head = NULL
	ast.proc.tail = NULL
	ast.proc.curr = NULL

end sub

'':::::
private function hNewProcNode _
	(  _
		_
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = astNewNode( AST_NODECLASS_PROC, FB_DATATYPE_INVALID, NULL )

	'' add to list
	if( ast.proc.tail <> NULL ) then
		ast.proc.tail->next = n
	else
		ast.proc.head = n
	end if

	n->prev = ast.proc.tail
	n->next = NULL
	ast.proc.tail = n

	function = n

end function

'':::::
private sub hDelProcNode _
	( _
		byval n as ASTNODE ptr _
	) static

	n->l = NULL
	n->r = NULL

	'' remove from list
	if( n->prev <> NULL ) then
		n->prev->next = n->next
	else
		ast.proc.head = n->next
	end If

	if( n->next <> NULL ) then
		n->next->prev = n->prev
	else
		ast.proc.tail = n->prev
	end If

	astDelNode( n )

end sub

''::::
private sub hProcFlush _
	( _
		byval p as ASTNODE ptr, _
		byval doemit as integer _
	)

    dim as ASTNODE ptr n = any, nxt = any
    dim as FBSYMBOL ptr sym = any

	sym = p->sym

	if( doemit ) then
		'' emit the static dtor wrappers
		hGenStaticInstancesDtors( sym )
	end if

	''
	ast.proc.curr = p
	ast.currblock = p
	ast.doemit = doemit

	''
	parser.scope = iif( p->block.proc.ismain, FB_MAINSCOPE, FB_MAINSCOPE+1 )
	parser.currproc = sym
	parser.currblock = sym

	''
	symbNestBegin( sym, FALSE )

	'' emit header
	if( ast.doemit ) then
		symbSetProcIsEmitted( sym )

		irEmitPROCBEGIN( sym, p->block.initlabel )

		'' allocate the non-static local variables on stack
		symbProcAllocLocalVars( sym )
	end if

	'' flush nodes
	n = p->l
	do while( n <> NULL )
		nxt = n->next
		astLoad( n )
		astDelNode( n )
		n = nxt
	loop

    '' emit footer
    if( ast.doemit ) then
    	irEmitPROCEND( sym, p->block.initlabel, p->block.exitlabel )
    end if

    '' emit static local variables
    irProcAllocStaticVars( symbGetProcSymbTbHead( sym ) )

    '' del symbols from hash and symbol tb's
    symbDelSymbolTb( @sym->proc.symtb, FALSE )

    ''
    symbNestEnd( FALSE )

	''
	hDelProcNode( p )

	''
	ast.doemit = TRUE

end sub

''::::
private sub hProcFlushAll _
	( _
		_
	)

    dim as ASTNODE ptr n = any
    dim as integer doemit = any
    dim as FBSYMBOL ptr sym = any

	'' procs should be sorted by include file

	'' gen the global ctors/dtors, if any (done before emitting main()
	'' because the ctors/dtors could be private and not called yet)
	hGenGlobalInstancesCtor( )

	do
		n = ast.proc.head
		if( n = NULL ) then
			exit do
		end if

		sym = n->sym

		'' fully parsed?
		if( symbGetIsParsed( sym ) ) then
			doemit = TRUE
			'' private?
			if( symbIsPrivate( sym ) ) then
				'' never called? skip
				if( symbGetIsCalled( sym ) = FALSE ) then
					doemit = FALSE

				'' module-level?
				elseif( symbGetIsModLevelProc( sym ) ) then
					doemit = (hModLevelIsEmpty( n ) = FALSE)
				end if
			end if

		else
			doemit = FALSE
		end if

		hProcFlush( n, doemit )
	loop

end sub

'':::::
#macro hCheckCtor( n )
	'' ctor?
	if( symbIsConstructor( ast.proc.curr->sym ) ) then
		'' not initialized yet?
		if( symbGetIsCtorInited( ast.proc.curr->sym ) = FALSE ) then
			'' does the node being added result in executable code?
			if( astGetClassIsCode( n->class ) ) then
				'' must be set first, because recursion
				symbSetIsCtorInited( ast.proc.curr->sym )
				'' call ctors
				hCallCtors( ast.proc.curr->sym )
			end if
		end if
	end if
#endmacro

''::::
function astAdd _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	static as integer reclevel = 0

	if( n = NULL ) then
		return NULL
	end if

	'' RTL function and the result was discarded? do not allocate a result
	if( astIsCALL( n ) ) then
		if( n->call.isrtl ) then
			if( astGetFullType( n ) <> FB_DATATYPE_VOID ) then
				astSetType( n, FB_DATATYPE_VOID, NULL )
			end if
		end if
	end if

	'' typeIniUpdate() and hCallCtors() will recurse in this function
	if( reclevel = 0 ) then
		reclevel += 1

		''
		hCheckCtor( n )

		'' do updates and optimizations now as they can
		'' allocate new vars and create/delete nodes
		n = astTypeIniUpdate( n )
		n = astOptimizeTree( n )
		n = astOptAssignment( n )
		n = astUpdStrConcat( n )

		'' del temp instances
		if( ast.flushdtorlist ) then
			n = astDTorListFlush( n, TRUE )
		end if

		reclevel -= 1
	end if

	''
	if( ast.proc.curr->r <> NULL ) then
		ast.proc.curr->r->next = n
	else
		ast.proc.curr->l = n
	end if

	n->prev = ast.proc.curr->r
	n->next = NULL
	ast.proc.curr->r = n

	function = n

end function

''::::
function astAddAfter _
	( _
		byval n as ASTNODE ptr, _
		byval after_node as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr tail_ = any, next_ = any

	if( (after_node = NULL) or (n = NULL) ) then
		return NULL
	end if

	tail_ = ast.proc.curr->r

	'' tail? no relink needed..
	if( tail_ = after_node ) then
		return astAdd( n )
	end if

	ast.proc.curr->r = after_node

	next_ = after_node->next
	after_node->next = NULL

	n = astAdd( n )

    if( next_ = NULL ) then
    	return NULL
    end if

	next_->prev = n
	n->next = next_
	ast.proc.curr->r = tail_

	function = n

end function

''::::
sub astAddUnscoped _
	( _
		byval n as ASTNODE ptr _
	)

	dim as ASTNODE ptr last = any

	if( n = NULL ) then
		exit sub
	end if

	last = ast.proc.curr->block.proc.decl_last
	if( last = NULL ) then
		last = ast.proc.curr->l
	end if

	ast.flushdtorlist = FALSE

	if( last = NULL ) then
		n = astAdd( n )
	else
		n = astAddAfter( n, last )
	end if

	ast.flushdtorlist = TRUE

	ast.proc.curr->block.proc.decl_last = n

end sub

'':::::
function astProcBegin _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ismain as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	function = NULL

	'' alloc new node
	n = hNewProcNode( )
	if( n = NULL ) then
		exit function
	end if

	''
	symbSymbTbInit( sym->proc.symtb, sym )

	''
	if( sym->proc.ext = NULL ) then
		sym->proc.ext = symbAllocProcExt( )
	end if

	''
	ast.proc.curr = n
	ast.currblock = n

	parser.scope = iif( ismain, FB_MAINSCOPE, FB_MAINSCOPE+1 )
	parser.currproc = sym
	parser.currblock = sym

	symbNestBegin( sym, FALSE )

	'' add init and exit labels (see the note in the top,
	'' procs don't create an implicit scope block)
	n->block.initlabel = symbAddLabel( NULL )
	n->block.exitlabel = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	''
	n->sym = sym

	n->block.proc.ismain = ismain
	n->block.parent = NULL
	n->block.inistmt = parser.stmt.cnt

	'' break list
	n->block.breaklist.head = NULL
	n->block.breaklist.tail = NULL

	''
	n->block.proc.decl_last = NULL

	''
	irProcBegin( sym )

	' Don't allocate anything for a naked function, because they will be allowed
	' at ebp-N, which won't exist, no result is needed either
	if( irGetOption( IR_OPT_HIGHLEVEL ) orelse (sym->attrib and FB_SYMBATTRIB_NAKED) = 0 ) then

    	'' alloc parameters
    	if( hDeclProcParams( sym ) = FALSE ) then
    		exit function
    	end if

		'' alloc result local var
		if( symbGetType( sym ) <> FB_DATATYPE_VOID ) then
			if( symbAddProcResult( sym ) = NULL ) then
				exit function
			end if
		end if

	end if

	'' local error handler
	with sym->proc.ext->err
		.lasthnd = NULL
		.lastmod = NULL
		.lastfun = NULL
	end with

	sym->proc.ext->stmtnum = parser.stmt.cnt

	function = n

end function

'':::::
private function hCheckErrHnd _
	( _
		byval head_node as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	'' error check? add to head (must be done only when closing the proc body
	'' or constructor's field would be initialized and break ctor chaining)
	if( env.clopt.extraerrchk ) then
		head_node = astAddAfter( rtlErrorSetModName( sym, _
										 			 astNewCONSTstr( @env.inf.name ) ), _
							head_node )

		head_node = astAddAfter( rtlErrorSetFuncName( sym, _
												 	  astNewCONSTstr( symbGetName( sym ) ) ), _
						    head_node )
	end if

	with sym->proc.ext->err
		if( .lastfun <> NULL ) then
           	astAdd( rtlErrorSetFuncName( NULL, _
           								 astNewVAR( .lastfun, _
           						   		 0, _
           						   		 typeAddrOf( FB_DATATYPE_CHAR ) ) ) )
           	.lastfun = NULL
		end if

		if( .lastmod <> NULL ) then
           	astAdd( rtlErrorSetModName( NULL, _
           								astNewVAR( .lastmod, _
           						   		0, _
           						   		typeAddrOf( FB_DATATYPE_CHAR ) ) ) )

			.lastmod = NULL
		end if

		if( .lasthnd <> NULL ) then
       		rtlErrorSetHandler( astNewVAR( .lasthnd, _
       					  	  			   0, _
       					  	  			   typeAddrOf( FB_DATATYPE_VOID ) ), _
       							FALSE )
			.lasthnd = NULL
		end if
	end with

	function = head_node

end function

'':::::
private function hCallResultCtor _
	( _
		byval head_node as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr res = any, subtype = any

    subtype = symbGetSubtype( sym )

    if( symbGetCompDefCtor( subtype ) = NULL ) then
    	return head_node
    end if

    res = symbGetProcResult( sym )
    if( res = NULL ) then
    	return head_node
    end if

    head_node = astAddAfter( _
    				astBuildCtorCall( subtype, _
    							   	  astBuildProcResultVar( sym, res ) ), _
    			 	head_node )

	function = head_node

end function

'':::::
private function hCallProfiler _
	( _
		byval head_node as ASTNODE ptr _
	) as ASTNODE ptr

	'' on all ports except dos _mcount() is just a normal call
	if( env.clopt.profile ) then
		if( env.clopt.target <> FB_COMPTARGET_DOS ) then
			head_node = astAddAfter( rtlProfileCall_mcount(), head_node )
		end if
	end if

	function = head_node

end function

'':::::
function astProcEnd _
	( _
		byval n as ASTNODE ptr, _
		byval callrtexit as integer _
	) as integer

    static as integer rec_cnt = 0
    dim as integer res = any, do_flush = any
    dim as FBSYMBOL ptr sym = any

	''
	rec_cnt += 1

	''
	sym = n->sym

	n->block.endstmt = parser.stmt.cnt

	if( errGetCount( ) = 0 ) then
		'' if the function body is empty, no ctor initialization will be done
		hCheckCtor( n )

		'' del local dynamic arrays and var-len strings (see the note in
		'' the top, procs don't create an implicit scope block)
		hDestroyVars( sym )

		'' dtor?
		if( symbIsDestructor( sym ) ) then
			'' call dtors
			hCallDtors( sym )
		end if
	end if

   	''
   	astAdd( astNewLABEL( n->block.exitlabel ) )

	'' check undefined local labels
	res = (symbCheckLocalLabels( ) = 0)

	if( res = TRUE ) then
		'' update proc's breaks list, adding calls to destructors when needed
		if( n->block.breaklist.head <> NULL ) then
			res = astScopeUpdBreakList( n )
		end if

		'' gosub used?
		astGosubAddExit( sym )

		dim as ASTNODE ptr head_node = n->l

		''
		head_node = hCallProfiler( head_node )

		''
		head_node = hCheckErrHnd( head_node, sym )

		'' if main(), END 0 must be called because it's not safe to return to crt if
		'' an ON ERROR module-level handler was called while inside some proc
		if( callrtexit ) then
			if( n->block.proc.ismain ) then
				rtlExitApp( NULL )
			end if
		end if

		' Don't load the result for naked functions
		if( irGetOption( IR_OPT_HIGHLEVEL ) orelse (sym->attrib and FB_SYMBATTRIB_NAKED) = 0 ) then
			'' if it's a function, load result
			if( symbGetType( sym ) <> FB_DATATYPE_VOID ) then

				select case symbGetType( sym )
				case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
					if( symbGetProcStatAssignUsed( sym ) ) then
						head_node = hCallResultCtor( head_node, sym )
					end if
				end select

        		hLoadProcResult( sym )
			end if
		end if
	end if

	''
	irProcEnd( sym )

	do_flush = FALSE
	if( (res = TRUE) and (errGetCount( ) = 0) ) then
		symbSetIsParsed( sym )

		'' not into a recursion?
		if( rec_cnt = 1 ) then
			if( n->block.proc.ismain = FALSE ) then
				'' not private or inline? flush it..
				if( symbIsPrivate( sym ) = FALSE ) then
					do_flush = TRUE

				'' remove from hash tb only
				else
					symbDelSymbolTb( @sym->proc.symtb, TRUE )
				end if

			'' main? flush all remaining, it's the latest
			else
				do_flush = TRUE
			end if
		end if

	'' errors.. remove everything from hash and symbol tb
	else
		symbDelSymbolTb( @sym->proc.symtb, FALSE )
	end if

	''
	symbNestEnd( FALSE )

	if( env.clopt.vectorize >= FB_VECTORIZE_NORMAL ) then
		astProcVectorize( n->l )
	end if

	''
	if( do_flush ) then
	    if( n->block.proc.ismain = FALSE ) then
			hProcFlush( n, TRUE )
		else
			hProcFlushAll( )
		end if
	end if

	'' back to main (or NULL if main was emitted already)
	ast.proc.curr = ast.proc.head
	ast.currblock = ast.proc.head

    parser.scope = FB_MAINSCOPE
    parser.currproc = env.main.proc
    parser.currblock = env.main.proc

    ''
    rec_cnt -= 1

	function = res

end function

'':::::
private function hDeclProcParams _
	( _
		byval proc as FBSYMBOL ptr _
	) as integer

    dim as integer i = any
    dim as FBSYMBOL ptr p = any

	function = FALSE

	'' proc returns an UDT?
	if( symbGetType( proc ) = FB_DATATYPE_STRUCT ) then
		'' create an hidden arg if needed
		symbAddProcResultParam( proc )
	end if

	''
	i = 1
	p = symbGetProcLastParam( proc )
	do while( p <> NULL )

		if( p->param.mode <> FB_PARAMMODE_VARARG ) then
			p->param.var = symbAddParam( symbGetName( p ), p )
			if( p->param.var = NULL ) then
				errReportParam( proc, i, NULL, FB_ERRMSG_DUPDEFINITION )
				exit function
			end if
		end if

		p = symbGetProcPrevParam( proc, p )
		i += 1
	loop

	function = TRUE

end function

'':::::
private sub hLoadProcResult _
	( _
		byval proc as FBSYMBOL ptr _
	)

    dim as FBSYMBOL ptr s = any
    dim as ASTNODE ptr n = any
    dim as integer dtype = any
    dim as FBSYMBOL ptr subtype = any

	s = symbGetProcResult( proc )
	dtype = symbGetFullType( proc )
	subtype = symbGetSubtype( proc )
    n = NULL

	select case typeGet( dtype )

	'' if result is a string, a temp descriptor is needed, as the current one (on stack)
	'' will be trashed when the function returns (also, the string returned will be
	'' set as temp, so any assignment or when passed as parameter to another proc
	'' will deallocate this string)
	case FB_DATATYPE_STRING
		n = rtlStrAllocTmpResult( astNewVAR( s, 0, FB_DATATYPE_STRING ) )

		if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
			n = astNewLOAD( n, dtype, TRUE )
		end if

	'' UDT? use the real type
	case FB_DATATYPE_STRUCT
		dtype = symbGetProcRealType( proc )
	    if( dtype <> FB_DATATYPE_STRUCT ) then
	    	subtype = NULL
	    end if

	end select

	if( n = NULL ) then
		n = astNewLOAD( astNewVAR( s, 0, dtype, subtype ), dtype, TRUE )
	end if

	astAdd( n )

end sub

''::::
private function hModLevelIsEmpty _
	( _
		byval p as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr n = any, nxt = any

	'' an empty module-level proc will have just the
	'' initial and final labels as nodes and nothing else
	'' (note: when debugging it will be emitted even if empty)

	n = p->l
	if( n = NULL ) then
		return TRUE
	end if
	if( n->class <> AST_NODECLASS_LABEL ) then
		return FALSE
	end if

	n = n->next
	if( n = NULL ) then
		return TRUE
	end if
	if( n->class <> AST_NODECLASS_LABEL ) then
		return FALSE
	end if

	n = n->next
	if( n = NULL ) then
		return TRUE
	end if

	return FALSE

end function

'':::::
private sub hCallCtorList _
	( _
		byval is_ctor as integer, _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr cnt = any, label = any, iter = any, subtype = any
	dim as ASTNODE ptr fldexpr = any
	dim as integer dtype = any, elements = any

	'' instance? (this function is also used by the static dtor wrapper)
	if( fld <> NULL ) then
		dtype = symbGetType( fld )
		subtype = symbGetSubtype( fld )
		elements = symbGetArrayElements( fld )
	else
		dtype = symbGetType( this_ )
		subtype = symbGetSubtype( this_ )
		elements = symbGetArrayElements( this_ )
	end if

    cnt = symbAddTempVar( FB_DATATYPE_INTEGER, NULL, FALSE, FALSE )
    label = symbAddLabel( NULL )
    iter = symbAddTempVar( typeAddrOf( dtype ), subtype, FALSE, FALSE )

	if( fld <> NULL ) then
    	if( is_ctor ) then
    		'' iter = @this.field(0)
    		fldexpr = astBuildInstPtr( this_, fld )
    	else
    		'' iter = @this.field(elements-1)
    		fldexpr = astBuildInstPtr( this_, _
    							   	   fld, _
    							   	   astNewCONSTi( elements - 1, _
    							   				 	 FB_DATATYPE_INTEGER ) )
    	end if

    '' not an instance..
    else
    	if( is_ctor ) then
    		'' iter = @symbol(0)
    		fldexpr = astBuildVarField( this_, NULL, 0 )
    	else
    		'' iter = @symbol(0) + (elements - 1)
    		fldexpr = astBuildVarField( this_, _
    									NULL, _
    									(elements - 1) * symbGetLen( subtype ) )
    	end if
    end if

    astAdd( astBuildVarAssign( iter, astNewADDROF( fldexpr ) ) )

	'' for cnt = 0 to symbGetArrayElements( fld )-1
	astBuildForBegin( cnt, label, 0 )

	if( is_ctor ) then
		'' ctor( *iter )
    	astAdd( astBuildCtorCall( subtype, astBuildVarDeref( iter ) ) )
	else
		'' dtor( *iter )
    	astAdd( astBuildDtorCall( subtype, astBuildVarDeref( iter ) ) )
    end if

	'' iter += 1
    astAdd( astBuildVarInc( iter, iif( is_ctor, 1, -1 ) ) )

    '' next
    astBuildForEnd( cnt, label, 1, elements )

end sub

'':::::
private sub hCallFieldCtor _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr subtype = any

	subtype = symbGetSubtype( fld )

	select case symbGetType( fld )
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS

       	'' has a default ctor too?
       	if( symbGetCompDefCtor( subtype ) <> NULL ) then

			'' !!!FIXME!!! assuming only static arrays will be allowed in fields

      		'' not an array?
       		if( (symbGetArrayDimensions( fld ) = 0) or _
       			(symbGetArrayElements( fld ) = 1) ) then

       			'' ctor( this.field )
       			astAdd( astBuildCtorCall( subtype, _
     									  astBuildInstPtr( this_, fld ) ) )

       		'' array..
       		else
       			hCallCtorList( TRUE, this_, fld )
       		end if

       		exit sub
       	end if
	end select

   	'' do not clear?
   	if( symbGetDontInit( fld ) ) then
   		exit sub
   	end if

	'' bitfield?
	if( symbGetType( fld ) = FB_DATATYPE_BITFIELD ) then
	    astAdd( astNewASSIGN( astBuildInstPtr( this_, fld ), _
	    					  astNewCONSTi( 0, FB_DATATYPE_UINT ) ) )
	else
		astAdd( astNewMEM( AST_OP_MEMCLEAR, _
    	  	  		   	   astBuildInstPtr( this_, fld ), _
    	  	  		   	   astNewCONSTi( symbGetLen( fld ) * symbGetArrayElements( fld ) ) ) )
	end if

end sub

'':::::
private sub hFlushFieldInitTree _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	)

	dim as ASTNODE ptr initree = any

	initree = astTypeIniClone( symbGetTypeIniTree( fld ) )

	astAdd( astTypeIniFlush( initree, this_, AST_INIOPT_ISINI ) )

end sub

'':::::
private function hClearUnionFields _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval base_fld as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr fld = any
	dim as integer bytes = any, lgt = any, base_ofs = any

	'' merge all union fields
	fld = base_fld
	bytes = 0
	base_ofs = symbGetOfs( base_fld )

	do
		lgt = (symbGetLen( fld ) * symbGetArrayElements( fld )) + _
			  (symbGetOfs( fld ) - base_ofs)
		if( lgt > bytes ) then
			bytes = lgt
		end if

		fld = fld->next
		if( fld = NULL ) then
			exit do
		end if
	loop while( symbGetIsUnionField( fld ) )

    '' clear all them at once
	astAdd( astNewMEM( AST_OP_MEMCLEAR, _
    	  	  		   astBuildInstPtr( this_, base_fld ), _
    	  	  		   astNewCONSTi( bytes ) ) )

	function = fld

end function

'':::::
private sub hCallFieldCtors _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr fld = any, this_ = any, subtype = any

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )

    '' for each field..
    fld = symbGetCompSymbTb( parent ).head
    do while( fld <> NULL )

		if( symbIsField( fld ) ) then
			
			'' super class 'base' field? skip.. ctor must be called from derived class' ctor
			If( fld <> parent->udt.base ) Then
			
				'' part of an union?
				if( symbGetIsUnionField( fld ) ) then
					fld = hClearUnionFields( this_, fld )
	
					'' skip next
					continue do
	
				else
					'' not initialized?
					if( symbGetTypeIniTree( fld ) = NULL ) then
						hCallFieldCtor( this_, fld )
	
					'' flush the tree..
					else
						hFlushFieldInitTree( this_, fld )
					end if
				end If
			
			End If
		end if

		fld = fld->next
	loop

end sub

'':::::
private sub hCallBaseCtors _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _		
	)
	
	if( parent->udt.base = NULL ) then
		exit sub
	End If
	
	var ctor = symbGetCompDefCtor( symbGetSubtype( parent->udt.base ) )
	
	if( ctor = NULL ) then
		exit sub
	End If
	
	var this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )
	
	hCallFieldCtor( this_, parent->udt.base )

End Sub

'':::::
private sub hInitVtable _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _		
	)
	
	if( symbGetHasRTTI( parent ) = FALSE ) then
		exit sub
	End If
	
	if( parent->udt.ext = NULL ) then
		exit sub
	End If
	
	var this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )
	
    '' this.pvt = cast( any ptr, (cast(byte ptr, @vtable) + sizeof(void *) * 2) ) 
    astAdd( _ 
    	astNewASSIGN( _ 
    		astBuildInstPtr( this_, symbGetUDTFirstElm( symb.rtti.fb_object ) ), _
    		astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, _
    				astNewADDROF( astNewVAR( parent->udt.ext->vtable, FB_POINTERSIZE*2 ) ) ) ) )

End Sub

'':::::
private sub hCallCtors _
	( _
		byval proc as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr parent = any

	parent = symbGetNamespace( proc )

	'' 1st) base ctors
    hCallBaseCtors( parent, proc ) 

	'' 2nd) field ctors
    hCallFieldCtors( parent, proc )
    
    '' 3rd) setup de vtable ptr
    hInitVtable( parent, proc )

end sub

'':::::
private sub hCallFieldDtor _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	)		

	select case symbGetType( fld )
	case FB_DATATYPE_STRING

		var fldexpr = astBuildInstPtr( this_, fld )

    	'' not an array?
    	if( (symbGetArrayDimensions( fld ) = 0) or _
    		(symbGetArrayElements( fld ) = 1) ) then

    		astAdd( rtlStrDelete( fldexpr ) )

		'' array..
		else
	    	astAdd( rtlArrayStrErase( fldexpr ) )
		end if

	case FB_DATATYPE_STRUCT
    	var subtype = symbGetSubtype( fld )

    	'' has a dtor too?
    	if( symbGetHasDtor( subtype ) ) then

    		'' not an array?
    		if( (symbGetArrayDimensions( fld ) = 0) or _
    			(symbGetArrayElements( fld ) = 1) ) then

    			'' dtor( this.field )
    			astAdd( astBuildDtorCall( subtype, _
    									  astBuildInstPtr( this_, fld ) ) )

    		'' array..
    		else
    			hCallCtorList( FALSE, this_, fld )
    		end if

    	end if

	end Select

End Sub

'':::::
private sub hCallFieldDtors _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr fld = any, this_ = any

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )

    '' for each field (in inverse order)..
    fld = symbGetCompSymbTb( parent ).tail
    do while( fld <> NULL )

		'' !!!FIXME!!! assuming only static arrays will be allowed in fields

		if( symbIsField( fld ) ) then

			'' super class 'base' field? skip.. dtor must be called from derived class' dtor
			If( fld <> parent->udt.base ) Then

				hCallFieldDtor( this_, fld )
				
			End if
		end if

		fld = fld->prev
	loop

end sub

'':::::
private sub hCallBaseDtors _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)
	
	if( parent->udt.base = NULL ) then
		exit sub
	End If
	
	var dtor = symbGetCompDtor( symbGetSubtype( parent->udt.base ) )
	
	if( dtor = NULL ) then
		exit sub
	End If
	
	var this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )
	
	hCallFieldDtor( this_, parent->udt.base )

end sub

'':::::
private sub hCallDtors _
	( _
		byval proc as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr parent = any

	parent = symbGetNamespace( proc )

	'' 1st) fields dtors
    hCallFieldDtors( parent, proc )

	'' 2nd) base dtors
	hCallBaseDtors( parent, proc )

end sub

'':::::
private sub hDestroyVars _
	( _
		byval proc as FBSYMBOL ptr _
	)

    dim as FBSYMBOL ptr s = any

	'' for each var (in inverse order)
	s = symbGetProcSymbTb( proc ).tail
    do while( s <> NULL )
    	'' variable?
    	if( symbGetClass( s ) = FB_SYMBCLASS_VAR ) then
			'' has a dtor?
			if( symbGetVarHasDtor( s ) ) then
				astAdd( astBuildVarDtorCall( s, TRUE ) )
			end if
    	end if

    	s = s->prev
    loop

end sub

'':::::
private sub hCallStaticCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr _
	)

	'' ctor?
	if( initree <> NULL ) then
        astAdd( astTypeIniFlush( initree, _
        						 sym, _
        						 AST_INIOPT_ISINI or AST_INIOPT_RELINK ) )
		exit sub
	end if

	'' dynamic?
	if( symbIsDynamic( sym ) ) then
       	'' call ERASE..
       	astAdd( rtlArrayErase( astBuildVarField( sym, NULL, 0 ) ) )

    else
    	'' not an array?
    	if( (symbGetArrayDimensions( sym ) = 0) or _
    		(symbGetArrayElements( sym ) = 1) ) then

        	'' dtor( var )
        	astAdd( astBuildDtorCall( symbGetSubtype( sym ), _
            				  	  	  astBuildVarField( sym, NULL, 0 ) ) )

		'' array..
    	else
    		hCallCtorList( FALSE, sym, NULL )
		end if
	end if

end sub

'':::::
private sub hGenStaticInstancesDtors _
	( _
		byval proc as FBSYMBOL ptr _
	)

	dim as TLIST ptr dtorlist = any
	dim as FB_DTORWRAPPER ptr wrap = any
	dim as ASTNODE ptr n = any

	dtorlist = proc->proc.ext->statdtor

	if( dtorlist = NULL ) then
		exit sub
	end if

    '' for each node..
    wrap = listGetHead( dtorlist )
    do while( wrap <> NULL )
    	n = astBuildProcBegin( wrap->proc )

        '' call the dtor
        hCallStaticCtor( wrap->sym, NULL )

		astBuildProcEnd( n )

		'' must be flushed before the proc that has the static vars, because
		'' they will be removed from hash and symbols table right-after that
		'' proc is flushed
		hProcFlush( n, TRUE )

    	wrap = listGetNext( wrap )
    loop

    '' destroy list
    listFree( dtorlist )
    deallocate( proc->proc.ext->statdtor )
    proc->proc.ext->statdtor = NULL

end sub

'':::::
function astProcAddStaticInstance _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as TLIST ptr dtorlist = any
	dim as FB_DTORWRAPPER ptr wrap = any
	dim as FBSYMBOL ptr proc = any

	dtorlist = parser.currproc->proc.ext->statdtor

	'' create a new list
	if( dtorlist = NULL ) then
		dtorlist = callocate( len( TLIST ) )
		parser.currproc->proc.ext->statdtor = dtorlist

		listNew( dtorlist, 16, len( FB_DTORWRAPPER ), LIST_FLAGS_NOCLEAR )
	end if

    ''
    wrap = listNewNode( dtorlist )

	proc = symbAddProc( symbPreAddProc( NULL ), _
    					hMakeTmpStr( ), _
						NULL, _
						NULL, _
						FB_DATATYPE_VOID, NULL, _
						FB_SYMBATTRIB_PRIVATE or FB_SYMBOPT_DECLARING, _
						FB_FUNCMODE_CDECL )

    wrap->proc = proc
    wrap->sym = sym

    '' can't be undefined
	symbSetCantUndef( sym )

	function = proc

end function

'':::::
sub astProcAddGlobalInstance _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr, _
		byval has_dtor as integer _
	)

    dim as FB_GLOBINSTANCE ptr wrap = any

    ''
    wrap = listNewNode( @ast.globinst.list )

    wrap->sym = sym
    wrap->initree = initree
    wrap->has_dtor = has_dtor

    '' can't be undefined
	symbSetCantUndef( sym )

	if( initree <> NULL ) then
		ast.globinst.ctorcnt += 1
	end if

	if( has_dtor ) then
		ast.globinst.dtorcnt += 1
	end if

end sub

'':::::
private function hGlobCtorBegin _
	( _
		byval is_ctor as integer _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr proc = any
    dim as ASTNODE ptr n = any

	proc = symbAddProc( symbPreAddProc( NULL ), _
    					hMakeTmpStr( ), _
						iif( is_ctor, @FB_GLOBCTORNAME, @FB_GLOBDTORNAME ), _
						NULL, _
						FB_DATATYPE_VOID, NULL, _
						FB_SYMBATTRIB_PRIVATE or FB_SYMBOPT_DECLARING, _
						FB_FUNCMODE_CDECL )

	if( is_ctor ) then
		symbAddGlobalCtor( proc )
    else
    	symbAddGlobalDtor( proc )
    end if

    n = astBuildProcBegin( proc )

    function = n

end function

'':::::
private sub hCtorEnd _
	( _
		byval n as ASTNODE ptr _
	)

	astBuildProcEnd( n )

	symbSetIsCalled( n->sym )
	symbSetIsParsed( n->sym )

end sub

'':::::
private sub hGenGlobalInstancesCtor _
	( _
		_
	)

	dim as FB_GLOBINSTANCE ptr inst = any
	dim as ASTNODE ptr n = any
	dim as FBSYMBOL ptr sym = any

    '' any global instance with ctors?
    if( ast.globinst.ctorcnt > 0 ) then
		n = hGlobCtorBegin( TRUE )

    	'' for each node..
    	inst = listGetHead( @ast.globinst.list )
    	do while( inst <> NULL )

        	'' has ctor?
        	if( inst->initree <> NULL ) then
        		'' call ctor
                hCallStaticCtor( inst->sym, inst->initree )
			end if

    		inst = listGetNext( inst )
    	loop

    	hCtorEnd( n )
    end if

    '' any global instance with dtors?
    if( ast.globinst.dtorcnt > 0 ) then
		n = hGlobCtorBegin( FALSE )

    	'' for each node (in inverse order)..
    	inst = listGetTail( @ast.globinst.list )
    	do while( inst <> NULL )

            '' has dtor?
        	if( inst->has_dtor ) then
        		'' call dtor
                hCallStaticCtor( inst->sym, NULL )
			end if

    		inst = listGetPrev( inst )
    	loop

    	hCtorEnd( n )
    end if

    '' list will be deleted by astProcListEnd( )

end sub


