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
function cAssignFunctResult _
	( _
		byval proc as FBSYMBOL ptr _
	) as integer static

    dim as FBSYMBOL ptr s
    dim as ASTNODE ptr assg, expr

    function = FALSE

    s = symbGetProcResult( proc )
    if( s = NULL ) then
    	if( hReportError( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: skip stmt, return
    		hSkipStmt( )
    		return TRUE
    	end if
    end if

    '' set the context symbol to allow taking the address of overloaded
    '' procs and also to allow anonymous UDT's
    env.ctxsym = symbGetSubType( proc )

	'' Expression
	if( cExpression( expr ) = FALSE ) then
		env.ctxsym = NULL
		if( hReportError( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			exit function
		else
    		'' error recovery: skip stmt, return
    		hSkipStmt( )
    		return TRUE
    	end if
	end if

	env.ctxsym = NULL

    assg = astNewVAR( s, 0, symbGetType( s ), symbGetSubtype( s ) )

	'' proc returns an UDT?
	if( symbGetType( proc ) = FB_DATATYPE_USERDEF ) then
		'' pointer? deref
		if( symbGetProcRealType( proc ) = FB_DATATYPE_POINTER + FB_DATATYPE_USERDEF ) then
			assg = astNewPTR( 0, assg, FB_DATATYPE_USERDEF, symbGetSubType( proc ) )
		end if
	end if

    assg = astNewASSIGN( assg, expr )
    if( assg = NULL ) then
    	astDelTree( expr )
    	if( hReportError( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    		exit function
    	else
    		return TRUE
    	end if
    end if

    astAdd( assg )

    function = TRUE

end function

'':::::
function cProcCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byref procexpr as ASTNODE ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval checkprnts as integer = FALSE _
	) as integer

	dim as integer dtype, isfuncptr, doflush
	dim as FBSYMBOL ptr subtype, reslabel

	function = FALSE

	if( checkprnts = TRUE ) then
		'' if the sub has no args, prnts are optional
		if( symbGetProcParams( sym ) = 0 ) then
			checkprnts = FALSE
		end if

	'' if it's a function pointer, prnts are obligatory
	elseif( ptrexpr <> NULL ) then
		checkprnts = TRUE

	end if

	if( checkprnts ) then
		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			if( hReportError( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
				exit function
			end if
		end if

	end if

	env.prntcnt = 0
	env.prntopt	= not checkprnts

	'' ProcArgList
	procexpr = cProcArgList( sym, ptrexpr, FALSE, FALSE )
	if( procexpr = NULL ) then
		exit function
	end if

	'' ')'
	if( (checkprnts) or (env.prntcnt > 0) ) then

		'' --parent cnt
		env.prntcnt -= 1

		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			if( hReportError( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
			end if

		elseif( env.prntcnt > 0 ) then
			'' error recovery: skip until all ')'s are found
			do while( env.prntcnt > 0 )
				hSkipUntil( CHAR_RPRNT, TRUE )
				env.prntcnt -= 1
			loop
		end if

	end if

	env.prntopt	= FALSE

	dtype = symbGetType( sym )

	'' if function returns a pointer, check for field deref
	doflush = TRUE
	if( dtype >= FB_DATATYPE_POINTER ) then
    	subtype = symbGetSubType( sym )

		isfuncptr = FALSE
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if

		'' FuncPtrOrDerefFields?
		if( cFuncPtrOrDerefFields( dtype, subtype, _
								   procexpr, isfuncptr, _
								   TRUE ) = FALSE ) then
			'' error?
			if( hGetLastError( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

		'' type changed
		else
			doflush = FALSE
			dtype = astGetDataType( procexpr )

			'' if it stills a function, unless type = string (ie: implicit pointer),
			'' flush it, as the assignment would be invalid
			if( astIsFUNCT( procexpr ) ) then
				if( dtype <> FB_DATATYPE_STRING ) then
					doflush = TRUE
				end if
			end if

		end if

		sym = astGetSymbol( procexpr )

	end if

	''
	if( doflush ) then
		'' can proc's result be skipped?
		if( dtype <> FB_DATATYPE_VOID ) then
			if( symbGetDataClass( dtype ) <> FB_DATACLASS_INTEGER ) then
				if( hReportError( FB_ERRMSG_VARIABLEREQUIRED ) = FALSE ) then
					exit function
				else
					'' error recovery: skip
					astDelTree( procexpr )
					procexpr = NULL
					return TRUE
				end if

    		'' CHAR and WCHAR literals are also from the INTEGER class
    		else
    			select case dtype
    			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
					if( hReportError( FB_ERRMSG_VARIABLEREQUIRED ) = FALSE ) then
						exit function
					else
						'' error recovery: skip
						astDelTree( procexpr )
						procexpr = NULL
						return TRUE
					end if
				end select
			end if
		end if

		'' check error?
		if( sym <> NULL ) then
			if( symbGetIsThrowable( sym ) ) then
    			if( env.clopt.resumeerr ) then
					reslabel = symbAddLabel( NULL )
    				astAdd( astNewLABEL( reslabel ) )
    			else
    				reslabel = NULL
    			end if

				function = rtlErrorCheck( procexpr, reslabel, lexLineNum( ) )
				procexpr = NULL
				return TRUE
			end if
		end if

		astSetDataType( procexpr, FB_DATATYPE_VOID )
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
	dim as ASTNODE ptr expr
	dim as integer dtype
	dim as FBSYMCHAIN ptr chain_

	function = FALSE

	select case lexGetToken( )
	'' CALL?
	case FB_TK_CALL
    	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
    		exit function
    	end if

		lexSkipToken( )

		'' ID
		chain_ = cIdentifier( )
		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

		s = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
		if( s = NULL ) then
			if( hReportError( FB_ERRMSG_PROCNOTDECLARED ) = FALSE ) then
				exit function
			else
				'' error recovery: skip stmt, return
				hSkipStmt( )
				return TRUE
			end if
		end if

		lexSkipToken( )

		if( cProcCall( s, expr, NULL, TRUE ) = FALSE ) then
			exit function
		end if

		'' can't assign deref'ed functions with CALL's
		if( expr <> NULL ) then
			astDelTree( expr )
			if( hReportError( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if
		end if

		return TRUE

	'' ID?
	case FB_TK_ID

		chain_ = cIdentifier( )
		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

    	do while( chain_ <> NULL )

    		s = chain_->sym
    		select case symbGetClass( s )
    		'' proc?
    		case FB_SYMBCLASS_PROC
    			if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
	   				exit function
    			end if

				lexSkipToken( )

				'' ID ProcParamList?
				if( hMatch( FB_TK_ASSIGN ) = FALSE ) then
					if( cProcCall( s, expr, NULL ) = FALSE ) then
						exit function
					end if

					'' assignment of a function deref?
					if( expr <> NULL ) then
						return cAssignment( expr )
           			end if

           			return TRUE

				'' ID '=' Expression
				else
               		'' check if name is valid (or if overloaded)
					if( symbIsProcOverloadOf( env.currproc, s ) = FALSE ) then
						if( hReportError( FB_ERRMSG_ILLEGALOUTSIDEASUB, TRUE ) = FALSE ) then
							exit function
						else
							'' error recovery: skip stmt, return
							hSkipStmt( )
							return TRUE
						end if
					end if

        			return cAssignFunctResult( env.currproc )
				end if

    		'' variable?
    		case FB_SYMBCLASS_VAR
    	    	'' must process variables here, multiple calls to
    	    	'' Identifier() will fail if a namespace was explicitly
    	    	'' given, because the next call will return an inner symbol
    	    	if( cVariableEx( chain_, expr, TRUE ) = FALSE ) then
    	    		exit function
    	    	end if

    	    	return cAssignmentOrPtrCallEx( expr )
			end select

    		chain_ = symbChainGetNext( chain_ )
    	loop

	'' FUNCTION?
	case FB_TK_FUNCTION
		'' '='?
		if( lexGetLookAhead( 1 ) = FB_TK_ASSIGN ) then
			if( fbIsModLevel( ) ) then
				if( hReportError( FB_ERRMSG_ILLEGALOUTSIDEASUB ) = FALSE ) then
					exit function
				else
					'' error recovery: skip stmt, return
					hSkipStmt( )
					return TRUE
				end if
			end if

			lexSkipToken( )
			lexSkipToken( )

        	return cAssignFunctResult( env.currproc )
		end if
	end select

end function

