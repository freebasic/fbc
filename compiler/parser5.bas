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

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\parser.bi'
'$include: 'inc\rtl.bi'
'$include: 'inc\ast.bi'
'$include: 'inc\ir.bi'
'$include: 'inc\emit.bi'

'':::::
private sub hReportParamError( byval argnum as integer, byval errnum as integer = FB.ERRMSG.PARAMTYPEMISMATCHAT )

	hReportErrorEx errnum, "at parameter: " + str$( argnum+1 )

end sub

'':::::
private function hCheckPrototype( byval proc as FBSYMBOL ptr, byval argc as integer, argv() as FBPROCARG ) as integer static
    dim a as integer, atype as integer, amode as integer
    dim arg as FBPROCARG ptr, typ as integer

	hCheckPrototype = FALSE

	''
	if( argc <> symbGetProcArgs( proc ) ) then
		hReportError FB.ERRMSG.ARGCNTMISMATCH
		exit function
	end if

	a = 0
	arg = symbGetProcHeadArg( proc )
	do while( arg <> NULL )
        typ   = symbGetArgType( proc, arg )
    	atype = argv(a).typ

    	'' convert any AS ANY arg to the final one
    	if( typ = FB.SYMBTYPE.VOID ) then
    		symbSetArgType proc, arg, atype
    		symbSetArgSubType proc, arg, argv(a).subtype

    	'' check if types don't conflit
    	else
    		if( atype <> typ ) then
                hReportParamError a
                exit function

            elseif( argv(a).subtype <> symbGetArgSubtype( proc, arg ) ) then

    			'' if it's a function pointer, subtypes (protos) will be different.. doesn't matter
    			if( atype <> FB.SYMBTYPE.POINTER + FB.SYMBTYPE.FUNCTION ) then
                	hReportParamError a
                	exit function
    			else
    				'' !!!FIXME!!! delete prototype as it isn't needed
    			end if

    		end if
    	end if

    	'' and mode
    	amode = argv(a).mode
    	if( amode <> symbGetArgMode( proc, arg ) ) then
			hReportParamError a
            exit function
    	end if

    	'' check names and change to the new one if needed
    	if( strpGet( argv(a).nameidx ) <> symbGetArgName( proc, arg ) ) then
    		symbSetArgName proc, arg, argv(a).nameidx
    	end if

    	arg = symbGetProcNextArg( proc, arg, FALSE )
    	a   = a + 1
    loop

    ''
    hCheckPrototype = TRUE

end function

'':::::
private function hDeclareArgs ( byval proc as FBSYMBOL ptr ) as integer static
    dim i as integer
    dim arg as FBPROCARG ptr

	hDeclareArgs = FALSE

	''
	i = 0
	arg = symbGetProcHeadArg( proc )
	do while( arg <> NULL )

		if( symbAddArg( proc, arg ) = NULL ) then
			hReportParamError i, FB.ERRMSG.DUPDEFINITION
			exit function
		end if

		arg = symbGetProcNextArg( proc, arg, FALSE )
		i = i + 1
	loop

	hDeclareArgs = TRUE

end function


'':::::
''SubOrFuncHeader   =  ID (STDCALL|CDECL|PASCAL) (ALIAS LIT_STRING)? ('(' Arguments? ')')? (AS SymbolType)? STATIC?
''
function cSubOrFuncHeader( byval issub as integer, proc as FBSYMBOL ptr, isstatic as integer ) static
    dim res as integer
    dim id as string, aliasid as string, typ as integer, subtype as FBSYMBOL ptr, mode as integer, lgt as integer
    dim argc as integer, argv(0 to FB_MAXPROCARGS-1) as FBPROCARG

	cSubOrFuncHeader = FALSE

	'' ID
	if( lexCurrentToken <> FB.TK.ID ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	typ = lexTokenType
	id = lexEatToken

	if( (isSub) and (typ <> INVALID) ) then
    	hReportError FB.ERRMSG.INVALIDCHARACTER
    	exit function
	end if

	'' (CDECL|STDCALL|PASCAL)?
	select case lexCurrentToken
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

	'' (ALIAS LIT_STRING)?
	if( hMatch( FB.TK.ALIAS ) ) then
		aliasid = lexEatToken
	else
		aliasid = ""
	end if

	'' ('(' Arguments? ')')?
	if( hMatch( CHAR_LPRNT ) ) then
		res = cArguments( argc, argv(), FALSE )
		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if
	else
		argc = 0
	end if

    '' (AS SymbolType)?
    if( hMatch( FB.TK.AS ) ) then

    	if( (typ <> INVALID) or (isSub) ) then
    		hReportError FB.ERRMSG.SYNTAXERROR
    		exit function
    	end if

    	if( not cSymbolType( typ, subtype, lgt ) ) then
    		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
    		exit function
    	end if

    	'' check for invalid types
    	select case typ
    	case FB.SYMBTYPE.USERDEF
    		hReportError FB.ERRMSG.CANNOTRETURNSTRUCTSFROMFUNCTS
    		exit function
    	case FB.SYMBTYPE.FIXSTR
    		hReportError FB.ERRMSG.CANNOTRETURNFIXLENFROMFUNCTS
    		exit function
    	end select
    end if

    if( issub ) then
    	typ = FB.SYMBTYPE.VOID
    end if

    if( isstatic = FALSE ) then
    	'' STATIC?
    	if( hMatch( FB.TK.STATIC ) ) then
    		isstatic = TRUE
    	end if
    end if

    proc = symbLookupProc( id )
    if( proc = NULL ) then
    	proc = symbAddProc( id, aliasid, "", typ, mode, argc, argv() )
    	if( proc = NULL ) then
    		hReportError FB.ERRMSG.DUPDEFINITION
    		exit function
    	end if
    else
    	if( symbGetProcIsDeclared( proc ) ) then
    		hReportError FB.ERRMSG.DUPDEFINITION
    		exit function
    	end if

    	'' there's already a prototype for this proc, so check for conflits
    	if( not hCheckPrototype( proc, argc, argv() ) ) then
    		exit function
    	end if

    	'' check calling convention
    	if( symbGetFuncMode( proc ) <> mode ) then
    		hReportError FB.ERRMSG.ILLEGALPARAMSPEC
    		exit function
    	end if

    end if

    cSubOrFuncHeader = TRUE

end function

'':::::
private sub hLoadResult ( byval proc as FBSYMBOL ptr ) static
    dim s as FBSYMBOL ptr, typ as integer, dtype as integer
    dim vr as integer, n as integer, t as integer

	s = symbLookupFunctionResult( proc )
	typ = symbGetType( s )
	dtype = hSTyp2DType( typ )

	'' if result is a string, a temp descriptor is needed, as the current one (at stack)
	'' will be trashed when the function returns (also, the string returned will be
	'' set as temp, so any assignament or when passed as parameter to another proc
	'' will deallocate this string)
	if( typ = FB.SYMBTYPE.STRING ) then
		t = astNewVAR( s, 0, IR.DATATYPE.STRING )
		n = rtlStrAllocTmpResult( t )
		astFlush n, vr
	else
		vr = irAllocVRVAR( dtype, s, 0 )
		irEmitLOAD IR.OP.LDFUNCRESULT, vr
	end if

end sub

'':::::
''ProcStatement	  =	  (PRIVATE|PUBLIC)? STATIC? ((SUB SubDecl) | (FUNCTION FuncDecl)) Comment? SttSeparator
''					  SimpleLine*
''				      END (SUB | FUNCTION)
''
function cProcStatement static
	dim issub as integer, proc as FBSYMBOL ptr, ispublic as integer
    dim oldprocstmt as FBCMPSTMT
    dim endlabel as FBSYMBOL ptr, exitlabel as FBSYMBOL ptr, initlabel as FBSYMBOL ptr
    dim res as integer, expr as integer, l as FBSYMBOL ptr

	cProcStatement = FALSE

	'' (PRIVATE|PUBLIC)?
	select case lexCurrentToken
	case FB.TK.PUBLIC
		lexSkipToken
		ispublic = TRUE
	case FB.TK.PRIVATE
		lexSkipToken
		ispublic = FALSE
	case else
		ispublic = env.optprocpublic
	end select

    '' STATIC?
    if( hMatch( FB.TK.STATIC ) ) then
    	env.isprocstatic = TRUE
    else
    	env.isprocstatic = FALSE
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
	if( not cSubOrFuncHeader( issub, proc, env.isprocstatic ) ) then
		exit function
	end if

	''
	env.scope = 1

	env.currproc = proc
	env.compoundcnt = env.compoundcnt + 1

	''
	'' add end and exit labels (will be used by any EXIT SUB/FUNCTION)
	endlabel  = symbAddLabel( hMakeTmpStr )
	exitlabel = symbAddLabel( hMakeTmpStr )
	initlabel = symbAddLabel( hMakeTmpStr )

	'' emit proc setup
	irEmitPROCBEGIN proc, initlabel, endlabel, ispublic

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
	res = cComment

	'' SttSeparator
	if( not cSttSeparator ) then
		hReportError FB.ERRMSG.EXPECTEDEOL
		exit function
	end if

	'' proc body
	do
		res = cSimpleLine
	loop while( (res) and (lexCurrentToken <> FB.TK.EOF) )

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
        expr = astNewVAR( env.procerrorhnd, 0, IR.DATATYPE.UINT )
        rtlErrorSetHandler expr, FALSE
	end if

	'' del dyn arrays and all var-len strings (less the result one if its a string func!)
	symbFreeLocalDynSymbols proc, issub

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
		'''''hReportErrorEx FB.ERRMSG.UNDEFINEDLABEL, symbGetLabelName( l ), -1
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
	env.compoundcnt 		= env.compoundcnt - 1
	env.isprocstatic 	 	= FALSE
	env.procstmt.cmplabel 	= NULL
	env.procstmt.endlabel 	= NULL
	env.scope 				= 0

	''
	cProcStatement = TRUE

end function


