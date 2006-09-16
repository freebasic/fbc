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
		byref funcexpr as ASTNODE ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr _
	) as integer

	dim as integer dtype = any, isfuncptr = any
	dim as FBSYMBOL ptr subtype = any

	function = FALSE

    if( sym = NULL ) then
    	exit function
    end if

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

    dtype = astGetDataType( funcexpr )
    subtype = astGetSubtype( funcexpr )

	'' is it really a function?
	if( dtype = FB_DATATYPE_VOID ) then
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		end if
	end if

	'' if function returns a pointer, check for field deref
	if( dtype >= FB_DATATYPE_POINTER ) then

		isfuncptr = FALSE
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if

		'' FuncPtrOrDerefFields?
		cFuncPtrOrDerefFields( dtype, subtype, funcexpr, isfuncptr, TRUE )

		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

	'' error recovery: remove the SUB call, return a fake node
	elseif( dtype = FB_DATATYPE_VOID ) then
		astDelTree( funcexpr )
		funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if

	function = TRUE

end function

'':::::
''Function        =   ID ('(' ProcParamList ')')? FuncPtrOrDerefFields? .
''
function cFunctionEx _
	( _
		byval sym as FBSYMBOL ptr, _
		byref funcexpr as ASTNODE ptr _
	) as integer

	'' ID
	lexSkipToken( )

	function = cFunctionCall( sym, funcexpr, NULL )

end function
