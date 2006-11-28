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


'' memory operations
''
'' chng: nov/2006 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''cOperatorNew =     NEW DataType Constructor?
''
function cOperatorNew _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

	dim as integer dtype = any, lgt = any, ptrcnt = any
	dim as FBSYMBOL ptr subtype = any, tmp = any
	dim as ASTNODE ptr expr = any, ctor_expr = any

	function = FALSE

	'' NEW
	lexSkipToken( )

	'' DataType
	if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
    	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: fake an expr
    		funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    		return TRUE
    	end if
	end if

	'' vector?
	dim as AST_OP op = AST_OP_NEW
	dim as ASTNODE ptr elmts_expr = NULL

	if( elmts_expr = NULL ) then
		elmts_expr = astNewCONSTi( 1, FB_DATATYPE_UINT )
	end if

	'' '['?
    if( lexGetToken( ) = CHAR_LBRACKET ) then
        lexSkipToken( )

        if( cExpression( elmts_expr ) = FALSE ) then
        	if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
        		exit function
        	end if
        else
        	op = AST_OP_NEW_VEC
        end if

        '' ']'
        if( lexGetToken( ) <> CHAR_RBRACKET ) then
        	if( errReport( FB_ERRMSG_EXPECTEDRBRACKET ) = FALSE ) then
        		exit function
        	else
        		hSkipUntil( CHAR_RBRACKET )
        	end if
        else
        	lexSkipToken( )
        end if
	end if

	'' Constructor?
	ctor_expr = NULL

	select case dtype
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		dim as integer is_explicit = FALSE

		if( symbGetHasCtor( subtype ) ) then
			'' '('?
			if( lexGetToken( ) = CHAR_LPRNT ) then
				if( cCtorCall( subtype, ctor_expr ) = FALSE ) then
					exit function
				end if

				is_explicit = TRUE

			else
				if( symbGetCompDefCtor( subtype ) = NULL ) then
					errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )
				else
					if( cCtorCall( subtype, ctor_expr ) = FALSE ) then
						exit function
					end if
				end if
			end if
		end if

		'' ctor + vector? not allowed..
		if( is_explicit ) then
			if( op = AST_OP_NEW_VEC ) then
				astDelTree( ctor_expr )
				ctor_expr = NULL

				if( errReport( FB_ERRMSG_EXPLICITCTORCALLINVECTOR, TRUE ) = FALSE ) then
					exit function
				end if
			end if
		end if
	end select

	'' temp pointer
	tmp = symbAddTempVar( FB_DATATYPE_POINTER + dtype, subtype, , FALSE )

	expr = astNewMEM( op, _
					  astNewVAR( tmp, _
						  		 0, _
						  		 FB_DATATYPE_POINTER + dtype, _
						  		 subtype ), _
					  elmts_expr, _
					  ctor_expr, _
					  dtype, _
					  subtype )

	if( expr = NULL ) then
    	if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    		exit function
    	end if
	end if

	astAdd( expr )

	'' return the pointer
	funcexpr = astNewVAR( tmp, _
						  0, _
						  FB_DATATYPE_POINTER + dtype, _
						  subtype )

	function = TRUE

end function

'':::::
''cOperatorDelete =     DELETE expr
''
function cOperatorDelete _
	( _
		_
	) as integer

	function = FALSE

	'' DELETE
	lexSkipToken( )

	function = TRUE

end function
