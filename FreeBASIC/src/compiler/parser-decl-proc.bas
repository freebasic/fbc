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


'' proc (SUB or FUNCTION) declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''ProcDecl        =   DECLARE (SUB SubDecl) |
''                            (FUNCTION FuncDecl) .
''
function cProcDecl as integer

    function = FALSE

    '' DECLARE
    lexSkipToken( )

	select case lexGetToken( )
	case FB_TK_SUB
		lexSkipToken( )
		function = cSubOrFuncDecl( TRUE )

	case FB_TK_FUNCTION
		lexSkipToken( )
		function = cSubOrFuncDecl( FALSE )

	case else
		hReportError( FB_ERRMSG_SYNTAXERROR )
	end select

end function

'':::::
function cFunctionMode as integer

	'' (CDECL|STDCALL|PASCAL)?
	select case as const lexGetToken( )
	case FB_TK_CDECL
		function = FB_FUNCMODE_CDECL
		lexSkipToken( )
	case FB_TK_STDCALL
		function = FB_FUNCMODE_STDCALL
		lexSkipToken( )
	case FB_TK_PASCAL
		function = FB_FUNCMODE_PASCAL
		lexSkipToken( )
	case else
		function = FB_DEFAULT_FUNCMODE
	end select

end function

'':::::
''SubOrFuncDecl      =  ID FunctionMode? OVERLOAD?
''						(ALIAS STR_LIT)? (LIB STR_LIT)? ('(' Arguments? ')')?
''					 |	ID FunctionMode? OVERLOAD?
''						(ALIAS STR_LIT)? (LIB STR_LIT)? ('(' Arguments? ')')? (AS SymbolType)? .
''
function cSubOrFuncDecl( byval isSub as integer ) as integer static
    static as zstring * FB_MAXNAMELEN+1 id, libname, aliasname
    dim as zstring ptr plib, palias
    dim as integer typ, mode, lgt, ptrcnt, alloctype
    dim as FBSYMBOL ptr subtype, proc

	function = FALSE

	'' ID
	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

	typ = lexGetType( )
	lexEatToken( id )
	subtype = NULL
	ptrcnt = 0

	if( (isSub) and (typ <> INVALID) ) then
    	hReportError( FB_ERRMSG_INVALIDCHARACTER )
    	exit function
	end if

	''
	mode = cFunctionMode( )

	'' OVERLOAD?
	alloctype = 0
	if( lexGetToken( ) = FB_TK_OVERLOAD ) then
		lexSkipToken( )
		alloctype = FB_ALLOCTYPE_OVERLOADED
	end if

	'' (LIB STR_LIT)?
	if( lexGetToken( ) = FB_TK_LIB ) then
		lexSkipToken( )
		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
		lexEatToken( libname )
		plib = @libname
	else
		plib = NULL
	end if

	'' (ALIAS STR_LIT)?
	if( lexGetToken( ) = FB_TK_ALIAS ) then
		lexSkipToken( )
		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
		lexEatToken( aliasname )
		palias = @aliasname
	else
		palias = NULL
	end if

	proc = symbPreAddProc( id )

	'' ('(' Arguments? ')')?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )

		cArguments( proc, mode, TRUE )

		if( lexGetToken( ) <> CHAR_RPRNT ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if

		lexSkipToken( )
	end if

    '' (AS SymbolType)?
    if( lexGetToken( ) = FB_TK_AS ) then
    	lexSkipToken( )

    	if( (typ <> INVALID) or (isSub) ) then
    		hReportError( FB_ERRMSG_SYNTAXERROR )
    		exit function
    	end if

    	if( cSymbolType( typ, subtype, lgt, ptrcnt ) = FALSE ) then
    		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		exit function
    	end if

    	'' check for invalid types
    	select case as const typ
    	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		hReportError( FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS )
    		exit function
    	case FB_DATATYPE_VOID
    		hReportError( FB_ERRMSG_INVALIDDATATYPES )
    		exit function
    	end select
    end if

    if( issub ) then
    	typ = FB_DATATYPE_VOID
    	subtype = NULL
    end if

	''
	if( typ = INVALID ) then
		typ = hGetDefType( id )
	end if

    ''
    proc = symbAddPrototype( proc, @id, palias, plib, _
    						 typ, subtype, ptrcnt, _
    					     alloctype, mode, FALSE )
    if( proc = NULL ) then
    	hReportError( FB_ERRMSG_DUPDEFINITION )
    	exit function
    end if

    function = TRUE

end function

