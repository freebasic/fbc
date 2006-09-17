''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.

''
'' AST proc body nodes
'' l = head node; r = tail node
''
'' note: an implicit scope block isn't created, because the
''		 implicit main() function (inside scope blocks only
''		 non-decl statements are allowed)
''


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\lex.bi"
#include once "inc\parser.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"

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

declare sub hModLevelAddRtInit _
	( _
		byval p as ASTNODE ptr _
	)

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
	symbNestBegin( sym )

	'' allocate the non-static local variables on stack
	symbProcAllocLocalVars( sym )

	'' add a call to fb_init if it's a static/global constructor
	'' (note: must be done here or ModLevelIsEmpty() will fail)
	if( doemit ) then
		'' global ctor?
		if( symbGetIsGlobalCtor( sym ) ) then
           	hModLevelAddRtInit( p )
		end if
	end if

	''
	if( ast.doemit ) then
		irEmitPROCBEGIN( sym, p->block.initlabel )
	end if

	'' flush nodes
	n = p->l
	do while( n <> NULL )
		nxt = n->next
		astLoad( n )
		astDelNode( n )
		n = nxt
	loop

    ''
    if( ast.doemit ) then
    	irEmitPROCEND( sym, p->block.initlabel, p->block.exitlabel )
    end if

    '' emit static local variables
    emitProcAllocStaticVars( symbGetProcSymbTbHead( sym ) )

    '' del symbols from hash and symbol tb's
    symbDelSymbolTb( @sym->proc.symtb, FALSE )

    ''
    symbNestEnd( )

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

	if( n = NULL ) then
		return NULL
	end if

	hCheckCtor( n )

	'' do updates and optimizations now as they can
	'' allocate new vars and create/delete nodes
	n = astTypeIniUpdate( n )
	n = astOptimize( n )
	n = astOptAssignment( n )
	n = astUpdStrConcat( n )

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
		byval p as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr _tail = any, _next = any

	if( (p = NULL) or (n = NULL) ) then
		return NULL
	end if

	_tail = ast.proc.curr->r
	ast.proc.curr->r = p

	_next = p->next
	p->next = NULL

	n = astAdd( n )

	if( _next <> NULL ) then
		_next->prev = n
		n->next = _next
		ast.proc.curr->r = _tail
	end if

	function = n

end function

''::::
sub astAddUnscoped _
	( _
		byval n as ASTNODE ptr _
	) static

	dim as ASTNODE ptr last

	if( n = NULL ) then
		exit sub
	end if

	last = ast.proc.curr->block.proc.decl_last
	if( last = NULL ) then
		last = ast.proc.curr->l
	end if

	if( last = NULL ) then
		n = astAdd( n )
	else
		n = astAddAfter( n, last )
	end if

	ast.proc.curr->block.proc.decl_last = n

end sub

'':::::
private function hNewProcNode _
	(  _
		_
	) as ASTNODE ptr static

	dim as ASTNODE ptr n

	n = astNewNode( AST_NODECLASS_PROC, INVALID, NULL )

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
		sym->proc.ext = callocate( len( FB_PROCEXT ) )
	end if

	''
	ast.proc.curr = n
	ast.currblock = n

	parser.scope = iif( ismain, FB_MAINSCOPE, FB_MAINSCOPE+1 )
	parser.currproc = sym
	parser.currblock = sym

	symbNestBegin( sym )

	'' add init and exit labels (see the note in the top,
	'' procs don't create an implicit scope block)
	n->block.initlabel = symbAddLabel( NULL, TRUE )
	n->block.exitlabel = symbAddLabel( NULL, FALSE )

	''
	n->sym = sym

	n->block.proc.ismain = ismain
	n->block.parent = NULL
	n->block.inistmt = parser.stmtcnt

	'' break list
	n->block.breaklist.head = NULL
	n->block.breaklist.tail = NULL

	''
	n->block.proc.decl_last = NULL

	''
	irProcBegin( sym )

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

	'' local error handler
	with sym->proc.ext->err
		.lasthnd = NULL

		if( env.clopt.extraerrchk ) then
			rtlErrorSetModName( sym, astNewCONSTstr( @env.inf.name ) )
			rtlErrorSetFuncName( sym, astNewCONSTstr( symbGetName( sym ) ) )
		else
			.lastmod = NULL
			.lastfun = NULL
		end if
	end with

	sym->proc.ext->stmtnum = parser.stmtcnt

	function = n

end function

'':::::
private sub hRestoreErrHnd _
	( _
		byval sym as FBSYMBOL ptr _
	) static

	with sym->proc.ext->err
		if( .lastfun <> NULL ) then
           	rtlErrorSetFuncName( NULL, _
           						 astNewVAR( .lastfun, _
           								    0, _
           								    FB_DATATYPE_POINTER+FB_DATATYPE_CHAR ) )
           	.lastfun = NULL
		end if

		if( .lastmod <> NULL ) then
           	rtlErrorSetModName( NULL, _
           						astNewVAR( .lastmod, _
           								   0, _
           								   FB_DATATYPE_POINTER+FB_DATATYPE_CHAR ) )

			.lastmod = NULL
		end if

		if( .lasthnd <> NULL ) then
       		rtlErrorSetHandler( astNewVAR( .lasthnd, _
       					  	  			   0, _
       					  	  			   FB_DATATYPE_POINTER+FB_DATATYPE_VOID ), _
       							FALSE )
			.lasthnd = NULL
		end if
	end with

end sub

'':::::
private sub hCallResultCtor _
	( _
		byval n as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr _
	) static

    dim as FBSYMBOL ptr res, subtype

    subtype = symbGetSubtype( sym )

    if( symbGetCompDefCtor( subtype ) = NULL ) then
    	exit sub
    end if

    res = symbGetProcResult( sym )
    if( res = NULL ) then
    	exit sub
    end if

    astAddAfter( astBuildCtorCall( subtype, _
    							   astBuildProcResultVar( sym, res ) ), _
    			 n->l )

end sub

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

	n->block.endstmt = parser.stmtcnt

	if( errGetCount( ) = 0 ) then
		'' if the function body is empty, no ctor initialization will be done
		hCheckCtor( n )

		'' del dynamic arrays and all var-len strings (see the note in
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
		'' update proc's breaks list, adding calls to destructors
		'' when needed
		if( n->block.breaklist.head <> NULL ) then
			res = astScopeUpdBreakList( n )
		end if

		'' restore the old error handler if any was set
		hRestoreErrHnd( sym )

		'' if main(), END 0 must be called because it's not safe to return to crt if
		'' an ON ERROR module-level handler was called while inside some proc
		if( callrtexit ) then
			if( n->block.proc.ismain ) then
				rtlExitApp( NULL )
			end if
		end if

		'' if it's a function, load result
		if( symbGetType( sym ) <> FB_DATATYPE_VOID ) then

			select case symbGetType( sym )
			case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
				if( symbGetProcStatAssignUsed( sym ) ) then
					hCallResultCtor( n, sym )
				end if
			end select

        	hLoadProcResult( sym )
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

	'' errors.. just remove from hash so no false dups will appear
	else
		symbDelSymbolTb( @sym->proc.symtb, TRUE )
	end if

	''
	symbNestEnd( )

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
	) as integer static

    dim as integer i
    dim as FBSYMBOL ptr p

	function = FALSE

	'' proc returns an UDT?
	if( symbGetType( proc ) = FB_DATATYPE_STRUCT ) then
		'' create an hidden arg if needed
		symbAddProcResultParam( proc )
	end if

	''
	i = 1
	p = symbGetProcHeadParam( proc )
	do while( p <> NULL )

		if( p->param.mode <> FB_PARAMMODE_VARARG ) then
			p->param.var = symbAddParam( symbGetName( p ), p )
			if( p->param.var = NULL ) then
				errReportParam( proc, i, NULL, FB_ERRMSG_DUPDEFINITION )
				exit function
			end if
		end if

		p = symbGetParamNext( p )
		i += 1
	loop

	function = TRUE

end function

'':::::
private sub hLoadProcResult _
	( _
		byval proc as FBSYMBOL ptr _
	) static

    dim as FBSYMBOL ptr s
    dim as ASTNODE ptr n, t
    dim as integer dtype

	s = symbGetProcResult( proc )
	dtype = symbGetType( proc )
    n = NULL

	select case dtype

	'' if result is a string, a temp descriptor is needed, as the current one (on stack)
	'' will be trashed when the function returns (also, the string returned will be
	'' set as temp, so any assignment or when passed as parameter to another proc
	'' will deallocate this string)
	case FB_DATATYPE_STRING
		t = astNewVAR( s, 0, FB_DATATYPE_STRING )
		n = rtlStrAllocTmpResult( t )

	'' UDT? use the real type
	case FB_DATATYPE_STRUCT
		dtype = symbGetProcRealType( proc )
	end select

	if( n = NULL ) then
		n = astNewLOAD( astNewVAR( s, 0, dtype, NULL ), dtype, TRUE )
	end if

	astAdd( n )

end sub

''::::
private function hModLevelIsEmpty _
	( _
		byval p as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr n, nxt

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

''::::
private sub hModLevelAddRtInit _
	( _
		byval p as ASTNODE ptr _
	)

    dim as ASTNODE ptr n

    n = p->l
    if( n = NULL ) then
    	exit sub
    end if

	'' fb rt must be initialized before any static constructor
	'' is called but in any platform (but Windows) the .ctors
	'' list will be processed before main() is called by crt

	astAddAfter( rtlInitRt( ), n )

end sub

'':::::
private sub hCallCtorList _
	( _
		byval is_ctor as integer, _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr cnt, label, iter, subtype
	dim as ASTNODE ptr fldexpr
	dim as integer dtype, elements

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

    cnt = symbAddTempVar( FB_DATATYPE_INTEGER, NULL )
    label = symbAddLabel( NULL, TRUE )
    iter = symbAddTempVar( FB_DATATYPE_POINTER + dtype, subtype )

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

    astAdd( astBuildVarAssign( iter, astNewADDR( AST_OP_ADDROF, fldexpr ) ) )

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
	) static

	dim as FBSYMBOL ptr subtype

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

	astAdd( astNewMEM( AST_OP_MEMCLEAR, _
    	  	  		   astBuildInstPtr( this_, fld ), _
    	  	  		   NULL, _
    	  	  		   symbGetLen( fld ) * symbGetArrayElements( fld ) ) )

end sub

'':::::
private sub hFlushFieldInitTree _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr _
	) static

	dim as ASTNODE ptr initree

	initree = astCloneTree( symbGetTypeIniTree( fld ) )

	astTypeIniFlush( initree, this_, FALSE, TRUE )

end sub

'':::::
private sub hCallFieldCtors _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr fld, this_, subtype

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )

    '' for each field..
    fld = symbGetCompSymbTb( parent )->head
    do while( fld <> NULL )

		if( symbIsField( fld ) ) then
			if( symbGetTypeIniTree( fld ) = NULL ) then
				hCallFieldCtor( this_, fld )
			else
				hFlushFieldInitTree( this_, fld )
			end if
		end if

		fld = fld->next
	loop

end sub

'':::::
private sub hCallCtors _
	( _
		byval proc as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr parent

	parent = symbGetNamespace( proc )

	'' 1st) base dtors
    '' ...

	'' 2nd) base dtors
    hCallFieldCtors( parent, proc )

end sub

'':::::
private sub hCallFieldDtors _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr fld, this_

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )

    '' for each field (in inverse order)..
    fld = symbGetCompSymbTb( parent )->tail
    do while( fld <> NULL )

		'' !!!FIXME!!! assuming only static arrays will be allowed in fields

		if( symbIsField( fld ) ) then

			select case symbGetType( fld )
			case FB_DATATYPE_STRING
				dim as ASTNODE ptr fldexpr

        		fldexpr = astBuildInstPtr( this_, fld )

            	'' not an array?
            	if( (symbGetArrayDimensions( fld ) = 0) or _
            		(symbGetArrayElements( fld ) = 1) ) then

            		astAdd( rtlStrDelete( fldexpr ) )

        		'' array..
        		else
        	    	astAdd( rtlArrayStrErase( fldexpr ) )
				end if

			case FB_DATATYPE_STRUCT
            	dim as FBSYMBOL ptr subtype

            	subtype = symbGetSubtype( fld )

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

			end select
		end if

		fld = fld->prev
	loop

end sub

'':::::
private sub hCallDtors _
	( _
		byval proc as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr parent

	parent = symbGetNamespace( proc )

	'' 1st) fields dtors
    hCallFieldDtors( parent, proc )

	'' 2nd) base dtors
	'' ...

end sub

'':::::
private sub hDestroyVars _
	( _
		byval proc as FBSYMBOL ptr _
	) static

    dim as FBSYMBOL ptr s

	'' for each var (in inverse order)
	s = symbGetProcSymbTb( proc ).tail
    do while( s <> NULL )
    	'' variable?
    	if( symbGetClass( s ) = FB_SYMBCLASS_VAR ) then
			'' has a dtor?
			if( symbGetVarHasDtor( s ) ) then
				astAdd( astBuildVarDtorCall( s ) )
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
        astTypeIniFlush( initree, sym, FALSE, TRUE )
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
						FB_DATATYPE_VOID, NULL, 0, _
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

    dim as FB_GLOBINSTANCE ptr wrap

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
private function hCtorBegin _
	( _
		byval is_ctor as integer _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr proc = any
    dim as ASTNODE ptr n = any

	proc = symbAddProc( symbPreAddProc( NULL ), _
    					hMakeTmpStr( ), _
						iif( is_ctor, @FB_GLOBCTORNAME, @FB_GLOBDTORNAME ), _
						NULL, _
						FB_DATATYPE_VOID, NULL, 0, _
						FB_SYMBATTRIB_PRIVATE or FB_SYMBOPT_DECLARING, _
						FB_FUNCMODE_CDECL )

	if( is_ctor ) then
		symbSetIsGlobalCtor( proc )
    else
    	symbSetIsGlobalDtor( proc )
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

	inst = listGetHead( @ast.globinst.list )
	if( inst = NULL ) then
		exit sub
	end if

    '' any global instance with ctors?
    if( ast.globinst.ctorcnt > 0 ) then
		n = hCtorBegin( TRUE )

    	'' for each node..
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
		n = hCtorBegin( FALSE )

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

