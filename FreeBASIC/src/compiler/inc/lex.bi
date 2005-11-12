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

	'' used by literal strings too
	union
		text		as zstring * FB_MAXLITLEN+1
		textw		as wstring * FB_MAXLITLEN+1
	end union

	tlen			as integer                  '' length
	dotpos			as integer                  '' first '.' position, if any
	sym				as FBSYMBOL ptr				'' symbol found, if any

	next			as FBTOKEN ptr
end type

const FB_LEX_MAXK	= 2

type LEX_CTX
	tokenTB(0 to FB_LEX_MAXK) as FBTOKEN
	k				as integer					'' look ahead cnt (1..MAXK)

	head			as FBTOKEN ptr
	tail			as FBTOKEN ptr

	currchar		as uinteger					'' current char
	lahdchar		as uinteger					'' look ahead char

	linenum 		as integer
	colnum 			as integer
	lasttoken 		as integer

	reclevel 		as integer					'' PP recursion

	'' last #define's text
	deflen 			as integer

	union
		type
			defptr 				as zstring ptr
			deftext				as zstring * FB_MAXINTDEFINELEN+1
		end type

		type
			defptrw				as wstring ptr
			deftextw			as wstring * FB_MAXINTDEFINELEN+1
		end type
	end union

	'' last WITH
	withcnt 		as integer

	'' input buffer
	bufflen			as integer

	union
		type
			buffptr				as ubyte ptr
			buff				as zstring * 8192+1
		end type

		type
			buff16ptr			as ushort ptr
			buff16(0 to 8192-1)	as ushort
		end type

		type
			buff32ptr			as uinteger ptr
			buff32(0 to 8192-1)	as uinteger
		end type
	end union

	filepos			as integer
	lastfilepos 	as integer
end type


declare sub 		lexInit                 ( byval isinclude as integer )

declare sub 		lexEnd					( )

declare sub 		lexPushCtx				( )

declare sub 		lexPopCtx				( )

declare function 	lexGetToken 			( byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING ) as integer

declare function 	lexGetClass 			( byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING ) as integer

declare function 	lexGetText 				( ) as zstring ptr

declare function 	lexGetTextW				( ) as wstring ptr

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

declare sub 		lexNextToken 			( byval t as FBTOKEN ptr, _
											  byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING )

declare function 	lexCurrentChar          ( byval skipwhitespc as integer = FALSE ) as uinteger

declare function 	lexGetLookAheadChar     ( byval skipwhitespc as integer = FALSE ) as uinteger

declare function 	lexEatChar              ( ) as uinteger

declare function	lexPeekCurrentLine		( byref token_pos as string ) as string


''
'' inter-module globals
''
extern lex as LEX_CTX ptr



