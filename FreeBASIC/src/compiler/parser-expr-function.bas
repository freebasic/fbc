''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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
function cFunctionCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr funcexpr = any

	function = NULL

    if( sym = NULL ) then
    	exit function
    end if

	'' property?
	if( symbIsProperty( sym ) ) then

		if( symGetProcOvlMinParams( sym ) <> 1 ) then
    		if( errReport( FB_ERRMSG_PROPERTYHASNOGETMETHOD ) = FALSE ) then
    			exit function
    		end if
		end if

		'' no args
		funcexpr = cProcArgList( sym, ptrexpr, thisexpr, TRUE, TRUE )
		if( funcexpr = NULL ) then
			exit function
		end if

	else
		'' '('?
		if( lexGetToken( ) = CHAR_LPRNT ) then
			lexSkipToken( )

			'' ProcArgList
			funcexpr = cProcArgList( sym, ptrexpr, thisexpr, TRUE, FALSE )
			if( funcexpr = NULL ) then
				exit function
			end if

			'' ')'
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

		else
			'' ProcArgList (function can have optional params)
			funcexpr = cProcArgList( sym, ptrexpr, thisexpr, TRUE, TRUE )
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
			funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			exit function
		end if
	end if

	if( cStrIdxOrFieldDeref( funcexpr ) = FALSE ) then
		exit function
	end if

	function = funcexpr

end function

'':::::
''Function        =   ID ('(' ProcParamList ')')? FuncPtrOrDerefFields? .
''
function cFunctionEx _
	( _
		byval sym as FBSYMBOL ptr, _
		byref funcexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr this_ = NULL

	'' ID
	lexSkipToken( )

	if( symbIsMethod( sym ) ) then
		this_ = astBuildInstPtr( _
					symbGetParamVar( _
						symbGetProcHeadParam( parser.currproc ) ) )
	end if

	funcexpr = cFunctionCall( sym, NULL, this_ )

	function = funcexpr <> NULL

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
		expr = cFunctionCall( sym, NULL, thisexpr )

		'' no need to check expr, cFunctionCall() will handle VOID calls

	'' assignment..
	else
		expr = cProcCall( sym, NULL, thisexpr )

		'' ditto
	end if

	function = expr

end function

'':::::
function cCtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byref atom as ASTNODE ptr _
	) as integer

	dim as FBSYMBOL ptr tmp = any
	dim as integer isprnt = any
	dim as ASTNODE ptr procexpr = any

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

	procexpr = cProcArgList( symbGetCompCtorHead( sym ), _
					  		 NULL, _
					  		 astBuildVarField( tmp ), _
					  		 TRUE, _
					  		 FALSE )
	if( procexpr = NULL ) then
		return FALSE
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

	'' error recovery..
	if( astIsCALL( procexpr ) ) then
		atom = astNewCALLCTOR( procexpr, astBuildVarField( tmp ) )

		if( symbGetHasDtor( sym ) ) then
			symbSetIsTempWithDtor( tmp, TRUE )
		end if

	else
		atom = procexpr
	end if

	function = ( atom <> NULL )

end function


