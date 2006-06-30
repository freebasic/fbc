#ifndef __PP_BI__
#define __PP_BI__

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

#include once "inc\list.bi"

enum FB_TOKEN_PP
	FB_TK_PP_IF					= FB_TK_IF
	FB_TK_PP_IFDEF
	FB_TK_PP_IFNDEF
	FB_TK_PP_ELSE
	FB_TK_PP_ELSEIF
	FB_TK_PP_ENDIF
	FB_TK_PP_DEFINE
	FB_TK_PP_UNDEF
	FB_TK_PP_MACRO
	FB_TK_PP_ENDMACRO
	FB_TK_PP_INCLUDE
	FB_TK_PP_INCLIB
	FB_TK_PP_LIBPATH
	FB_TK_PP_PRAGMA
	FB_TK_PP_PRINT
	FB_TK_PP_ERROR
	FB_TK_PP_LINE
end enum

type PP_CTX
	keyhash		as FBHASHTB
	argtblist	as TLIST
	level 		as integer
end type

declare sub 		ppInit					( )

declare sub 		ppEnd					( )

declare sub 		ppCheck					( )

declare function 	ppParse 				( ) as integer

declare sub		 	ppDefineInit			( )

declare sub		 	ppDefineEnd				( )

declare function 	ppDefine				( _
												byval ismultiline as integer _
											) as integer

declare function 	ppDefineLoad			( _
												byval s as FBSYMBOL ptr _
											) as integer

declare sub		 	ppPragmaInit			( )

declare sub		 	ppPragmaEnd				( )

declare function 	ppPragma				( ) as integer

declare sub		 	ppCondInit				( )

declare sub		 	ppCondEnd				( )

declare function 	ppCondIf 				( ) as integer

declare function 	ppCondElse 				( )  as integer

declare function 	ppCondEndIf 			( ) as integer


declare function 	ppReadLiteral			( _
												byval ismultiline as integer = FALSE _
											) as zstring ptr

declare function 	ppReadLiteralW			( _
												byval ismultiline as integer = FALSE _
											) as wstring ptr

''
'' inter-module globals
''
extern pp as PP_CTX


#endif ''__PP_BI__
