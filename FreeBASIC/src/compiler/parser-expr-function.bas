''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


'' function call parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
#macro hParseRPNT( )
	if( lexGetToken( ) <> CHAR_RPRNT ) then
    	if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: skip until next ')'
    		hSkipUntil( CHAR_RPRNT, TRUE )
    	end if
	else
		lexSkipToken( )
	end if
#endmacro

'':::::
function cFunctionCall _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr funcexpr = any
	dim as FB_CALL_ARG_LIST arg_list = ( 0, NULL, NULL )

	function = NULL

    if( sym = NULL ) then
    	exit function
    end if

	dim as FB_PARSEROPT options = FB_PARSEROPT_ISFUNC

	'' method call?
	if( thisexpr <> NULL ) then
		dim as FB_CALL_ARG ptr arg = symbAllocOvlCallArg( @parser.ovlarglist, @arg_list, FALSE )
		arg->expr = thisexpr
		arg->mode = hGetInstPtrMode( thisexpr )
		options or= FB_PARSEROPT_HASINSTPTR
	end if

	'' property?
	if( symbIsProperty( sym ) ) then

		options or= FB_PARSEROPT_ISPROPGET

		'' '('? indexed..
		if( lexGetToken( ) = CHAR_LPRNT ) then
			if( symbGetUDTHasIdxGetProp( symbGetParent( sym ) ) = FALSE ) then
				if( errReport( FB_ERRMSG_PROPERTYHASNOIDXGETMETHOD, TRUE ) = FALSE ) then
					exit function
				end if
			end if

			lexSkipToken( )

			funcexpr = cProcArgList( base_parent, sym, ptrexpr, @arg_list, options )
			if( funcexpr = NULL ) then
				exit function
			end if

			'' ')'
			hParseRPNT( )

		'' not indexed..
		else
			if( symbGetUDTHasGetProp( symbGetParent( sym ) ) = FALSE ) then
    			if( errReport( FB_ERRMSG_PROPERTYHASNOGETMETHOD ) = FALSE ) then
    				exit function
    			end if
			end if

			'' no args
			funcexpr = cProcArgList( base_parent, _
									 sym, _
									 ptrexpr, _
									 @arg_list, _
									 options or FB_PARSEROPT_OPTONLY )
			if( funcexpr = NULL ) then
				exit function
			end if
		end if

	else
		'' '('?
		if( lexGetToken( ) = CHAR_LPRNT ) then
			lexSkipToken( )

			'' ProcArgList
			funcexpr = cProcArgList( base_parent, sym, ptrexpr, @arg_list, options )
			if( funcexpr = NULL ) then
				exit function
			end if

			'' ')'
			hParseRPNT( )

		else
			'' ProcArgList (function could have optional params)
			funcexpr = cProcArgList( base_parent, _
									 sym, _
									 ptrexpr, _
									 @arg_list, _
									 options or FB_PARSEROPT_OPTONLY )
			if( funcexpr = NULL ) then
				exit function
			end if
		end if

	end if

	'' is it really a function?
	if( astGetDataType( funcexpr ) = FB_DATATYPE_VOID ) then
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		else
			'' error recovery: remove the SUB call, return a fake node
			astDelTree( funcexpr )
			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
	end if

	''
	function = cStrIdxOrMemberDeref( funcexpr )

end function

'':::::
''Function        =   ID ('(' ProcParamList ')')? FuncPtrOrMemberDeref? .
''
function cFunctionEx _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	'' ID
	lexSkipToken( )

	function = cFunctionCall( base_parent, sym, NULL, NULL )

end function

'':::::
function cMethodCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any

	'' ID
	lexSkipToken( )

	'' inside an expression? (can't check sym type, it could be an overloaded proc)
	if( fbGetIsExpression( ) ) then
		expr = cFunctionCall( NULL, sym, NULL, thisexpr )

		'' no need to check expr, cFunctionCall() will handle VOID calls

	'' assignment..
	else
		expr = cProcCall( NULL, sym, NULL, thisexpr )

		'' ditto
	end if

	function = expr

end function

'':::::
function cCtorCall _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr tmp = any
	dim as integer isprnt = any
	dim as ASTNODE ptr procexpr = any
	dim as FB_CALL_ARG_LIST arg_list = ( 0, NULL, NULL )

    '' alloc temp var
    tmp = symbAddTempVar( symbGetType( sym ), _
    					  sym, _
    					  FALSE, _
    					  FALSE )


	'' '('?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )
		isprnt = TRUE
	else
		isprnt = FALSE
	end if

    '' pass the instance ptr
	dim as FB_CALL_ARG ptr arg = symbAllocOvlCallArg( @parser.ovlarglist, @arg_list, FALSE )
	arg->expr = astBuildVarField( tmp )
	arg->mode = INVALID

	procexpr = cProcArgList( NULL, _
							 symbGetCompCtorHead( sym ), _
					  		 NULL, _
					  		 @arg_list, _
					  		 FB_PARSEROPT_ISFUNC or _
					  		 FB_PARSEROPT_HASINSTPTR or _
					  		 iif( isprnt = FALSE, _
					  		 	  FB_PARSEROPT_OPTONLY, _
					  		 	  FB_PARSEROPT_NONE ) )
	if( procexpr = NULL ) then
		return NULL
	end if

	if( isprnt ) then
		'' ')'?
		if( lexGetToken( ) <> CHAR_RPRNT ) then
			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
				return FALSE
			else
				'' error recovery: skip until next ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
			end if
		else
			lexSkipToken( )
		end if
	end if

	'' check if it's a call (because error recovery)..
	if( astIsCALL( procexpr ) ) then

		if( symbGetHasDtor( sym ) ) then
			astDtorListAdd( tmp )
		end if

		function = astNewCALLCTOR( procexpr, astBuildVarField( tmp ) )

	else
		function = procexpr
	end if

end function


