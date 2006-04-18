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


'' pre-processor top-level module
''
'' chng: dec/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\dstr.bi"
#include once "inc\lex.bi"
#include once "inc\parser.bi"
#include once "inc\pp.bi"

#define LEX_FLAGS LEXCHECK_NOWHITESPC or LEXCHECK_NOSUFFIX or LEXCHECK_NODEFINE or LEXCHECK_NOQUOTES

declare function ppInclude					( ) as integer

declare function ppIncLib					( ) as integer

declare function ppLibPath					( ) as integer


''::::
sub ppInit( )

	ppDefineInit( )

	ppCondInit( )

	ppPragmaInit( )

end sub

''::::
sub ppEnd( )

	ppPragmaEnd( )

	ppCondEnd( )

	ppDefineEnd( )

end sub

'':::::
'' PreProcess    =   '#'DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL*
''               |   '#'UNDEF ID
''               |   '#'IFDEF ID
''               |   '#'IFNDEF ID
''               |   '#'IF Expression
''				 |	 '#'ELSE
''				 |   '#'ELSEIF Expression
''               |   '#'ENDIF
''               |   '#'PRINT LITERAL*
''				 |   '#'INCLUDE ONCE? LIT_STR
''				 |   '#'INCLIB LIT_STR
''				 |	 '#'LIBPATH LIT_STR
''				 |	 '#'ERROR LIT_STR .
''
function ppParse( ) as integer
    dim as FBSYMBOL ptr s

	function = FALSE

    '' note: when adding any new PP symbol, update ppSkip() too
    select case as const lexGetToken( )

    '' DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL+
    case FB_TK_DEFINE
    	lexSkipToken( LEXCHECK_NODEFINE )

    	function = ppDefine( )

	'' UNDEF ID
    case FB_TK_UNDEF
    	lexSkipToken( LEXCHECK_NODEFINE )

    	s = lexGetSymbol( )
    	if( s <> NULL ) then
    		symbDelSymbol( s )
    	end if

    	lexSkipToken( )

    	function = TRUE

	'' IFDEF ID
	'' IFNDEF ID
	'' IF ID '=' LITERAL
    case FB_TK_IFDEF, FB_TK_IFNDEF, FB_TK_IF
    	function = ppCondIf( )

	'' ELSE
	case FB_TK_ELSE, FB_TK_ELSEIF
    	function = ppCondElse( )

	'' ENDIF
	case FB_TK_ENDIF
		function = ppCondEndIf( )

	'' PRINT LITERAL*
	case FB_TK_PRINT, FB_TK_LPRINT
		lexSkipToken( )
		print *ppReadLiteral( )
		function = TRUE

	'' ERROR LITERAL*
	case FB_TK_ERROR
		lexSkipToken( )
		hReportErrorEx( -1, *ppReadLiteral( ) )
		exit function

	'' INCLUDE ONCE? LIT_STR
	case FB_TK_INCLUDE
		lexSkipToken( )
		function = ppInclude( )

	'' INCLIB LIT_STR
	case FB_TK_INCLIB
		lexSkipToken( )
        function = ppIncLib( )

	'' LIBPATH LIT_STR
	case FB_TK_LIBPATH
		lexSkipToken( )
		function = ppLibPath( )

	'' PRAGMA ...
	case FB_TK_PRAGMA
		lexSkipToken( )
		function = ppPragma( )

	case else
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
	end select

	'' Comment?
	cComment( )

	'' EOL
	if( lexGetToken( ) <> FB_TK_EOL ) then
		if( lexGetToken( ) <> FB_TK_EOF ) then
			hReportError( FB_ERRMSG_EXPECTEDEOL )
			return FALSE
		end if
	end if

end function

'':::::
private function ppInclude( ) as integer
    static as zstring * FB_MAXPATHLEN+1 incfile
    dim as integer isonce

	function = FALSE

	'' ONCE?
	isonce = FALSE
	if( lexGetClass( ) = FB_TKCLASS_IDENTIFIER ) then
		if( ucase$( *lexGetText( ) ) = "ONCE" ) then
			lexSkipToken( )
			isonce = TRUE
		end if
	end if

	lexEatToken( incfile )

	function = fbIncludeFile( incfile, isonce )

end function

'':::::
private function ppIncLib( ) as integer
    static as zstring * FB_MAXPATHLEN+1 libfile

	lexEatToken( libfile )

	function = symbAddLib( libfile ) <> NULL

end function

'':::::
private function ppLibPath( ) as integer
    static as zstring * FB_MAXPATHLEN+1 path

	lexEatToken( path )

	if( fbAddLibPath( path ) = FALSE ) then
		hReportError( FB_ERRMSG_SYNTAXERROR, TRUE )
		return FALSE
	end if

	function = TRUE

end function


'':::::
function ppReadLiteral( ) as zstring ptr
	static as DZSTRING text

    DZstrAllocate( text, 0 )

    do
    	select case lexGetToken( LEX_FLAGS )
		case FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM
			exit do
		end select

    	if( lexGetType() <> FB_DATATYPE_WCHAR ) then
    		DZstrConcatAssign( text, lexGetText( ) )
    	else
    	    DZstrConcatAssignW( text, lexGetTextW( ) )
    	end if

    	lexSkipToken( LEX_FLAGS )

    loop

	function = text.data

end function

'':::::
function ppReadLiteralW( ) as wstring ptr
	static as DWSTRING text

    DWstrAllocate( text, 0 )

    do
    	select case lexGetToken( LEX_FLAGS )
		case FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM
			exit do
		end select

    	if( lexGetType() = FB_DATATYPE_WCHAR ) then
    		DWstrConcatAssign( text, lexGetTextW( ) )
    	else
    		DWstrConcatAssignA( text, lexGetText( ) )
    	end if

    	lexSkipToken( LEX_FLAGS )

    loop

	function = text.data

end function


