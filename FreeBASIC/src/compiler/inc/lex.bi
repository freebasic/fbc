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
	LEXCHECK_NOQUOTES	= 16
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

const FB_LEX_MAXK	= 1

type LEX_CTX
	tokenTB(0 to FB_LEX_MAXK) as FBTOKEN
	k				as integer					'' look ahead cnt (1..MAXK)

	currchar		as uinteger					'' current char
	lahdchar		as uinteger					'' look ahead char

	linenum 		as integer
	colnum 			as integer
	lasttoken 		as integer

	reclevel 		as integer					'' PP recursion

	'' last #define's text
	deftext			as zstring * FB_MAXINTDEFINELEN+1
	defptr 			as zstring ptr
	deflen 			as integer

	'' last WITH
	withcnt 		as integer

	'' input buffer
	bufflen			as integer
	buffptr			as zstring ptr
	buff			as zstring * 8192+1
	filepos			as integer
	lastfilepos 	as integer
end type


declare sub 		lexInit                 ( byval isinclude as integer )

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

declare function 	lexGetLookAheadClass 	( byval k as integer, _
											  byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING ) as integer

declare function 	lexGetLookAhead 		( byval k as integer, _
											  byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING ) as integer

declare function 	lexLineNum 				( ) as integer

declare function 	lexColNum 				( ) as integer

declare sub 		lexReadLine				( byval endchar as uinteger = INVALID, _
											  byval dst as string, _
											  byval skipline as integer = FALSE )

declare sub 		lexSkipLine				( )

declare sub 		lexSetToken				( byval id as integer, _
											  byval class as integer )

declare sub 		lexNextToken 			( t as FBTOKEN, _
											  byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING )

declare function 	lexCurrentChar          ( byval skipwhitespc as integer = FALSE ) as uinteger

declare function 	lexGetLookAheadChar     ( byval skipwhitespc as integer = FALSE ) as uinteger

declare function 	lexEatChar              ( ) as uinteger

declare function	lexPeekCurrentLine		( byref token_pos as string ) as string

declare sub 		lexPPInit				( )

declare sub 		lexPPEnd				( )

declare function 	lexPreProcessor 		( ) as integer

declare function	lexPPLoadDefine			( byval s as FBSYMBOL ptr ) as integer

''
'' inter-module globals
''
extern lex as LEX_CTX



