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


'' label declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''Label           =   NUM_LIT
''                |   ID ':' .
''
function cLabel as integer
    dim l as FBSYMBOL ptr

    function = FALSE

    l = NULL

    '' NUM_LIT
    select case lexGetClass( )
    case FB_TKCLASS_NUMLITERAL
		if( lexGetType( ) = FB_DATATYPE_INTEGER ) then
			l = symbAddLabel( lexGetText( ), TRUE, TRUE )
			if( l = NULL ) then
				hReportError( FB_ERRMSG_DUPDEFINITION )
				exit function
			else
				lexSkipToken( )
			end if
		end if

		'' fake a ':'
		env.stmtcnt += 1

	'' ID
	case FB_TKCLASS_IDENTIFIER
		'' ':'
		if( lexGetLookAhead(1) = CHAR_COLON ) then

			'' ambiguity: it could be a proc call followed by a ':' stmt separator..
			if( symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_PROC ) <> NULL ) then
				exit function
			end if

			l = symbAddLabel( lexGetText( ), TRUE, TRUE )
			if( l = NULL ) then
				hReportError( FB_ERRMSG_DUPDEFINITION )
				exit function
			else
				lexSkipToken( )
			end if

			'' skip ':'
			lexSkipToken( )

		end if
    end select

    if( l <> NULL ) then

    	astAdd( astNewLABEL( l ) )

    	symbSetLastLabel( l )

    	function = TRUE
    end if

end function

