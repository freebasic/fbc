''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
'' procedure and scope trees handling
''

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

declare function 	hNewProcNode	( byval proc as FBSYMBOL ptr ) as ASTPROCNODE ptr

declare function 	hModLevelIsEmpty( byval p as ASTPROCNODE ptr ) as integer

declare sub 		hModLevelAddRtInit( byval p as ASTPROCNODE ptr )

declare sub 		hLoadProcResult ( byval proc as FBSYMBOL ptr )

declare function 	hDeclProcArgs	( byval proc as FBSYMBOL ptr ) as integer

''::::
sub astProcListInit( )

	''
    listNew( @ast.proclist, AST_INITPROCNODES, len( ASTPROCNODE ), FALSE )

    ast.curproc = NULL
    ast.oldsymtb = NULL

end sub

''::::
sub astProcListEnd( )

	listFree( @ast.proclist )

	ast.curproc = NULL
	ast.oldsymtb = NULL

end sub

'':::::
private function hNewProcNode( byval proc as FBSYMBOL ptr ) as ASTPROCNODE ptr static
	dim as ASTPROCNODE ptr n

	n = listNewNode( @ast.proclist )

	''
	n->proc = proc
	n->head = NULL
	n->tail = NULL

	function = n

end function

'':::::
private sub hDelProcNode( byval n as ASTPROCNODE ptr ) static

	n->head = NULL
	n->tail = NULL

	listDelNode( @ast.proclist, cptr(TLISTNODE ptr, n) )

end sub

''::::
private sub hProcFlush( byval p as ASTPROCNODE ptr, _
						byval doemit as integer _
					  ) static

    dim as ASTNODE ptr n, nxt, prv
    dim as ASTNODE tmp
    dim as FBSYMBOL ptr proc, oldproc

	''
	ast.curproc = p
	ast.doemit 	= doemit

	proc = p->proc

	env.scope = iif( p->ismain, FB_MAINSCOPE, FB_MAINSCOPE+1 )
	env.currproc = proc
	symbSetLocalTb( @proc->proc.loctb )

	''
	prv = @tmp
	n = p->head
	do while( n <> NULL )
		nxt = n->next

		n = astOptimize( n )
		'' needed even when not optimizing
		n = astOptAssignment( n )
		n = astUpdStrConcat( n )

		prv->next = n
		prv = n
		n = nxt
	loop

	''
	symbAllocLocalVars( symbGetProcLocTbHead( proc ) )

	'' add a call to fb_init if it's a static constructor
	'' (note: must be done here or ModLevelIsEmpty() will fail)
	if( doemit ) then
		if( symbIsConstructor( proc ) ) then
           	hModLevelAddRtInit( p )
		end if
	end if

	''
	if( ast.doemit ) then
		irEmitPROCBEGIN( proc, p->initlabel )
	end if

	''
	n = p->head
	do while( n <> NULL )
		nxt = n->next
		astLoad( n )
		astDel( n )
		n = nxt
	loop

    ''
    if( ast.doemit ) then
    	irEmitPROCEND( proc, p->initlabel, p->exitlabel )
    end if

    '' del symbols from hash and symbol tb's
    symbDelSymbolTb( @proc->proc.loctb, FALSE )

	''
	hDelProcNode( p )

	''
	ast.doemit  = TRUE

end sub

''::::
private sub hProcFlushAll( ) static
    dim as ASTPROCNODE ptr p
    dim as integer doemit
    dim as FBSYMBOL ptr proc

	'' procs should be sorted by include file

	do
        p = listGetHead( @ast.proclist )
        if( p = NULL ) then
        	exit do
        end if

		proc = p->proc

		doemit = TRUE
		'' private?
		if( symbIsPrivate( proc ) ) then
			'' never called? skip
			if( symbGetIsCalled( proc ) = FALSE ) then
				doemit = FALSE

			'' module-level?
			elseif( symbIsModLevelProc( proc ) ) then
				doemit = (hModLevelIsEmpty( p ) = FALSE)
			end if
		end if

		hProcFlush( p, doemit )
	loop

end sub

''::::
sub astAdd( byval n as ASTNODE ptr ) static

	if( n = NULL ) then
		exit sub
	end if

	''
	if( ast.curproc->tail <> NULL ) then
		ast.curproc->tail->next = n
	else
		ast.curproc->head = n
	end if

	n->prev = ast.curproc->tail
	n->next = NULL
	ast.curproc->tail = n

end sub

''::::
sub astAddAfter( byval n as ASTNODE ptr, _
				 byval p as ASTNODE ptr _
			   ) static

	if( (p = NULL) or (n = NULL) ) then
		exit sub
	end if

	''
	if( p->next = NULL ) then
		ast.curproc->tail = n
	end if

	n->prev = p
	n->next = p->next
	p->next = n

end sub

'':::::
function astProcBegin( byval proc as FBSYMBOL ptr, _
					   byval ismain as integer _
					 ) as ASTPROCNODE ptr static

    dim as ASTPROCNODE ptr p

	function = NULL

	'' alloc new node
	p = hNewProcNode( proc )
	if( p = NULL ) then
		exit function
	end if

	p->ismain = ismain

	''
	proc->proc.loctb.head = NULL
	proc->proc.loctb.tail = NULL

	''
	env.scope = iif( ismain, FB_MAINSCOPE, FB_MAINSCOPE+1 )
	env.currproc = proc
	ast.oldsymtb = symbGetLocalTb( )
	symbSetLocalTb( @proc->proc.loctb )

	ast.curproc = p

	irProcBegin( proc )

    '' alloc args
    if( hDeclProcArgs( proc ) = FALSE ) then
    	exit function
    end if

	'' alloc result local var
	if( symbGetType( proc ) <> FB_DATATYPE_VOID ) then
		if( symbAddProcResult( proc ) = NULL ) then
			exit function
		end if
	end if

	'' add init and exit labels
	p->initlabel = symbAddLabel( NULL )
	p->exitlabel = symbAddLabel( NULL )

	function = p

end function

'':::::
sub astProcEnd( byval p as ASTPROCNODE ptr, _
			    byval callrtexit as integer ) static

    dim as FBSYMBOL ptr proc
    dim as integer issub

	proc = p->proc

	issub = (symbGetType( proc ) = FB_DATATYPE_VOID)

	'' del dyn arrays and all var-len strings (but the result if it returns a string)
	symbFreeLocalDynVars( proc, issub )

	'' if main(), END 0 must be called because it's not safe to return to crt if
	'' an ON ERROR module-level handler was called while inside some proc
	if( callrtexit ) then
		if( p->ismain ) then
			rtlExitApp( NULL )
		end if
	end if

	'' if it's a function, load result
	if( issub = FALSE ) then
        hLoadProcResult( proc )
	end if

	''
	irProcEnd( proc )

	if( p->ismain = FALSE ) then
		'' not private or inline? flush it..
		if( symbIsPrivate( proc ) = FALSE ) then
			hProcFlush( p, TRUE )

		'' remove from hash tb only
		else
			symbDelSymbolTb( @proc->proc.loctb, TRUE )
		end if

	'' main? flush all remaining, it's the latest
	else
		hProcFlushAll( )

	end if

	'' back to main
    env.scope = FB_MAINSCOPE
    env.currproc = env.main.proc
	symbSetLocalTb( ast.oldsymtb )

	ast.curproc = listGetHead( @ast.proclist )

end sub

'':::::
private function hDeclProcArgs( byval proc as FBSYMBOL ptr ) as integer static
    dim as integer i
    dim as FBSYMBOL ptr arg

	function = FALSE

	'' proc returns an UDT?
	if( symbGetType( proc ) = FB_DATATYPE_USERDEF ) then
		'' create an hidden arg if needed
		symbAddProcResArg( proc )
	end if

	''
	i = 1
	arg = symbGetProcHeadArg( proc )
	do while( arg <> NULL )

		if( arg->arg.mode <> FB_ARGMODE_VARARG ) then
			if( symbAddArg( symbGetName( arg ), arg ) = NULL ) then
				hReportParamError( proc, i, NULL, FB_ERRMSG_DUPDEFINITION )
				exit function
			end if
		end if

		arg = symbGetArgNext( arg )
		i += 1
	loop

	function = TRUE

end function

'':::::
private sub hLoadProcResult ( byval proc as FBSYMBOL ptr ) static
    dim as FBSYMBOL ptr s
    dim as ASTNODE ptr n, t
    dim as integer dtype

	s = symbLookupProcResult( proc )
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
	case FB_DATATYPE_USERDEF
		dtype = symbGetProcRealType( proc )
	end select

	if( n = NULL ) then
		n = astNewLOAD( astNewVAR( s, 0, dtype, NULL ), dtype, TRUE )
	end if

	astAdd( n )

end sub

''::::
private function hModLevelIsEmpty( byval p as ASTPROCNODE ptr ) as integer
    dim as ASTNODE ptr n, nxt

	'' an empty module-level proc will have just the
	'' initial and final labels as nodes and nothing else
	'' (note: when debugging it will be emmited even if empty)

	n = p->head
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
private sub hModLevelAddRtInit( byval p as ASTPROCNODE ptr )
    dim as ASTNODE ptr n

    n = p->head
    if( n = NULL ) then
    	exit sub
    end if

	'' fb rt must be initialized before any static constructor
	'' is called but in any platform (but Windows) the .ctors
	'' list will be processed before main() is called by crt

	astAddAfter( rtlInitRt( ), n )

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' scope handling
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astScopeBegin( byval s as FBSYMBOL ptr ) static

    '' change to scope's symbol tb
    s->scp.loctb.head = NULL
    s->scp.loctb.tail = NULL

	symbSetLocalTb( @s->scp.loctb )

	''
	irScopeBegin( s )

	''
	astAdd( astNewDBG( IR_OP_DBG_SCOPEINI, cint( s ) ) )

end sub

'':::::
sub astScopeEnd( byval s as FBSYMBOL ptr ) static

	''
	astAdd( astNewDBG( IR_OP_DBG_SCOPEEND, cint( s ) ) )

	''
	irScopeEnd( s )

	'' back to preview symbol tb
	symbSetLocalTb( s->symtb )

end sub


