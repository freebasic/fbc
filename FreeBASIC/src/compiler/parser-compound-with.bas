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
    	hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    	return NULL
    end if

	'' not an UDT?
	dtype = astGetDataType( expr )
	if( dtype <> FB_DATATYPE_USERDEF ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		return NULL
	end if

    '' create a temporary pointer
    dtype += FB_DATATYPE_POINTER
    subtype = astGetSubType( expr )

    sym = symbAddTempVar( dtype, subtype )

    '' load with the address of expr (sym = @expr)
    astAdd( astNewASSIGN( astNewVAR( sym, 0, dtype, subtype ), _
    			  		  astNewADDR( IR_OP_ADDROF, expr ) ) )


	function = sym

end function

'':::::
''WithStatement   =   WITH Variable Comment?
''					  SimpleLine*
''					  END WITH .
''
function cWithStatement as integer
    dim as FBSYMBOL ptr oldvar
    dim as integer lastcompstmt

	function = FALSE

	'' WITH
	lexSkipToken( )

	'' save old
	oldvar = env.withvar

	'' Variable
	env.withvar = hAllocWithVar( )
	if( env.withvar = NULL ) then
		env.withvar = oldvar
		exit function
	end if

	'' Comment?
	cComment( )

	'' separator
	if( cStmtSeparator( ) = FALSE ) then
		env.withvar = oldvar
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if

	''
	lastcompstmt     = env.lastcompound
	env.lastcompound = FB_TK_WITH

	'' loop body
	do
		if( cSimpleLine( ) = FALSE ) then
			exit do
		end if
	loop while( lexGetToken( ) <> FB_TK_EOF )

	'' restore old
	env.withvar = oldvar

	''
	env.lastcompound = lastcompstmt

	'' END WITH
	if( (hMatch( FB_TK_END ) = FALSE) or _
		(hMatch( FB_TK_WITH ) = FALSE) ) then
		hReportError( FB_ERRMSG_EXPECTEDENDWITH )
		exit function
	end if

	function = TRUE

end function

