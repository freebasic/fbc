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
'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\parser.bi'
'$include once: 'inc\rtl.bi'
'$include once: 'inc\ast.bi'
'$include once: 'inc\ir.bi'
'$include once: 'inc\emit.bi'

'':::::
private sub hReportParamError( byval argnum as integer, _
							   byval errnum as integer = FB.ERRMSG.PARAMTYPEMISMATCHAT )

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

	hCheckPrototype = FALSE

	'' check arg count
	if( argc <> symbGetProcArgs( proc ) ) then
		hReportError FB.ERRMSG.ARGCNTMISMATCH, TRUE
		exit function
	end if

	'' check return type
	if( proctyp <> symbGetType( proc ) ) then
		hReportError FB.ERRMSG.TYPEMISMATCH, TRUE
		exit function
	end if

	'' and sub type
	if( procsubtype <> symbGetSubtype( proc ) ) then
        hReportError FB.ERRMSG.TYPEMISMATCH, TRUE
        exit function
    end if

	'' check each arg
	a = argc
	arg = symbGetProcTailArg( proc )
	do while( arg <> NULL )
        typ = symbGetType( arg )

    	'' convert any AS ANY arg to the final one
    	if( typ = FB.SYMBTYPE.VOID ) then
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
    	if( argtail->arg.mode <> FB.ARGMODE.VARARG ) then
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
    hCheckPrototype = TRUE

end function

'':::::
private function hDeclareArgs ( byval proc as FBSYMBOL ptr ) as integer static
    dim a as integer
    dim arg as FBSYMBOL ptr

	hDeclareArgs = FALSE

	''
	a = 0
	arg = symbGetProcHeadArg( proc )
	do while( arg <> NULL )

		if( arg->arg.mode <> FB.ARGMODE.VARARG ) then
			if( symbAddArgAsVar( arg->alias, arg ) = NULL ) then
				hReportParamError a, FB.ERRMSG.DUPDEFINITION
				exit function
			end if
		end if

		arg = symbGetProcNextArg( proc, arg, FALSE )
		a += 1
	loop

	hDeclareArgs = TRUE

end function

'':::::
''SubOrFuncHeader   =  ID (STDCALL|CDECL|PASCAL) OVERLOAD? (ALIAS LIT_STRING)?
''                     ('(' Arguments? ')')? (AS SymbolType)? STATIC? EXPORT?
''
function cSubOrFuncHeader( byval issub as integer, _
						   proc as FBSYMBOL ptr, _
						   alloctype as integer ) static

    static as zstring * FB.MAXNAMELEN+1 id, aliasid
    dim as integer typ, mode, lgt, ptrcnt, argc
    dim as FBSYMBOL ptr subtype, argtail

	function = FALSE

	'' ID
	if( lexCurrentTokenClass <> FB.TKCLASS.IDENTIFIER ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	typ 	= lexTokenType
	proc    = lexTokenSymbol
	lexEatToken( id )
	subtype = NULL
	ptrcnt  = 0

	if( (isSub) and (typ <> INVALID) ) then
    	hReportError FB.ERRMSG.INVALIDCHARACTER
    	exit function
	end if

	'' (CDECL|STDCALL|PASCAL)?
	select case as const lexCurrentToken
	case FB.TK.CDECL
		mode = FB.FUNCMODE.CDECL
		lexSkipToken
	case FB.TK.STDCALL
		mode = FB.FUNCMODE.STDCALL
		lexSkipToken
	case FB.TK.PASCAL
		mode = FB.FUNCMODE.PASCAL
		lexSkipToken
	case else
		mode = FB.DEFAULT.FUNCMODE
	end select

	'' OVERLOAD?
	if( lexCurrentToken = FB.TK.OVERLOAD ) then
		lexSkipToken
		alloctype or= FB.ALLOCTYPE.OVERLOADED
	end if

	'' (ALIAS LIT_STRING)?
	if( lexCurrentToken = FB.TK.ALIAS ) then
		lexSkipToken
		lexEatToken( aliasid )
	else
		aliasid = ""
	end if

	'' ('(' Arguments? ')')?
	if( lexCurrentToken = CHAR_LPRNT ) then
		lexSkipToken

		argtail = cArguments( mode, argc, argtail, FALSE )

		if( not hMatch( CHAR_RPRNT ) or (hGetLastError <> FB.ERRMSG.OK) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
	else
		argc = 0
		argtail = NULL
	end if

    '' (AS SymbolType)?
    if( lexCurrentToken = FB.TK.AS ) then
    	lexSkipToken

    	if( (typ <> INVALID) or (isSub) ) then
    		hReportError FB.ERRMSG.SYNTAXERROR
    		exit function
    	end if

    	if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    		exit function
    	end if

    	'' check for invalid types
    	select case typ
    	case FB.SYMBTYPE.USERDEF
    		hReportError FB.ERRMSG.CANNOTRETURNSTRUCTSFROMFUNCTS
    		exit function
    	case FB.SYMBTYPE.FIXSTR, FB.SYMBTYPE.CHAR
    		hReportError FB.ERRMSG.CANNOTRETURNFIXLENFROMFUNCTS
    		exit function
    	end select
    end if

    if( issub ) then
    	typ = FB.SYMBTYPE.VOID
    	subtype = NULL
    end if

    if( (alloctype and FB.ALLOCTYPE.STATIC) = 0 ) then
    	'' STATIC?
    	if( hMatch( FB.TK.STATIC ) ) then
    		alloctype or= FB.ALLOCTYPE.STATIC
    	end if
    end if

    '' EXPORT?
    if( hMatch( FB.TK.EXPORT ) ) then
    	'' private?
    	if( (alloctype and FB.ALLOCTYPE.PRIVATE) > 0 ) then
    		hReportError FB.ERRMSG.SYNTAXERROR
    		exit function
    	end if
    	alloctype or= FB.ALLOCTYPE.EXPORT or FB.ALLOCTYPE.PUBLIC
    end if

	''
	if( typ = INVALID ) then
		typ = hGetDefType( id )
	end if

    '' symbol found?
    if( proc <> NULL ) then
    	proc = symbFindByClass( proc, FB.SYMBCLASS.PROC )
    end if

    if( proc = NULL ) then
    	proc = symbAddProc( id, aliasid, "", typ, subtype, ptrcnt, _
    						alloctype, mode, argc, argtail )
    	if( proc = NULL ) then
    		hReportError FB.ERRMSG.DUPDEFINITION, TRUE
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
    				hReportError FB.ERRMSG.DUPDEFINITION, TRUE
    				exit function
    			else
    				return TRUE
    			end if
    		end if

    		alloctype or= FB.ALLOCTYPE.OVERLOADED
    	end if

    	''
    	if( symbGetProcIsDeclared( proc ) ) then
    		hReportError FB.ERRMSG.DUPDEFINITION, TRUE
    		exit function
    	end if

    	'' there's already a prototype for this proc, so check for conflits
    	if( not hCheckPrototype( proc, typ, subtype, argc, argtail ) ) then
    		exit function
    	end if

    	'' check calling convention
    	if( symbGetFuncMode( proc ) <> mode ) then
    		hReportError FB.ERRMSG.ILLEGALPARAMSPEC, TRUE
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
	if( typ = FB.SYMBTYPE.STRING ) then
		t = astNewVAR( s, NULL, 0, IR.DATATYPE.STRING )
		n = rtlStrAllocTmpResult( t )
		astFlush( n )
	else
		''!!!FIXME!!! parser shouldn't call IR directly, always use the AST
		vr = irAllocVRVAR( typ, s, s->ofs )
		irEmitLOAD( IR.OP.LOADRESULT, vr )
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
	select case lexCurrentToken
	case FB.TK.PRIVATE
		alloctype = FB.ALLOCTYPE.PRIVATE
		lexSkipToken
	case FB.TK.PUBLIC
		lexSkipToken
		alloctype = FB.ALLOCTYPE.PUBLIC
	case else
		if( env.optprocpublic ) then
			alloctype = FB.ALLOCTYPE.PUBLIC
		end if
	end select

    '' STATIC?
    if( hMatch( FB.TK.STATIC ) ) then
    	alloctype = alloctype or FB.ALLOCTYPE.STATIC
    end if

	'' SUB | FUNCTION
	if( lexCurrentToken = FB.TK.SUB ) then
		issub = TRUE
	elseif( lexCurrentToken = FB.TK.FUNCTION ) then
		issub = FALSE
	else
		exit function
	end if

	lexSkipToken

	''
	if( env.scope > 0 ) then
        hReportError FB.ERRMSG.INNERPROCNOTALLOWED
        exit function
	end if

	'' SubDecl | FuncDecl
	if( not cSubOrFuncHeader( issub, proc, alloctype ) ) then
		exit function
	end if

	''
	env.scope = 1

	env.currproc = proc
	env.compoundcnt += 1

	if( (alloctype and FB.ALLOCTYPE.STATIC) > 0 ) then
		env.isprocstatic = TRUE
	else
		env.isprocstatic = FALSE
	end if

	''
	'' add end and exit labels (will be used by any EXIT SUB/FUNCTION)
	endlabel  = symbAddLabel( hMakeTmpStr )
	exitlabel = symbAddLabel( hMakeTmpStr )
	initlabel = symbAddLabel( hMakeTmpStr )

	'' emit proc setup
	irEmitPROCBEGIN proc, initlabel, endlabel, (alloctype and FB.ALLOCTYPE.PUBLIC) > 0

	'' profiling?
	if( env.clopt.profile ) then
		if( not rtlProfileSetProc( proc ) ) then
			hReportError FB.ERRMSG.INTERNAL
			exit function
		end if
	end if

	'' save old proc stmt info
	oldprocstmt = env.procstmt

	env.procstmt.cmplabel = NULL
	env.procstmt.endlabel = exitlabel

	'' restore error old handle if any was set
	env.procerrorhnd 	  = NULL

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
	cComment

	'' SttSeparator
	if( not cSttSeparator ) then
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if

	'' proc body
	do
	loop while( (cSimpleLine) and (lexCurrentToken <> FB.TK.EOF) )

	'' END (SUB | FUNCTION)
	if( not hMatch( FB.TK.END ) ) then
		hReportError FB.ERRMSG.EXPECTEDENDSUBORFUNCT
		exit function
	else
		res = FALSE
		if( hMatch( FB.TK.SUB ) ) then
			if( issub ) then
				res = TRUE
			end if
		elseif( hMatch( FB.TK.FUNCTION ) ) then
			if( not issub ) then
				res = TRUE
			end if
		end if

		if( not res ) then
			hReportError FB.ERRMSG.EXPECTEDENDSUBORFUNCT
			exit function
		end if
	end if

	'' exit
	irEmitLABEL exitlabel, FALSE

	'' restore old error handler if any was set
	if( env.procerrorhnd <> NULL ) then
        expr = astNewVAR( env.procerrorhnd, NULL, 0, IR.DATATYPE.UINT )
        rtlErrorSetHandler( expr, FALSE )
	end if

	'' del dyn arrays and all var-len strings (less the result one if its a string func!)
	symbFreeLocalDynSymbols proc, issub

	'' profiling?
	if( env.clopt.profile ) then
		if( not rtlProfileSetProc( NULL ) ) then
			hReportError FB.ERRMSG.INTERNAL
			exit function
		end if
	end if

	'' if function, put result var at result register (EAX or ST0)
	if( not issub ) then
        hLoadResult proc
	end if

	'' end
	irEmitPROCEND proc, initlabel, exitlabel

	irEmitLABEL endlabel, FALSE

	'' check undefined labels
	l = symbCheckLabels
	if( l <> NULL ) then
		'''''hReportErrorEx FB.ERRMSG.UNDEFINEDLABEL, symbGetOrgName( l ), -1
		exit function
	end if


	'' deallocations
	'''''symbDelLabel initlabel
	'''''symbDelLabel exitlabel
	'''''symbDelLabel endlabel
	''
	symbDelLocalSymbols

	'' back to old state
	env.procerrorhnd 		= NULL
	env.currproc 			= NULL
	env.compoundcnt 		-= 1
	env.isprocstatic 	 	= FALSE
	env.procstmt.cmplabel 	= NULL
	env.procstmt.endlabel 	= NULL
	env.scope 				= 0

	''
	function = TRUE

end function


