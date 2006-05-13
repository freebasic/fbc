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


''
'' lex protos
''

#include once "inc\dstr.bi"

enum LEXCHECK_ENUM
	LEXCHECK_EVERYTHING	= 0
	LEXCHECK_NOLINECONT	= 1
	LEXCHECK_NODEFINE	= 2
	LEXCHECK_NOWHITESPC	= 4
	LEXCHECK_NOSUFFIX	= 8
	LEXCHECK_NOQUOTES	= 16
	LEXCHECK_NOSYMBOL	= 32
	LEXCHECK_NOLOOKUP	= 64
	LEXCHECK_IDPERIOD	= 128
end enum

type FBTOKEN
	id				as integer
	class			as integer
	dtype			as integer

	'' used by literal strings too
	union
		text		as zstring * FB_MAXLITLEN+1
		textw		as wstring * FB_MAXLITLEN+1
	end union

	len				as integer                  '' length
	sym_chain		as FBSYMCHAIN ptr			'' symbol found, if any
	ppos			as integer

	next			as FBTOKEN ptr
end type

const FB_LEX_MAXK	= 2

const LEX_MAXBUFFCHARS = 8192

type LEX_CTX
	tokenTB(0 to FB_LEX_MAXK) as FBTOKEN
	k				as integer					'' look ahead cnt (1..MAXK)

	head			as FBTOKEN ptr
	tail			as FBTOKEN ptr

	currchar		as uinteger					'' current char
	lahdchar		as uinteger					'' look ahead char

	linenum 		as integer
	lasttk_id 		as integer

	reclevel 		as integer					'' PP recursion
	currmacro		as FBSYMBOL ptr

	'' last #define's text
	deflen 			as integer

	union
		type
			defptr 				as zstring ptr
			deftext				as DZSTRING
		end type

		type
			defptrw				as wstring ptr
			deftextw			as DWSTRING
		end type
	end union

	'' input buffer
	bufflen			as integer

	union
		type
			buffptr				as zstring ptr
			buff				as zstring * LEX_MAXBUFFCHARS+1
		end type

		type
			buffptrw			as wstring ptr
			buffw				as wstring * LEX_MAXBUFFCHARS+1
		end type
	end union

	filepos			as integer
	lastfilepos 	as integer
end type

declare sub 		lexInit                 ( _
												byval isinclude as integer _
											)

declare sub 		lexEnd					( _
											)

declare sub 		lexPushCtx				( _
											)

declare sub 		lexPopCtx				( _
											)

declare function 	lexGetToken 			( _
												byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING _
											) as integer

declare function 	lexGetClass 			( _
												byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING _
											) as integer

declare function 	lexGetText 				( _
											) as zstring ptr

declare sub 		lexEatToken 			( _
												byval token as zstring ptr, _
												byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING _
											)

declare sub 		lexSkipToken			( _
												byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING _
											)

declare function 	lexGetLookAheadClass 	( _
												byval k as integer, _
												byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING _
											) as integer

declare function 	lexGetLookAhead 		( _
												byval k as integer, _
												byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING _
											) as integer

declare sub 		lexReadLine				( _
												byval endchar as uinteger = INVALID, _
												byval dst as zstring ptr, _
												byval skipline as integer = FALSE _
											)

declare sub 		lexSkipLine				( _
											)

declare sub 		lexNextToken 			( _
												byval t as FBTOKEN ptr, _
												byval flags as LEXCHECK_ENUM = LEXCHECK_EVERYTHING _
											)

declare function 	lexCurrentChar          ( _
												byval skipwhitespc as integer = FALSE _
											) as uinteger

declare function 	lexGetLookAheadChar     ( _
												byval skipwhitespc as integer = FALSE _
											) as uinteger

declare function 	lexEatChar              ( _
											) as uinteger

declare function	lexPeekCurrentLine		( _
												byref token_pos as string _
											) as string


''
'' macros
''

#define lexLineNum( ) lex->linenum

#define lexGetLastToken( ) lex->lasttk_id

#define lexGetTextW( ) @lex->head->textw

#define lexGetTextLen( ) lex->head->len

#define lexGetType( ) lex->head->dtype

#define lexGetSymChain( ) lex->head->sym_chain

#define lexGetPeriodPos( ) lex->head->ppos

#define lexGetHead( ) lex->head

''
'' inter-module globals
''
extern lex as LEX_CTX ptr



