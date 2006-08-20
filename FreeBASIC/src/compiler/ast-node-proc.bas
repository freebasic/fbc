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
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

declare function 	hNewProcNode		( ) as ASTNODE ptr

declare function 	hModLevelIsEmpty	( byval p as ASTNODE ptr ) as integer

declare sub 		hModLevelAddRtInit	( byval p as ASTNODE ptr )

declare sub 		hLoadProcResult 	( byval proc as FBSYMBOL ptr )

declare function 	hDeclProcParams		( byval proc as FBSYMBOL ptr ) as integer

declare function 	hUpdScopeBreakList	( byval n as ASTNODE ptr ) as integer

''::::
sub astProcListInit( )

	ast.proc.head = NULL
	ast.proc.tail = NULL
	ast.proc.curr = NULL
    ast.proc.oldsymtb = NULL

end sub

''::::
sub astProcListEnd( )

	ast.proc.head = NULL
	ast.proc.tail = NULL
	ast.proc.curr = NULL
	ast.proc.oldsymtb = NULL

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
	) static

    dim as ASTNODE ptr n, nxt
    dim as FBSYMBOL ptr sym

	''
	ast.proc.curr = p
	ast.currblock = p
	ast.doemit = doemit

	sym = p->sym

	env.scope = iif( p->block.ismain, FB_MAINSCOPE, FB_MAINSCOPE+1 )
	env.currproc = sym
	env.currblock = sym
	symbSetCurrentSymTb( @sym->proc.symtb )

	'' allocate the non-static local variables on stack
	symbProcAllocLocalVars( sym )

	'' add a call to fb_init if it's a static constructor
	'' (note: must be done here or ModLevelIsEmpty() will fail)
	if( doemit ) then
		if( symbIsConstructor( sym ) ) then
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
    symbProcAllocStaticVars( symbGetProcLocTbHead( sym ) )

    '' del symbols from hash and symbol tb's
    symbDelSymbolTb( @sym->proc.symtb, FALSE )

	''
	hDelProcNode( p )

	''
	ast.doemit = TRUE

end sub

''::::
private sub hProcFlushAll( ) static
    dim as ASTNODE ptr n
    dim as integer doemit
    dim as FBSYMBOL ptr sym

	'' procs should be sorted by include file

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
				elseif( symbIsModLevelProc( sym ) ) then
					doemit = (hModLevelIsEmpty( n ) = FALSE)
				end if
			end if

		else
			doemit = FALSE
		end if

		hProcFlush( n, doemit )
	loop

end sub

''::::
sub astAdd _
	( _
		byval n as ASTNODE ptr _
	) static

	if( n = NULL ) then
		exit sub
	end if

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

end sub

''::::
sub astAddAfter _
	( _
		byval n as ASTNODE ptr, _
		byval p as ASTNODE ptr _
	) static

	if( (p = NULL) or (n = NULL) ) then
		exit sub
	end if

	'' note: this function can't be used if node contains
	'' type-ini tree or strings assignment/concatenations

	''
	if( p->next = NULL ) then
		ast.proc.curr->r = n
	else
		p->next->prev = n
	end if

	n->prev = p
	n->next = p->next
	p->next = n

end sub

''::::
sub astAddBefore _
	( _
		byval n as ASTNODE ptr, _
		byval p as ASTNODE ptr _
	) static

	if( (p = NULL) or (n = NULL) ) then
		exit sub
	end if

	'' note: this function can't be used if node contains
	'' type-ini tree or strings assignment/concatenations

	''
	if( p->prev = NULL ) then
		ast.proc.curr->l = n
	else
		p->prev->next = n
	end if

	n->next = p
	n->prev = p->prev
	p->prev = n

end sub

''::::
sub astAddDecl _
	( _
		byval n as ASTNODE ptr _
	) static

	dim as ASTNODE ptr last

	if( n = NULL ) then
		exit sub
	end if

	last = ast.proc.curr->block.decl_last
	if( last = NULL ) then
		last = ast.proc.curr->l
	end if

	if( last = NULL ) then
		astAdd( n )
	else
		astAddAfter( n, last )
	end if

	ast.proc.curr->block.decl_last = n

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
	) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as FBSYMBOL ptr ns

	function = NULL

	'' alloc new node
	n = hNewProcNode( )
	if( n = NULL ) then
		exit function
	end if

	''
	symbSymTbInit( @sym->proc.symtb, sym )

	''
	if( sym->proc.ext = NULL ) then
		sym->proc.ext = callocate( len( FB_PROCEXT ) )
	end if

	''
	ast.proc.curr = n
	ast.currblock = n

	env.scope = iif( ismain, FB_MAINSCOPE, FB_MAINSCOPE+1 )
	env.currproc = sym
	env.currblock = sym

	ast.proc.oldsymtb = symbGetCurrentSymTb( )
	symbSetCurrentSymTb( @sym->proc.symtb )

	'' proc body can be declared outside the original namespace
	'' if the prototype was declared inside one (as in C++), so
	'' change the hashtb too
	ns = symbGetNamespace( sym )
	if( ns <> symbGetCurrentNamespc( ) ) then
		symbNamespaceInsertChain( ns )

		ast.proc.oldns = symbGetCurrentNamespc( )
		symbSetCurrentNamespc( ns )

		ast.proc.oldhashtb = symbGetCurrentHashTb( )
		symbSetCurrentHashTb( @symbGetNamespaceHashTb( ns ) )

	else
		ast.proc.oldns = NULL
	end if

	'' add init and exit labels (see the note in the top,
	'' procs don't create an implicit scope block)
	n->block.initlabel = symbAddLabel( NULL, TRUE )
	n->block.exitlabel = symbAddLabel( NULL, FALSE )

	''
	n->sym = sym

	n->block.ismain = ismain
	n->block.parent = NULL
	n->block.inistmt = env.stmtcnt

	'' break list
	n->block.breaklist.head = NULL
	n->block.breaklist.tail = NULL

	''
	n->block.decl_last = NULL

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

	sym->proc.ext->stmtnum = env.stmtcnt

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
function astProcEnd _
	( _
		byval n as ASTNODE ptr, _
		byval callrtexit as integer _
	) as integer static

    dim as integer res
    dim as FBSYMBOL ptr sym

	sym = n->sym

	n->block.endstmt = env.stmtcnt

	'' del dynamic arrays and all var-len strings (see the note in
	'' the top, procs don't create an implicit scope block)
	symbFreeLocalDynVars( sym )

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
			if( n->block.ismain ) then
				rtlExitApp( NULL )
			end if
		end if

		'' if it's a function, load result
		if( symbGetType( sym ) <> FB_DATATYPE_VOID ) then
        	hLoadProcResult( sym )
		end if
	end if

	''
	irProcEnd( sym )

	if( (res = TRUE) and (errGetCount( ) = 0) ) then
		symbSetIsParsed( sym )

		if( n->block.ismain = FALSE ) then
			'' not private or inline? flush it..
			if( symbIsPrivate( sym ) = FALSE ) then
				hProcFlush( n, TRUE )

			'' remove from hash tb only
			else
				symbDelSymbolTb( @sym->proc.symtb, TRUE )
			end if

		'' main? flush all remaining, it's the latest
		else
			hProcFlushAll( )

		end if

	'' errors.. just remove from hash so no false dups will appear
	else
		symbDelSymbolTb( @sym->proc.symtb, TRUE )
	end if

	'' back to main (or NULL if main was emitted already)
	ast.proc.curr = ast.proc.head
	ast.currblock = ast.proc.head

    env.scope = FB_MAINSCOPE
    env.currproc = env.main.proc
    env.currblock = env.main.proc

	'' was the namespace changed? see procBegin()
	if( ast.proc.oldns <> NULL ) then
		symbNamespaceRemoveChain( symbGetCurrentNamespc( ) )

		symbSetCurrentHashTb( ast.proc.oldhashtb )
		symbSetCurrentNamespc( ast.proc.oldns )

		ast.proc.oldns = NULL
	end if

	symbSetCurrentSymTb( ast.proc.oldsymtb )

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
	'' (note: when debugging it will be emmited even if empty)

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


