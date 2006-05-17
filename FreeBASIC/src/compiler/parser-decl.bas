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


'' declarations top-level parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
''Declaration     =   ConstDecl | TypeDecl | VariableDecl | ProcDecl | DefDecl | OptDecl.
''
function cDeclaration as integer static

	select case as const lexGetToken( )
	case FB_TK_CONST
		function = cConstDecl( )

	case FB_TK_DECLARE
		function = cProcDecl( )

	case FB_TK_TYPE, FB_TK_UNION
		function = cTypeDecl( )

	case FB_TK_ENUM
		function = cEnumDecl( )

	case FB_TK_DIM, FB_TK_REDIM, FB_TK_COMMON, FB_TK_EXTERN, FB_TK_STATIC
		function = cVariableDecl( )

	case FB_TK_DEFBYTE, FB_TK_DEFUBYTE, FB_TK_DEFSHORT, FB_TK_DEFUSHORT, _
		 FB_TK_DEFINT, FB_TK_DEFLNG, FB_TK_DEFUINT, FB_TK_DEFSNG, FB_TK_DEFDBL, _
	 	 FB_TK_DEFSTR, FB_TK_DEFLNGINT, FB_TK_DEFULNGINT
		function = cDefDecl( )

	case FB_TK_OPTION
		function = cOptDecl( )

	case else
		function = FALSE
	end select

end function

