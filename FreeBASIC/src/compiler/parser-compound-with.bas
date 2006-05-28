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


'' WITH..END WITH compound statement parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
private function hAllocWithVar( ) as FBSYMBOL ptr
    static as FBARRAYDIM dTB(0)
    dim as FBSYMBOL ptr sym, subtype
    dim as ASTNODE ptr expr
    dim as integer dtype

    '' Variable
    if( cVarOrDeref( expr ) = FALSE ) then
    	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    		return NULL
    	else
    		'' error recovery: fake a var
    		expr = astNewVAR( symbAddTempVar( FB_DATATYPE_INTEGER ), _
    						  0, _
    						  FB_DATATYPE_INTEGER )
    	end if

    else
		'' not an UDT?
		dtype = astGetDataType( expr )
		if( dtype <> FB_DATATYPE_USERDEF ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				return NULL
			end if
		end if
    end if

    '' create a temporary pointer
    dtype += FB_DATATYPE_POINTER
    subtype = astGetSubType( expr )

    sym = symbAddTempVar( dtype, subtype )

    '' load with the address of expr (sym = @expr)
    astAdd( astNewASSIGN( astNewVAR( sym, 0, dtype, subtype ), _
    			  		  astNewADDR( AST_OP_ADDROF, expr ) ) )


	function = sym

end function

'':::::
''WithStmtBegin   =   WITH Variable .
''
function cWithStmtBegin as integer
    dim as FBSYMBOL ptr sym
    dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	'' WITH
	lexSkipToken( )

	'' Variable
	sym = hAllocWithVar( )
	if( sym = NULL ) then
		exit function
	end if

	'' push to stmt stack
	stk = cCompStmtPush( FB_TK_WITH )

	stk->with.last = env.stmt.with.sym
	env.stmt.with.sym = sym

	function = TRUE

end function

'':::::
''WithStmtEnd	  =   END WITH .
''
function cWithStmtEnd as integer
	dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_WITH )
	if( stk = NULL ) then
		exit function
	end if

	'' END WITH
	lexSkipToken( )
	lexSkipToken( )

	'' pop from stmt stack
	env.stmt.with.sym = stk->with.last
	cCompStmtPop( stk )

	function = TRUE

end function

