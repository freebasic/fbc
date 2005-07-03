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


'' parser part 5 - SUB's and FUNCTION's bodies
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

defint a-z
#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"
#include once "inc\emit.bi"

'':::::
private sub hReportParamError( byval argnum as integer, _
							   byval errnum as integer = FB_ERRMSG_PARAMTYPEMISMATCHAT )

	hReportErrorEx( errnum, "at parameter: " + str$( argnum ) )

end sub

'':::::
private function hCheckPrototype( byval proc as FBSYMBOL ptr, _
								  byval proctyp as integer, _
								  byval procsubtype as FBSYMBOL ptr, _
								  byval argc as integer, _
								  byval argtail as FBSYMBOL ptr ) as integer static
    dim a as integer
    dim arg as FBSYMBOL ptr, typ as integer

	function = FALSE

	'' check arg count
	if( argc <> symbGetProcArgs( proc ) ) then
		hReportError FB_ERRMSG_ARGCNTMISMATCH, TRUE
		exit function
	end if

	'' check return type
	if( proctyp <> symbGetType( proc ) ) then
		hReportError FB_ERRMSG_TYPEMISMATCH, TRUE
		exit function
	end if

	'' and sub type
	if( procsubtype <> symbGetSubtype( proc ) ) then
        hReportError FB_ERRMSG_TYPEMISMATCH, TRUE
        exit function
    end if

	'' check each arg
	a = argc
	arg = symbGetProcTailArg( proc )
	do while( arg <> NULL )
        typ = symbGetType( arg )

    	'' convert any AS ANY arg to the final one
    	if( typ = FB_SYMBTYPE_VOID ) then
    		arg->typ = argtail->typ
    		arg->subtype = argtail->subtype

    	'' check if types don't conflit
    	else
    		if( argtail->typ <> typ ) then
                hReportParamError a
                exit function

            elseif( argtail->subtype <> symbGetSubtype( arg ) ) then
                hReportParamError a
                exit function
    		end if
    	end if

    	'' and mode
    	if( argtail->arg.mode <> symbGetArgMode( proc, arg ) ) then
			hReportParamError a
            exit function
    	end if

    	'' check names and change to the new one if needed
    	if( argtail->arg.mode <> FB_ARGMODE_VARARG ) then
    		arg->alias = argtail->alias

    		'' as both have the same type, re-set the suffix, because for example
    		'' "a as integer" on the prototype and "a%" or just "a" on the proc
    		'' declaration when in a defint context is allowed in QB
    		arg->arg.suffix = argtail->arg.suffix
    	end if

    	'' prev arg
    	arg = arg->arg.l
    	argtail = argtail->arg.l
    	a -= 1
    loop

    ''
    function = TRUE

end function

'':::::
private function hDeclareArgs ( byval proc as FBSYMBOL ptr ) as integer static
    dim a as integer
    dim arg as FBSYMBOL ptr

	function = FALSE

	''
	a = 0
	arg = symbGetProcHeadArg( proc )
	do while( arg <> NULL )

		if( arg->arg.mode <> FB_ARGMODE_VARARG ) then
			if( symbAddArgAsVar( arg->alias, arg ) = NULL ) then
				hReportParamError( a, FB_ERRMSG_DUPDEFINITION )
				exit function
			end if
		end if

		arg = symbGetProcNextArg( proc, arg, FALSE )
		a += 1
	loop

	function = TRUE

end function

'':::::
''SubOrFuncHeader   =  ID (STDCALL|CDECL|PASCAL) OVERLOAD? (ALIAS LIT_STRING)?
''                     ('(' Arguments? ')')? (AS SymbolType)? STATIC? EXPORT?
''
function cSubOrFuncHeader( byval issub as integer, _
						   proc as FBSYMBOL ptr, _
						   alloctype as integer ) static

    static as zstring * FB_MAXNAMELEN+1 id, aliasid
    dim as integer typ, mode, lgt, ptrcnt, argc
    dim as FBSYMBOL ptr subtype, argtail

	function = FALSE

	'' ID
	if( lexGetClass <> FB_TKCLASS_IDENTIFIER ) then
		hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
		exit function
	end if

	typ 	= lexGetType
	proc    = lexGetSymbol
	lexEatToken( id )
	subtype = NULL
	ptrcnt  = 0

	if( (isSub) and (typ <> INVALID) ) then
    	hReportError FB_ERRMSG_INVALIDCHARACTER
    	exit function
	end if

	'' (CDECL|STDCALL|PASCAL)?
	select case as const lexGetToken
	case FB_TK_CDECL
		mode = FB_FUNCMODE_CDECL
		lexSkipToken
	case FB_TK_STDCALL
		mode = FB_FUNCMODE_STDCALL
		lexSkipToken
	case FB_TK_PASCAL
		mode = FB_FUNCMODE_PASCAL
		lexSkipToken
	case else
		mode = FB_DEFAULT_FUNCMODE
	end select

	'' OVERLOAD?
	if( lexGetToken = FB_TK_OVERLOAD ) then
		lexSkipToken
		alloctype or= FB_ALLOCTYPE_OVERLOADED
	end if

	'' (ALIAS LIT_STRING)?
	if( lexGetToken = FB_TK_ALIAS ) then
		lexSkipToken
		lexEatToken( aliasid )
	else
		aliasid = ""
	end if

	'' ('(' Arguments? ')')?
	if( lexGetToken = CHAR_LPRNT ) then
		lexSkipToken

		argtail = cArguments( mode, argc, argtail, FALSE )

		if( not hMatch( CHAR_RPRNT ) or (hGetLastError <> FB_ERRMSG_OK) ) then
			hReportError FB_ERRMSG_EXPECTEDRPRNT
			exit function
		end if
	else
		argc = 0
		argtail = NULL
	end if

    '' (AS SymbolType)?
    if( lexGetToken = FB_TK_AS ) then
    	lexSkipToken

    	if( (typ <> INVALID) or (isSub) ) then
    		hReportError FB_ERRMSG_SYNTAXERROR
    		exit function
    	end if

    	if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    		hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
    		exit function
    	end if

    	'' check for invalid types
    	select case typ
    	case FB_SYMBTYPE_USERDEF
    		hReportError( FB_ERRMSG_CANNOTRETURNSTRUCTSFROMFUNCTS )
    		exit function
    	case FB_SYMBTYPE_FIXSTR, FB_SYMBTYPE_CHAR
    		hReportError( FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS )
    		exit function
    	case FB_SYMBTYPE_VOID
    		hReportError( FB_ERRMSG_INVALIDDATATYPES )
    		exit function
    	end select
    end if

    if( issub ) then
    	typ = FB_SYMBTYPE_VOID
    	subtype = NULL
    end if

    if( (alloctype and FB_ALLOCTYPE_STATIC) = 0 ) then
    	'' STATIC?
    	if( hMatch( FB_TK_STATIC ) ) then
    		alloctype or= FB_ALLOCTYPE_STATIC
    	end if
    end if

    '' EXPORT?
    if( hMatch( FB_TK_EXPORT ) ) then
    	'' private?
    	if( (alloctype and FB_ALLOCTYPE_PRIVATE) > 0 ) then
    		hReportError FB_ERRMSG_SYNTAXERROR
    		exit function
    	end if
    	alloctype or= FB_ALLOCTYPE_EXPORT or FB_ALLOCTYPE_PUBLIC
    end if

	''
	if( typ = INVALID ) then
		typ = hGetDefType( id )
	end if

    '' symbol found?
    if( proc <> NULL ) then
    	proc = symbFindByClass( proc, FB_SYMBCLASS_PROC )
    end if

    if( proc = NULL ) then
    	proc = symbAddProc( id, aliasid, "", typ, subtype, ptrcnt, _
    						alloctype, mode, argc, argtail )
    	if( proc = NULL ) then
    		hReportError FB_ERRMSG_DUPDEFINITION, TRUE
    		exit function
    	end if
    else

    	'' overloaded?
    	if( symbGetProcIsOverloaded( proc ) ) then

            '' try to find a prototype with the same signature
    		proc = symbFindOverloadProc( proc, argc, argtail )

    		'' none found? try to overload..
    		if( proc = NULL ) then
    			proc = symbAddProc( id, aliasid, "", typ, subtype, ptrcnt, _
    								alloctype, mode, argc, argtail )
    			'' dup def?
    			if( proc = NULL ) then
    				hReportError FB_ERRMSG_DUPDEFINITION, TRUE
    				exit function
    			else
    				return TRUE
    			end if
    		end if

    		alloctype or= FB_ALLOCTYPE_OVERLOADED
    	end if

    	''
    	if( symbGetProcIsDeclared( proc ) ) then
    		hReportError FB_ERRMSG_DUPDEFINITION, TRUE
    		exit function
    	end if

    	'' there's already a prototype for this proc, so check for conflits
    	if( not hCheckPrototype( proc, typ, subtype, argc, argtail ) ) then
    		exit function
    	end if

    	'' check calling convention
    	if( symbGetFuncMode( proc ) <> mode ) then
    		hReportError FB_ERRMSG_ILLEGALPARAMSPEC, TRUE
    		exit function
    	end if

    	''
    	symbSetProcIsDeclared( proc, TRUE )

    	symbSetAllocType( proc, alloctype )
    end if

    function = TRUE

end function

'':::::
private sub hLoadResult ( byval proc as FBSYMBOL ptr ) static
    dim as FBSYMBOL ptr s
    dim as IRVREG ptr vr
    dim as ASTNODE ptr n, t
    dim as integer typ

	s = symbLookupProcResult( proc )
	typ = symbGetType( s )

	'' if result is a string, a temp descriptor is needed, as the current one (at stack)
	'' will be trashed when the function returns (also, the string returned will be
	'' set as temp, so any assignament or when passed as parameter to another proc
	'' will deallocate this string)
	if( typ = FB_SYMBTYPE_STRING ) then
		t = astNewVAR( s, NULL, 0, IR_DATATYPE_STRING )
		n = rtlStrAllocTmpResult( t )
		astFlush( n )
	else
		''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
		vr = irAllocVRVAR( typ, s, s->ofs )
		irEmitLOAD( IR_OP_LOADRESULT, vr )
	end if

end sub

'':::::
''ProcStatement	  =	  (PRIVATE|PUBLIC)? STATIC? ((SUB SubDecl) | (FUNCTION FuncDecl)) Comment? SttSeparator
''					  SimpleLine*
''				      END (SUB | FUNCTION)
''
function cProcStatement static
	dim as integer res, issub, alloctype
    dim as FBCMPSTMT oldprocstmt
    dim as FBSYMBOL ptr proc, endlabel, exitlabel, initlabel, l
    dim as ASTNODE ptr expr

	function = FALSE

	'' (PRIVATE|PUBLIC)?
	select case lexGetToken( )
	case FB_TK_PRIVATE
		lexSkipToken( )
		alloctype = FB_ALLOCTYPE_PRIVATE
	case FB_TK_PUBLIC
		lexSkipToken( )
		alloctype = FB_ALLOCTYPE_PUBLIC
	case else
		if( env.opt.procpublic ) then
			alloctype = FB_ALLOCTYPE_PUBLIC
		else
			alloctype = FB_ALLOCTYPE_PRIVATE
		end if
	end select

    '' STATIC?
    if( hMatch( FB_TK_STATIC ) ) then
    	alloctype = alloctype or FB_ALLOCTYPE_STATIC
    end if

	'' SUB | FUNCTION
	select case lexGetToken( )
	case FB_TK_SUB
		issub = TRUE
	case FB_TK_FUNCTION
		issub = FALSE
	case else
		exit function
	end select

	lexSkipToken( )

	''
	if( env.scope > 0 ) then
        hReportError( FB_ERRMSG_INNERPROCNOTALLOWED )
        exit function
	end if

	'' SubDecl | FuncDecl
	if( not cSubOrFuncHeader( issub, proc, alloctype ) ) then
		exit function
	end if

	''
	env.currproc = proc
	env.compoundcnt += 1

	if( (alloctype and FB_ALLOCTYPE_STATIC) > 0 ) then
		env.isprocstatic = TRUE
	else
		env.isprocstatic = FALSE
	end if

	'' add end and exit labels (will be used by any EXIT SUB/FUNCTION)
	endlabel  = symbAddLabel( "" )
	exitlabel = symbAddLabel( "" )
	initlabel = symbAddLabel( "" )

	'' save old proc stmt info
	oldprocstmt = env.procstmt

	env.procstmt.cmplabel = NULL
	env.procstmt.endlabel = exitlabel

	'' restore error old handle if any was set
	env.procerrorhnd 	  = NULL

	'' emit proc setup
	irEmitPROCBEGIN( proc, initlabel, endlabel, (alloctype and FB_ALLOCTYPE_PUBLIC) > 0 )

	'' scope can only change after the IR is flushed because
	'' the temporary vars that can be created by IR
	env.scope = 1

    '' alloc args
    if( not hDeclareArgs( proc ) ) then
    	exit function
    end if

	'' alloc result local var
	if( not issub ) then
		if( symbAddProcResult( proc ) = NULL ) then
		end if
	end if

	'' Comment?
	cComment( )

	'' SttSeparator
	if( not cStmtSeparator( ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if

	'' proc body
	do
	loop while( (cSimpleLine( )) and (lexGetToken( ) <> FB_TK_EOF) )

	'' END (SUB | FUNCTION)
	if( not hMatch( FB_TK_END ) ) then
		hReportError( FB_ERRMSG_EXPECTEDENDSUBORFUNCT )
		exit function
	else
		res = FALSE
		if( hMatch( FB_TK_SUB ) ) then
			if( issub ) then
				res = TRUE
			end if
		elseif( hMatch( FB_TK_FUNCTION ) ) then
			if( not issub ) then
				res = TRUE
			end if
		end if

		if( not res ) then
			hReportError( FB_ERRMSG_EXPECTEDENDSUBORFUNCT )
			exit function
		end if
	end if

	'' exit
	irEmitLABEL( exitlabel, FALSE )

	'' restore old error handler if any was set
	if( env.procerrorhnd <> NULL ) then
        expr = astNewVAR( env.procerrorhnd, NULL, 0, IR_DATATYPE_UINT )
        rtlErrorSetHandler( expr, FALSE )
	end if

	'' del dyn arrays and all var-len strings (less the result one if its a string func!)
	symbFreeLocalDynVars( proc, issub )

	'' if it's a function, put the result var in the result register
	if( not issub ) then
        hLoadResult( proc )
	end if

	'' end
	irEmitPROCEND( proc, initlabel, exitlabel )

	irEmitLABEL( endlabel, FALSE )

	'' check undefined labels
	l = symbCheckLabels( )
	if( l <> NULL ) then
		'''''hReportErrorEx FB_ERRMSG_UNDEFINEDLABEL, symbGetOrgName( l ), -1
		exit function
	end if

	'' free all local symbols
	symbDelLocalSymbols( )

	'' back to old state
	env.scope 				= 0
	env.procerrorhnd 		= NULL
	env.currproc 			= NULL
	env.compoundcnt 		-= 1
	env.isprocstatic 	 	= FALSE
	env.procstmt.cmplabel 	= NULL
	env.procstmt.endlabel 	= NULL

	'' del labels (they were created when scope was 0)
	symbDelLabel( initlabel )
	symbDelLabel( exitlabel )
	symbDelLabel( endlabel )

	''
	function = TRUE

end function


