''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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

enum LEXCHECK
	
	LEXCHECK_EVERYTHING		= &h0000
	
	'' ? write this comment
	LEXCHECK_NOLINECONT		= &h0001 
	
	'' don't replace define/macro text
	LEXCHECK_NODEFINE		= &h0002 
	
	'' return CHAR_SPACE, CHAR_TAB... (usually skipped when lexing)
	LEXCHECK_NOWHITESPC		= &h0004 
	
	'' don't interpret $, #, &, etc as a suffix on a token (for #include, $include, &h1, more?)
	LEXCHECK_NOSUFFIX		= &h0008 
	
	'' retain quotes in any literal string's token (otherwise, hReadString removes quotes so lexGetText can cleanly return the string's content)
	LEXCHECK_NOQUOTES		= &h0010 
	
	'' don't associate the token with a symbol chain (dim shared as integer foo: #define bar(foo) 
	LEXCHECK_NOSYMBOL		= &h0020 
	
	'' return CHAR_DOT (usually incorporated into whatever symbol when lexing)
	LEXCHECK_NOPERIOD		= &h0040 
	
	'' used to handle the 'periods in symbol name' garbage
	LEXCHECK_EATPERIOD		= &h0080 
	
	'' use the special symbol 'namespace' for pre-processing, to prevent polluting the global ns
	LEXCHECK_KWDNAMESPC		= &h0100 
	
	'' ignore multi-line comment markers in code (don't allow them in single-line comments)
	LEXCHECK_NOMULTILINECOMMENT	= &h0200 
	
	'' don't interpret f, u, l as type-specifier suffixes on numeric literals (used in asm blocks)
	LEXCHECK_NOLETTERSUFFIX	= &h0200 
	
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

	union
		prdpos		as integer					'' period '.' pos in symbol names
		hasesc		as integer					'' any '\' in literals
	end union

	after_space		as integer

	next			as FBTOKEN ptr
end type

const FB_LEX_MAXK	= 3

const LEX_MAXBUFFCHARS = 8192

type LEX_TKCTX
	tokenTB(0 to FB_LEX_MAXK) as FBTOKEN
	k				as integer					'' look ahead cnt (1..MAXK)

	head			as FBTOKEN ptr
	tail			as FBTOKEN ptr

	currchar		as uinteger					'' current char
	lahdchar		as uinteger					'' look ahead char

	linenum 		as integer
	lasttk_id 		as integer

	reclevel 		as integer					'' PP recursion
	currmacro		as FBSYMBOL ptr				'' used to check macro recursion

	kwdns			as FBSYMBOL ptr				'' used by the PP

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

	currline		as DZSTRING					'' current line in text form

	after_space		as integer
end type

type LEX_CTX
	ctxTB( 0 TO FB_MAXINCRECLEVEL-0 ) as LEX_TKCTX
	ctx 			as LEX_TKCTX ptr

	insidemacro 	as integer
end type

declare sub lexInit _
	( _
		byval isinclude as integer _
	)

declare sub lexEnd _
	( _
	)

declare sub lexPushCtx _
	( _
	)

declare sub lexPopCtx _
	( _
	)

declare function lexGetToken _
	( _
		byval flags as LEXCHECK = LEXCHECK_EVERYTHING _
	) as integer

declare function lexGetClass _
	( _
		byval flags as LEXCHECK = LEXCHECK_EVERYTHING _
	) as integer

declare function lexGetText _
	( _
	) as zstring ptr

declare sub lexEatToken _
	( _
		byval token as zstring ptr, _
		byval flags as LEXCHECK = LEXCHECK_EVERYTHING _
	)

declare sub lexSkipToken _
	( _
		byval flags as LEXCHECK = LEXCHECK_EVERYTHING _
	)

declare function lexGetLookAheadClass _
	( _
		byval k as integer, _
		byval flags as LEXCHECK = LEXCHECK_EVERYTHING _
	) as integer

declare function lexGetLookAhead _
	( _
		byval k as integer, _
		byval flags as LEXCHECK = LEXCHECK_EVERYTHING _
	) as integer

declare sub lexReadLine _
	( _
		byval endchar as uinteger = INVALID, _
		byval dst as zstring ptr, _
		byval skipline as integer = FALSE _
	)

declare sub lexSkipLine _
	( _
	)

declare sub lexNextToken _
	( _
		byval t as FBTOKEN ptr, _
		byval flags as LEXCHECK = LEXCHECK_EVERYTHING _
	)

declare function lexCurrentChar _
	( _
		byval skipwhitespc as integer = FALSE _
	) as uinteger

declare function lexGetLookAheadChar _
	( _
		byval skipwhitespc as integer = FALSE _
	) as uinteger

declare function lexEatChar _
	( _
	) as uinteger

declare function lexPeekCurrentLine _
	( _
		byref token_pos as string, _
		byval do_trim as integer _
	) as string


''
'' macros
''

#define lexLineNum( ) lex.ctx->linenum

#define lexGetLastToken( ) lex.ctx->lasttk_id

#define lexGetTextW( ) @lex.ctx->head->textw

#define lexGetTextLen( ) lex.ctx->head->len

#define lexGetType( ) lex.ctx->head->dtype

#define lexGetSymChain( ) lex.ctx->head->sym_chain

#define lexGetPeriodPos( ) lex.ctx->head->prdpos

#define lexGetHasSlash( ) lex.ctx->head->hasesc

#define lexGetHead( ) lex.ctx->head

#define lexCurrLineGet( ) lex.ctx->currline.data

#define lexCurrLineReset( ) DZstrReset( lex.ctx->currline )

''
'' inter-module globals
''
extern lex as LEX_CTX



