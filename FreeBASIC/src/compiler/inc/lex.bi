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


''
'' lex protos
''

enum LEXCHECK_ENUM
	LEXCHECK_EVERYTHING	= 0
	LEXCHECK_NOLINECONT	= 1
	LEXCHECK_NODEFINE	= 2
	LEXCHECK_NOWHITESPC	= 4
	LEXCHECK_NOSUFFIX	= 8
end enum

type FBTOKEN
	id				as integer
	class			as integer
	typ				as integer
	text			as zstring * FB_MAXLITLEN+1	'' used by literal strings too
	tlen			as integer                  '' length
	dotpos			as integer                  '' first '.' position, if any
	sym				as FBSYMBOL ptr				'' symbol found, if any
end type


declare sub 		lexInit                 ( )

declare sub 		lexEnd					( )

declare sub 		lexSaveCtx				( byval level as integer )

declare sub 		lexRestoreCtx			( byval level as integer )

declare function 	lexGetToken 			( byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING ) as integer

declare function 	lexGetClass 			( byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING ) as integer

declare function 	lexGetText 				( ) as zstring ptr

declare function 	lexGetTextLen 			( ) as integer

declare function 	lexGetType 				( ) as integer

declare function 	lexGetSymbol 			( ) as FBSYMBOL ptr

declare function 	lexGetPeriodPos 		( ) as integer

declare sub 		lexEatToken 			( byval token as string, _
											  byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING )

declare sub 		lexSkipToken			( byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING )

declare function 	lexGetLookAheadClass 	( byval k as integer ) as integer

declare function 	lexGetLookAhead 		( byval k as integer ) as integer

declare function 	lexLineNum 				( ) as integer

declare function 	lexColNum 				( ) as integer

declare sub 		lexReadLine				( byval endchar as uinteger = INVALID, _
											  byval dst as string, _
											  byval skipline as integer = FALSE )

declare sub 		lexSkipLine				( )

declare sub 		lexSetToken				( byval id as integer, _
											  byval class as integer )

declare function 	lexPreProcessor 		( ) as integer

declare function	lexPeekCurrentLine		( byref token_pos as string ) as string
