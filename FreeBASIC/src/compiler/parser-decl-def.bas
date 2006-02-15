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


'' DEF### declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
''DefDecl         =   (DEFINT|DEFLNG|DEFSNG|DEFDBL|DEFSTR) (CHAR '-' CHAR ','?)* .
''
function cDefDecl as integer static
    static as zstring * 32+1 char
    dim as integer typ, ichar, echar

	function = FALSE

	typ = INVALID

	select case as const lexGetToken( )
	case FB_TK_DEFBYTE
		typ = FB_DATATYPE_BYTE
	case FB_TK_DEFUBYTE
		typ = FB_DATATYPE_UBYTE
	case FB_TK_DEFSHORT
		typ = FB_DATATYPE_SHORT
	case FB_TK_DEFUSHORT
		typ = FB_DATATYPE_USHORT
	case FB_TK_DEFINT, FB_TK_DEFLNG
		typ = FB_DATATYPE_INTEGER
	case FB_TK_DEFUINT
		typ = FB_DATATYPE_UINT
	case FB_TK_DEFLNGINT
		typ = FB_DATATYPE_LONGINT
	case FB_TK_DEFULNGINT
		typ = FB_DATATYPE_ULONGINT
	case FB_TK_DEFUSHORT
		typ = FB_DATATYPE_USHORT
	case FB_TK_DEFSNG
		typ = FB_DATATYPE_SINGLE
	case FB_TK_DEFDBL
		typ = FB_DATATYPE_DOUBLE
	case FB_TK_DEFSTR
		typ = FB_DATATYPE_STRING
	end select

	if( typ <> INVALID ) then
		lexSkipToken( )

		'' (CHAR '-' CHAR ','?)*
		do
			'' CHAR
			char = ucase( *lexGetText( ) )
			if( len( char ) <> 1 ) then
				hReportError( FB_ERRMSG_EXPECTEDCOMMA )
				exit do
			end if
			ichar = asc( char )
			lexSkipToken( )

			'' '-'
			if( hMatch( CHAR_MINUS ) = FALSE ) then
				hReportError FB_ERRMSG_EXPECTEDMINUS
				exit do
			end if

			'' CHAR
			char = ucase( *lexGetText( ) )
			if( len( char ) <> 1 ) then
				hReportError( FB_ERRMSG_EXPECTEDCOMMA )
				exit do
			end if
			echar = asc( char )
			lexSkipToken( )

			''
			hSetDefType( ichar, echar, typ )

      		'' ','
      		if( lexGetToken( ) <> CHAR_COMMA ) then
      			exit do
      		else
      			lexSkipToken( )
      		end if

		loop

		function = TRUE
	end if

end function

