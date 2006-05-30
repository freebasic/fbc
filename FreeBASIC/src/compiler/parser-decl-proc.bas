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

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
    	exit function
    end if

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
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		else
			'' error recovery: try to parse the prototype
			function = cSubOrFuncDecl( TRUE )
		end if
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
		select case as const env.mangling
		case FB_MANGLING_BASIC
			function = FB_DEFAULT_FUNCMODE

		case FB_MANGLING_CDECL, FB_MANGLING_CPP
			function = FB_FUNCMODE_CDECL

		case FB_MANGLING_STDCALL
			function = FB_FUNCMODE_STDCALL
		end select
	end select

end function

'':::::
''SubOrFuncDecl      =  ID FunctionMode? OVERLOAD?
''						(ALIAS STR_LIT)? (LIB STR_LIT)? ('(' Arguments? ')')?
''					 |	ID FunctionMode? OVERLOAD?
''						(ALIAS STR_LIT)? (LIB STR_LIT)? ('(' Arguments? ')')? (AS SymbolType)? .
''
function cSubOrFuncDecl _
	( _
		byval isSub as integer _
	) as integer static

    static as zstring * FB_MAXNAMELEN+1 id, libname, aliasname
    dim as zstring ptr plib, palias
    dim as integer dtype, mode, lgt, ptrcnt, attrib
    dim as FBSYMBOL ptr subtype, proc

	function = FALSE

	'' don't allow explicit namespaces
	cIdentifier( TRUE )
	if( errGetLast( ) <> FB_ERRMSG_OK ) then
		exit function
	end if

	'' ID
	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
			exit function
		else
			'' error recovery: skip stmt
			hSkipStmt( )
			return TRUE
		end if
	end if

    '' if inside a namespace, symbols can't contain periods (.)'s
    if( symbIsGlobalNamespc( ) = FALSE ) then
    	if( lexGetPeriodPos( ) > 0 ) then
    		if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
    			exit function
    		end if
    	end if
    end if

	id = *lexGetText( )
	dtype = lexGetType( )
	subtype = NULL
	ptrcnt = 0

	if( (isSub) and (dtype <> INVALID) ) then
    	if( errReport( FB_ERRMSG_INVALIDCHARACTER ) = FALSE ) then
    		exit function
    	end if
	end if

	lexSkipToken( )

	''
	mode = cFunctionMode( )

	'' OVERLOAD?
	attrib = 0
	if( lexGetToken( ) = FB_TK_OVERLOAD ) then
		lexSkipToken( )
		attrib = FB_SYMBATTRIB_OVERLOADED
	end if

	'' (LIB STR_LIT)?
	plib = NULL
	if( lexGetToken( ) = FB_TK_LIB ) then
		lexSkipToken( )
		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if

		else
			lexEatToken( libname )
			plib = @libname
		end if
	end if

	'' (ALIAS STR_LIT)?
	palias = NULL
	if( lexGetToken( ) = FB_TK_ALIAS ) then
		lexSkipToken( )
		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if

		else
			lexEatToken( aliasname )
			palias = @aliasname
		end if
	end if

	proc = symbPreAddProc( id )

	'' ('(' Parameters? ')')?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )

		cParameters( proc, mode, TRUE )

		if( lexGetToken( ) <> CHAR_RPRNT ) then
			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
			end if
		else
			lexSkipToken( )
		end if
	end if

    '' (AS SymbolType)?
    if( lexGetToken( ) = FB_TK_AS ) then
    	lexSkipToken( )

    	if( (dtype <> INVALID) or (isSub) ) then
    		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    			exit function
    		end if
    	end if

    	if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
    		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: discard return type
    			dtype = INVALID
    			subtype = NULL
    			ptrcnt = 0
    		end if
    	end if

    	'' check for invalid types
    	select case as const dtype
    	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		if( errReport( FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake a type
    			dtype = FB_DATATYPE_STRING
    			subtype = NULL
    			ptrcnt = 0
    		end if

    	case FB_DATATYPE_VOID
    		if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake a type
    			dtype += FB_DATATYPE_POINTER
    			subtype = NULL
    			ptrcnt = 1
    		end if
    	end select
    end if

    if( issub ) then
    	dtype = FB_DATATYPE_VOID
    	subtype = NULL
    end if

	''
	if( dtype = INVALID ) then
		dtype = hGetDefType( id )
	end if

    ''
    proc = symbAddPrototype( proc, @id, palias, plib, _
    						 dtype, subtype, ptrcnt, _
    					     attrib, mode, FALSE )
    if( proc = NULL ) then
    	if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    		exit function
    	end if
    end if

    function = TRUE

end function

