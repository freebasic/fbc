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

declare sub 		ppInit					( )

declare sub 		ppEnd					( )

declare function 	ppParse 				( ) as integer

declare sub		 	ppDefineInit			( )

declare sub		 	ppDefineEnd				( )

declare function 	ppDefine				( ) as integer

declare function 	ppDefineLoad			( byval s as FBSYMBOL ptr ) as integer

declare sub		 	ppPragmaInit			( )

declare sub		 	ppPragmaEnd				( )

declare function 	ppPragma				( ) as integer

declare sub		 	ppCondInit				( )

declare sub		 	ppCondEnd				( )

declare function 	ppCondIf 				( ) as integer

declare function 	ppCondElse 				( )  as integer

declare function 	ppCondEndIf 			( ) as integer


declare function 	ppReadLiteral			( ) as zstring ptr

declare function 	ppReadLiteralW			( ) as wstring ptr

#endif ''__PP_BI__
