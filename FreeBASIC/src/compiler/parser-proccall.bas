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


'' proc calls (CALL or foo[(...)]) and function result assignments (function=expr)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
function hAssignFunctResult( byval proc as FBSYMBOL ptr, _
							 byval expr as ASTNODE ptr ) as integer static
    dim s as FBSYMBOL ptr
    dim assg as ASTNODE ptr

    function = FALSE

    s = symbLookupProcResult( proc )
    if( s = NULL ) then
    	hReportError( FB_ERRMSG_SYNTAXERROR )
    	exit function
    end if

    assg = astNewVAR( s, NULL, 0, symbGetType( s ), symbGetSubtype( s ) )

	'' proc returns an UDT?
	if( symbGetType( proc ) = FB_SYMBTYPE_USERDEF ) then
		'' pointer? deref
		if( symbGetProcRealType( proc ) = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_USERDEF ) then
			assg = astNewPTR( s, NULL, 0, assg, FB_SYMBTYPE_USERDEF, symbGetSubType( proc ) )
		end if
	end if

    assg = astNewASSIGN( assg, expr )
    if( assg = NULL ) then
    	hReportError( FB_ERRMSG_INVALIDDATATYPES )
    	exit function
    end if

    astAdd( assg )

    function = TRUE

end function

'':::::
function cProcCall( byval sym as FBSYMBOL ptr, _
					byref procexpr as ASTNODE ptr, _
					byval ptrexpr as ASTNODE ptr, _
					byval checkprnts as integer = FALSE ) as integer
	dim as integer typ, isfuncptr, doflush
	dim as FBSYMBOL ptr subtype, elm, reslabel

	function = FALSE

	if( checkprnts = TRUE ) then
		'' if the sub has no args, prnts are optional
		if( symbGetProcArgs( sym ) = 0 ) then
			checkprnts = FALSE
		end if

	'' if it's a function pointer, prnts are obligatory
	elseif( ptrexpr <> NULL ) then
		checkprnts = TRUE

	end if

	if( checkprnts ) then
		'' '('
		if( not hMatch( CHAR_LPRNT ) ) then
			hReportError( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if

	end if

	env.prntcnt = 0
	env.prntopt	= not checkprnts

	'' ProcParamList
	procexpr = cProcParamList( sym, ptrexpr, FALSE, FALSE )
	if( procexpr = NULL ) then
		exit function
	end if

	'' ')'
	if( (checkprnts) or (env.prntcnt > 0) ) then

		'' --parent cnt
		env.prntcnt -= 1

		if( (not hMatch( CHAR_RPRNT )) or (env.prntcnt > 0) ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if

	end if

	env.prntopt	= FALSE

	typ = symbGetType( sym )

	'' if function returns a pointer, check for field deref
	doflush = TRUE
	if( typ >= FB_SYMBTYPE_POINTER ) then
		elm = NULL
    	subtype = symbGetSubType( sym )

		isfuncptr = FALSE
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( typ = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if

		'' FuncPtrOrDerefFields?
		if( not cFuncPtrOrDerefFields( sym, elm, typ, subtype, _
									   procexpr, isfuncptr, TRUE ) ) then
			'' error?
			if( hGetLastError <> FB_ERRMSG_OK ) then
				exit function
			end if

		'' type changed
		else
			doflush = FALSE
			typ = astGetDataType( procexpr )

			'' if it stills a function, unless type = string (ie: implicit pointer),
			'' flush it, as the assignament would be invalid
			if( astIsFUNCT( procexpr ) ) then
				if( typ <> IR_DATATYPE_STRING ) then
					doflush = TRUE
				end if
			end if

		end if

	end if

	''
	if( doflush ) then
		'' can proc's result be skipped?
		if( typ <> FB_SYMBTYPE_VOID ) then
			if( irGetDataClass( typ ) <> IR_DATACLASS_INTEGER ) then
				hReportError( FB_ERRMSG_VARIABLEREQUIRED )
				exit function
			end if
		end if

		'' check error?
		if( sym <> NULL ) then
			if( symbGetProcErrorCheck( sym ) ) then
    			if( env.clopt.resumeerr ) then
					reslabel = symbAddLabel( NULL )
    				astAdd( astNewLABEL( reslabel ) )
    			else
    				reslabel = NULL
    			end if

				function = rtlErrorCheck( procexpr, reslabel, lexLineNum( ) )
				procexpr = NULL
				exit function
			end if
		end if

		astSetDataType( procexpr, IR_DATATYPE_VOID )
		astAdd( procexpr )
		procexpr = NULL
	end if

	function = TRUE

end function

'':::::
''ProcCallOrAssign=   CALL ID ('(' ProcParamList ')')?
''                |   ID ProcParamList?
''				  |	  (ID | FUNCTION) '=' Expression .
''
function cProcCallOrAssign as integer
	dim as FBSYMBOL ptr s
	dim as ASTNODE ptr expr, procexpr
	dim as integer dtype

	function = FALSE

	select case lexGetToken( )
	'' CALL?
	case FB_TK_CALL
		lexSkipToken( )

		'' ID
		s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC )
		if( s = NULL ) then
			hReportError( FB_ERRMSG_PROCNOTDECLARED )
			exit function
		end if

		lexSkipToken( )
		if( not cProcCall( s, procexpr, NULL, TRUE ) ) then
			exit function
		end if

		'' can't assign deref'ed functions with CALL's
		if( procexpr <> NULL ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

		return TRUE

	'' ID?
	case FB_TK_ID

		s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC )
		if( s <> NULL ) then
			lexSkipToken( )

			'' ID ProcParamList?
			if( not hMatch( FB_TK_ASSIGN ) ) then
				if( not cProcCall( s, procexpr, NULL ) ) then
					exit function
				end if

				'' assignament of a function deref?
				if( procexpr <> NULL ) then
					return cAssignment( procexpr )
            	end if

            	return TRUE

			'' ID '=' Expression
			else
                '' check if name is valid (or if overloaded)
				if( not symbIsProcOverloadOf( env.currproc, s ) ) then
					hReportError( FB_ERRMSG_ILLEGALOUTSIDEASUB, TRUE )
					exit function
				end if

				if( not cExpression( expr ) ) then
					hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
					exit function
				end if

        		return hAssignFunctResult( env.currproc, expr )
			end if

		end if

	'' FUNCTION?
	case FB_TK_FUNCTION
		'' '='?
		if( lexGetLookAhead(1) = FB_TK_ASSIGN ) then
			if( env.currproc = NULL ) then
				hReportError( FB_ERRMSG_ILLEGALOUTSIDEASUB )
				exit function
			end if

			lexSkipToken( )
			lexSkipToken( )

			'' Expression
			if( not cExpression( expr ) ) then
				hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if

        	return hAssignFunctResult( env.currproc, expr )
		end if
	end select

end function

