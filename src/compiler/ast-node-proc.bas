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

declare function hModLevelIsEmpty _
	( _
		byval p as ASTNODE ptr _
	) as integer

declare sub hLoadProcResult _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare function hDeclProcParams( byval proc as FBSYMBOL ptr ) as integer

declare function hUpdScopeBreakList	_
	( _
		byval n as ASTNODE ptr _
	) as integer

declare sub hCallCtors( byval n as ASTNODE ptr, byval sym as FBSYMBOL ptr )

declare sub hCallDtors _
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
	listInit( @ast.globinst.list, 32, len( FB_GLOBINSTANCE ), LIST_FLAGS_NOCLEAR )
	ast.globinst.ctorcnt = 0
	ast.globinst.dtorcnt = 0

end sub

''::::
sub astProcListEnd( )

	ast.globinst.dtorcnt = 0
	ast.globinst.ctorcnt = 0
	listEnd( @ast.globinst.list )

	''
	ast.proc.head = NULL
	ast.proc.tail = NULL
	ast.proc.curr = NULL

end sub

private function hNewProcNode( ) as ASTNODE ptr
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

private sub hDelProcNode( byval n as ASTNODE ptr )
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
		astScopeAllocLocals(symbGetProcSymbTbHead(sym))
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

		'' Emit static local variables
		irProcAllocStaticVars( symbGetProcSymbTbHead( sym ) )
    end if

    '' del symbols from hash and symbol tb's
    symbDelSymbolTb( @sym->proc.symtb, FALSE )

    ''
    symbNestEnd( FALSE )

	hDelProcNode( p )

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
				if( symbGetIsAccessed( sym ) = FALSE ) then
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

private function astUpdate( byval n as ASTNODE ptr ) as ASTNODE ptr
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

	'' Turn TYPEINI trees into real assignments
	'' Note: This can allocate temporary variables, so it must be done
	'' while in the proper scope context!
	n = astTypeIniUpdate( n )

	'' Tree optimizations, including FIELD removal and bitfield updating
	n = astOptimizeTree( n )

	'' Assignment optimizations
	n = astOptAssignment( n )

	'' Update string '+' BOPs to 'fb_StrConcat' CALLs
	n = astUpdStrConcat( n )

	'' Destroy temporaries if needed
	if( ast.flushdtorlist ) then
		n = astDtorListFlush( n, TRUE )
	end if

	function = n
end function

function astAdd( byval n as ASTNODE ptr ) as ASTNODE ptr
	n = astUpdate( n )
	if( n = NULL ) then
		return NULL
	end if

	'' Link the tree into the procedure's statement list
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

#if __FB_DEBUG__
private function hNodeIsFromCurrentProc( byval n as ASTNODE ptr ) as integer
	dim as ASTNODE ptr i = any

	i = ast.proc.curr->l
	while( i )

		if( i = n ) then
			function = TRUE
			exit while
		end if

		i = i->next
	wend
end function
#endif

function astAddAfter _
	( _
		byval n as ASTNODE ptr, _
		byval ref as ASTNODE ptr _
	) as ASTNODE ptr

	n = astUpdate( n )
	if( n = NULL ) then
		return NULL
	end if

	if( ref ) then
		assert( hNodeIsFromCurrentProc( ref ) )

		'' Insert behind this reference node in the current procedure
		n->prev = ref
		n->next = ref->next
		if( ref->next ) then
			if( ref->next->prev ) then
				ref->next->prev = n
			end if
		else
			assert( ast.proc.curr->r = ref )
			ast.proc.curr->r = n
		end if
		ref->next = n
	else
		'' Insert at the top of the current procedure
		n->prev = NULL
		n->next = ast.proc.curr->l
		if( ast.proc.curr->l ) then
			ast.proc.curr->l->prev = n
		else
			assert( ast.proc.curr->r = NULL )
			ast.proc.curr->r = n
		end if
		ast.proc.curr->l = n
	end if

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

function astFindFirstCode( byval proc as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr i = any

	assert( proc->class = AST_NODECLASS_PROC )

	i = proc->l
	while( i )
		'' Skip over nodes that don't represent executable code
		select case( i->class )
		case AST_NODECLASS_NOP, AST_NODECLASS_LABEL, _
		     AST_NODECLASS_DECL, AST_NODECLASS_LIT, _
		     AST_NODECLASS_DATASTMT, AST_NODECLASS_DBG _

		case else
			exit while
		end select

		i = i->next
	wend

	function = i
end function

sub astProcBegin( byval sym as FBSYMBOL ptr, byval ismain as integer )
	dim as ASTNODE ptr n = any

	n = hNewProcNode( )

	symbSymbTbInit( sym->proc.symtb, sym )

	symbProcAllocExt( sym )

	'' File name where the procedure body was found
	sym->proc.ext->dbg.incfile = env.inf.incfile

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

	n->sym = sym
	n->block.proc.ismain = ismain
	n->block.parent = NULL
	n->block.inistmt = parser.stmt.cnt
	n->block.breaklist.head = NULL
	n->block.breaklist.tail = NULL
	n->block.proc.decl_last = NULL

	irProcBegin( sym )

	' Don't allocate anything for a naked function, because they will be allowed
	' at ebp-N, which won't exist, no result is needed either
	if( symbIsNaked( sym ) = FALSE ) then
		'' alloc parameters
		hDeclProcParams( sym )

		'' alloc result local var
		if( symbGetType( sym ) <> FB_DATATYPE_VOID ) then
			symbAddProcResult( sym )
		end if
	end if

	'' local error handler
	with sym->proc.ext->err
		.lasthnd = NULL
		.lastmod = NULL
		.lastfun = NULL
	end with

	sym->proc.ext->stmtnum = parser.stmt.cnt

	'' main()?
	if( symbGetIsMainProc( sym ) ) then
		dim as FBSYMBOL ptr argc = any, argv = any

		assert( symbGetProcParams( sym ) = 2 )
		argc = symbGetProcHeadParam( sym )
		argv = symbGetProcTailParam( sym )

		'' fb_Init( argc, argv )
		'' (plus some other calls depending on -exx etc.)
		env.main.initnode = rtlInitApp( _
			astNewVAR( symbGetParamVar( argc ) ), _
			astNewVAR( symbGetParamVar( argv ) ) )
	end if

	'' Label at beginning of lexical block, used by debug stabs output
	astAdd( astNewLABEL( n->block.initlabel ) )
end sub

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
			astAdd( rtlErrorSetFuncName( NULL, astNewVAR( .lastfun ) ) )
           	.lastfun = NULL
		end if

		if( .lastmod <> NULL ) then
			astAdd( rtlErrorSetModName( NULL, astNewVAR( .lastmod ) ) )
			.lastmod = NULL
		end if

		if( .lasthnd <> NULL ) then
			rtlErrorSetHandler( astNewVAR( .lasthnd ), FALSE )
			.lasthnd = NULL
		end if
	end with

	function = head_node

end function

private function hCallResultCtor _
	( _
		byval head_node as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr res = any, defctor = any

	'' UDT with default ctor? (if there is none, nothing needs to be done)
	defctor = symbGetCompDefCtor( symbGetSubtype( sym ) )
	if( defctor = NULL ) then
		'' No default ctor, but others? Must show an error, because we
		'' cannot leave the result unconstructed. It would be nicer to
		'' detect & show this error at the top of the function already,
		'' but that's not possible because of RETURN which doesn't
		'' require a defctor...
		if( symbHasCtor( sym ) ) then
			errReport( FB_ERRMSG_RESULTHASNODEFCTOR )
		end if
		return head_node
	end if

	res = symbGetProcResult( sym )
	if( res = NULL ) then
		return head_node
	end if

	function = astAddAfter( astBuildCtorCall( symbGetSubtype( sym ), _
	                                          astBuildProcResultVar( sym, res ) ), _
	                        head_node )
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

function astProcEnd( byval callrtexit as integer ) as integer
    static as integer rec_cnt = 0
	dim as integer res = any, do_flush = any, enable_implicit_code = any
    dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr n = any

	n = ast.proc.curr
	rec_cnt += 1
	sym = n->sym
	n->block.endstmt = parser.stmt.cnt

	'' No implicit code should be added for naked functions -- i.e. no stack
	'' frame setup, no function result, no error checking, no profiling.
	'' (Any calls would "trash" the stack)
	'' No need to worry about any "explicit" code though (any statements),
	'' including local variables and possibly resulting destructor calls;
	'' they are "the coders fault", not ours.
	enable_implicit_code = not symbIsNaked( sym )

	if( errGetCount( ) = 0 ) then
		'' Constructor?
		if( symbIsConstructor( sym ) and enable_implicit_code ) then
			'' No constructor initialization code yet? (constructor chaining)
			if( symbGetIsCtorInited( sym ) = FALSE ) then
				symbSetIsCtorInited( sym )
				'' Add constructor initialization code
				hCallCtors( n, sym )
			end if
		end if

		astScopeDestroyVars(symbGetProcSymbTb(sym).tail)
	end if

   	''
   	astAdd( astNewLABEL( n->block.exitlabel ) )

	'' Check for any undefined labels (labels can be forward references)
	res = (symbCheckLabels(symbGetProcSymbTbHead(parser.currproc)) = 0)

	if( res ) then
		'' Destructor?
		if( symbIsDestructor( sym ) and enable_implicit_code ) then
			'' Call destructors, behind the exit label, so they'll
			'' always be called, even with early returns.
			hCallDtors( sym )
		end if

		'' update proc's breaks list, adding calls to destructors when needed
		if( n->block.breaklist.head <> NULL ) then
			res = astScopeUpdBreakList( n )
		end if

		'' gosub used?
		astGosubAddExit( sym )

		dim as ASTNODE ptr head_node = n->l

		if( enable_implicit_code ) then
			head_node = hCallProfiler( head_node )
			head_node = hCheckErrHnd( head_node, sym )
		end if

		'' if main(), END 0 must be called because it's not safe to return to crt if
		'' an ON ERROR module-level handler was called while inside some proc
		if( callrtexit ) then
			if( n->block.proc.ismain ) then
				rtlExitApp( NULL )
			end if
		end if

		if( enable_implicit_code ) then
			'' if it's a function, load result
			if( symbGetType( sym ) <> FB_DATATYPE_VOID ) then
				select case symbGetType( sym )
				case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
					'' Add result ctor call to the top of the function,
					'' a) if FUNCTION= (and/or EXIT FUNCTION) was used,
					'' b) or if neither FUNCTION= nor RETURN was used,
					'' but not if RETURN was used, because that already
					'' calls the copy ctor at every RETURN.
					'' This way the result will be constructed properly,
					'' even if nothing was explicitly returned.
					if( symbGetProcStatAssignUsed( sym ) or _
					    (not symbGetProcStatReturnUsed( sym )) ) then
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
	if( res and (errGetCount( ) = 0) ) then
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

private function hDeclProcParams( byval proc as FBSYMBOL ptr ) as integer
    dim as integer i = any
    dim as FBSYMBOL ptr p = any

	function = FALSE

	'' proc returns an UDT?
	if( symbGetType( proc ) = FB_DATATYPE_STRUCT ) then
		'' create an hidden arg if needed
		symbAddProcResultParam( proc )
	end if

	i = 1
	p = symbGetProcLastParam( proc )
	do while( p <> NULL )
		if( p->param.mode <> FB_PARAMMODE_VARARG ) then
			p->param.var = symbAddVarForParam( p )
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
		n = rtlStrAllocTmpResult( astNewVAR( s ) )

		if( env.clopt.backend = FB_BACKEND_GCC ) then
			n = astNewLOAD( n, dtype, TRUE )
		end if

	'' UDT? use the real type (UDT ptr when returning on stack, or integer etc. when returning in regs)
	case FB_DATATYPE_STRUCT
		dtype = symbGetProcRealType( proc )

		'' integers shouldn't have subtype set to anything,
		'' but it must be kept for struct ptrs
		if( typeGetDtOnly( dtype ) <> FB_DATATYPE_STRUCT ) then
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

private function hCallCtorList _
	( _
		byval is_ctor as integer, _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr cnt = any, label = any, iter = any, subtype = any
	dim as ASTNODE ptr fldexpr = any, tree = any
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

	cnt = symbAddTempVar( FB_DATATYPE_INTEGER, NULL, FALSE )
	label = symbAddLabel( NULL )
	iter = symbAddTempVar( typeAddrOf( dtype ), subtype, FALSE )

	'' Instance?
	if( fld <> NULL ) then
		if( is_ctor ) then
			'' iter = @this.field(0)
			fldexpr = astBuildInstPtr( this_, fld )
		else
			'' iter = @this.field(elements-1)
			fldexpr = astBuildInstPtr( this_, fld, astNewCONSTi( elements - 1 ) )
		end if
	else
		if( is_ctor ) then
			'' iter = @symbol(0)
			fldexpr = astBuildVarField( this_, NULL, 0 )
		else
			'' iter = @symbol(0) + (elements - 1)
			fldexpr = astBuildVarField( this_, NULL, (elements - 1) * symbGetLen( subtype ) )
		end if
	end if

	tree = astBuildVarAssign( iter, astNewADDROF( fldexpr ) )

	'' for cnt = 0 to symbGetArrayElements( fld )-1
	tree = astBuildForBegin( tree, cnt, label, 0 )

	if( is_ctor ) then
		'' ctor( *iter )
		tree = astNewLINK( tree, astBuildCtorCall( subtype, astBuildVarDeref( iter ) ) )
	else
		'' dtor( *iter )
		tree = astNewLINK( tree, astBuildDtorCall( subtype, astBuildVarDeref( iter ) ) )
	end if

	'' iter += 1
	tree = astNewLINK( tree, astBuildVarInc( iter, iif( is_ctor, 1, -1 ) ) )

	'' next
	tree = astBuildForEnd( tree, cnt, label, 1, astNewCONSTi( elements ) )

	function = tree
end function

private function hCallFieldCtor _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	) as ASTNODE ptr

	'' Do not initialize?
	if( symbGetDontInit( fld ) ) then
		exit function
	end if

	'' has a default ctor too?
	if( symbHasDefCtor( fld ) ) then
		'' !!!FIXME!!! assuming only static arrays will be allowed in fields

		'' not an array?
		if( (symbGetArrayDimensions( fld ) = 0) or _
		    (symbGetArrayElements( fld ) = 1) ) then
			'' ctor( this.field )
			function = astBuildCtorCall( symbGetSubtype( fld ), astBuildInstPtr( this_, fld ) )
		'' array..
		else
			function = hCallCtorList( TRUE, this_, fld )
		end if

		exit function
	end if

	'' bitfield?
	if( symbGetType( fld ) = FB_DATATYPE_BITFIELD ) then
		function = astNewASSIGN( astBuildInstPtr( this_, fld ), _
		                         astNewCONSTi( 0, FB_DATATYPE_UINT ) )
	else
		function = astNewMEM( AST_OP_MEMCLEAR, _
		                      astBuildInstPtr( this_, fld ), _
		                      astNewCONSTi( symbGetLen( fld ) * symbGetArrayElements( fld ) ) )
	end if
end function

private function hClearUnionFields _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval base_fld as FBSYMBOL ptr, _
		byval pfinalfield as FBSYMBOL ptr ptr _
	) as ASTNODE ptr

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

	*pfinalfield = fld

	'' clear all them at once
	function = astNewMEM( AST_OP_MEMCLEAR, _
	                      astBuildInstPtr( this_, base_fld ), _
	                      astNewCONSTi( bytes ) )
end function

private function hCallFieldCtors _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr fld = any, this_ = any
	dim as ASTNODE ptr tree = NULL

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )

	'' for each field..
	fld = symbGetCompSymbTb( parent ).head
	do while( fld <> NULL )

		if( symbIsField( fld ) ) then
			'' super class 'base' field? skip.. ctor must be called from derived class' ctor
			if( fld <> parent->udt.base ) then
				'' part of an union?
				if( symbGetIsUnionField( fld ) ) then
					tree = astNewLINK( tree, hClearUnionFields( this_, fld, @fld ) )
					'' skip next
					continue do
				else
					'' not initialized?
					if( symbGetTypeIniTree( fld ) = NULL ) then
						tree = astNewLINK( tree, hCallFieldCtor( this_, fld ) )
					'' flush the tree..
					else
						tree = astNewLINK( tree, _
							astTypeIniFlush( astTypeIniClone( symbGetTypeIniTree( fld ) ), _
							                 this_, AST_INIOPT_ISINI ) )
					end if
				end if
			end if
		end if

		fld = fld->next
	loop

	function = tree
end function

private function hCallBaseCtor _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr initree = any
	dim as FBSYMBOL ptr base_ = any, this_ = any, subtype = any, defctor = any

	base_ = parent->udt.base

	'' No base UDT? Then there's nothing to do.
	if( base_ = NULL ) then
		exit function
	end if

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )

	'' Do we have a BASE() ctorcall/initializer?
	initree = proc->proc.ext->base_initree
	if( initree ) then
		proc->proc.ext->base_initree = NULL
		return astTypeIniFlush( initree, this_, AST_INIOPT_ISINI )
	end if

	subtype = symbGetSubtype( base_ )
	defctor = symbGetCompDefCtor( subtype )

	'' Otherwise, try to call a default ctor, if any
	if( defctor ) then
		'' Check access here, because (unlike fields) it's not done
		'' during the TYPE compound parsing
		if( symbCheckAccess( defctor ) = FALSE ) then
			errReport( FB_ERRMSG_NOACCESSTOBASEDEFCTOR )
		end if
	'' No default ctor, but others? Then BASE() should have been used,
	'' since a ctor must be called, but we cannot do it automatically.
	elseif( symbGetCompCtorHead( subtype ) ) then
		errReport( FB_ERRMSG_NOBASEINIT )
	end if

	function = hCallFieldCtor( this_, base_ )
end function

private function hInitVptr _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr

	'' Only if there is a vptr
	if( symbGetHasRTTI( parent ) = FALSE ) then
		exit function
	end if

	'' The vtable must be present/known for this
	assert( parent->udt.ext->vtable )

	var this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )

	'' this.vptr = cast( any ptr, (cast(byte ptr, @vtable) + sizeof(void *) * 2) )
	'' assuming that everything with a vptr extends fb_Object
	'' Also, x86 assumption
	function = astNewASSIGN( _ 
		astBuildInstPtr( this_, symbUdtGetFirstField( symb.rtti.fb_object ) ), _
		astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, _
			astNewADDROF( astNewVAR( parent->udt.ext->vtable, FB_POINTERSIZE*2, FB_DATATYPE_INTEGER ) ) ) )
end function

private sub hCallCtors( byval n as ASTNODE ptr, byval sym as FBSYMBOL ptr )
	dim as ASTNODE ptr tree = any
	dim as FBSYMBOL ptr parent = any

	parent = symbGetNamespace( sym )

	'' 1st) base ctor
	tree = hCallBaseCtor( parent, sym )

	'' 2nd) field ctors
	tree = astNewLINK( tree, hCallFieldCtors( parent, sym ) )

	'' 3rd) setup the vtable ptr
	tree = astNewLINK( tree, hInitVptr( parent, sym ) )

	'' Find the first statement that is executable code,
	'' and insert the constructor calls above it.
	n = astFindFirstCode( n )
	if( n ) then
		n = n->prev
	end if
	astAddAfter( tree, n )
end sub

private sub hCallFieldDtor _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	)

	if( symbGetType( fld ) = FB_DATATYPE_STRING ) then
		var fldexpr = astBuildInstPtr( this_, fld )

		'' assuming fields cannot be dynamic arrays

		'' not an array?
		if( (symbGetArrayDimensions( fld ) = 0) or _
		    (symbGetArrayElements( fld ) = 1) ) then
			astAdd( rtlStrDelete( fldexpr ) )
		else
			astAdd( rtlArrayErase( fldexpr, FALSE, FALSE ) )
		end if
	else
		'' UDT field with dtor?
		if( symbHasDtor( fld ) ) then
			'' not an array?
			if( (symbGetArrayDimensions( fld ) = 0) or _
			    (symbGetArrayElements( fld ) = 1) ) then
				'' dtor( this.field )
				astAdd( astBuildDtorCall( symbGetSubtype( fld ), astBuildInstPtr( this_, fld ) ) )
			else
				astAdd( hCallCtorList( FALSE, this_, fld ) )
			end if
		end if
	end if

end sub

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
			if( fld <> parent->udt.base ) Then
				hCallFieldDtor( this_, fld )
			end if
		end if

		fld = fld->prev
	loop

end sub

private sub hCallBaseDtor _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr base_ = any, dtor = any, this_ = any

	base_ = parent->udt.base

	'' No base UDT? Then there's nothing to do.
	if( base_ = NULL ) then
		exit sub
	end if

	'' Call its dtor, if there is any.
	''
	'' Note: As in C++, the base class' destructor implementation is called
	'' from this derived class destructor, and no vtable lookup is done
	'' for this (it would just result in infinite recursion anyways).
	''
	'' Just like derived classes are not responsible for initializing their
	'' base class, they shouldn't be made responsible for cleaning it up.

	dtor = symbGetCompDtor( symbGetSubtype( base_ ) )
	if( dtor = NULL ) then
		exit sub
	end if

	'' Check access here, because (unlike fields) it's not done
	'' during the TYPE compound parsing
	if( symbCheckAccess( dtor ) = FALSE ) then
		errReport( FB_ERRMSG_NOACCESSTOBASEDTOR )
	end if

	'' The only exception is if the base class' destructor is ABSTRACT,
	'' then there is no implementation to call.
	if( symbIsAbstract( dtor ) ) then
		exit sub
	end if

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )
	astAdd( astBuildDtorCall( symbGetSubtype( base_ ), _
				astBuildInstPtr( this_, base_ ), _
				TRUE ) )
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

	'' 2nd) base dtor
	hCallBaseDtor( parent, proc )

end sub

'':::::
private sub hCallStaticCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr _
	)

	'' ctor?
	if( initree <> NULL ) then
		astAdd( astTypeIniFlush( initree, sym, AST_INIOPT_ISINI or AST_INIOPT_RELINK ) )
		exit sub
	end if

	'' dynamic?
	if( symbIsDynamic( sym ) ) then
		astAdd( rtlArrayErase( astBuildVarField( sym, NULL, 0 ), TRUE, FALSE ) )
	else
		'' not an array?
		if( (symbGetArrayDimensions( sym ) = 0) or _
		    (symbGetArrayElements( sym ) = 1) ) then
			'' dtor( var )
			astAdd( astBuildDtorCall( symbGetSubtype( sym ), astBuildVarField( sym, NULL, 0 ) ) )
		else
			astAdd( hCallCtorList( FALSE, sym, NULL ) )
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
		astProcBegin( wrap->proc, FALSE )
		n = ast.proc.curr

        '' call the dtor
        hCallStaticCtor( wrap->sym, NULL )

		astProcEnd( FALSE )

		'' must be flushed before the proc that has the static vars, because
		'' they will be removed from hash and symbols table right-after that
		'' proc is flushed
		hProcFlush( n, TRUE )

    	wrap = listGetNext( wrap )
    loop

    '' destroy list
    listEnd( dtorlist )
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
		dtorlist = xcallocate( len( TLIST ) )
		parser.currproc->proc.ext->statdtor = dtorlist

		listInit( dtorlist, 16, len( FB_DTORWRAPPER ), LIST_FLAGS_NOCLEAR )
	end if

    ''
    wrap = listNewNode( dtorlist )

	proc = symbAddProc( symbPreAddProc( NULL ), symbUniqueLabel( ), NULL, FB_DATATYPE_VOID, NULL, _
	                    FB_SYMBATTRIB_PRIVATE, FB_FUNCMODE_CDECL, FB_SYMBOPT_DECLARING )

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

private sub hGlobCtorBegin( byval is_ctor as integer )
	dim as FBSYMBOL ptr proc = any

	'' sub ctorname|dtorname cdecl( ) constructor|destructor
	proc = symbAddProc( symbPreAddProc( NULL ), symbUniqueLabel( ), _
	                    iif( is_ctor, @FB_GLOBCTORNAME, @FB_GLOBDTORNAME ), _
	                    FB_DATATYPE_VOID, NULL, FB_SYMBATTRIB_PRIVATE, _
	                    FB_FUNCMODE_CDECL, FB_SYMBOPT_DECLARING )

	if( is_ctor ) then
		symbAddGlobalCtor( proc )
	else
		symbAddGlobalDtor( proc )
	end if
	symbSetIsAccessed( proc )
	symbSetIsParsed( proc )

	astProcBegin( proc, FALSE )
end sub

private sub hGenGlobalInstancesCtor( )
	dim as FB_GLOBINSTANCE ptr inst = any
	dim as FBSYMBOL ptr sym = any

    '' any global instance with ctors?
    if( ast.globinst.ctorcnt > 0 ) then
		'' sub ctor cdecl( ) constructor
		hGlobCtorBegin( TRUE )

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

		'' end sub
		astProcEnd( FALSE )
    end if

    '' any global instance with dtors?
    if( ast.globinst.dtorcnt > 0 ) then
		'' sub dtor cdecl( ) destructor
		hGlobCtorBegin( FALSE )

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

		'' end sub
		astProcEnd( FALSE )
    end if

    '' list will be deleted by astProcListEnd( )
end sub
