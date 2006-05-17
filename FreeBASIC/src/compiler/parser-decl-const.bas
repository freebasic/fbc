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


'' constant (CONST) declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

''::::
private function hGetType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr _
	) as integer static

	dim as integer lgt, ptrcnt

	function = FALSE

	'' (AS SymbolType)?
	if( lexGetToken( ) = FB_TK_AS ) then
		lexSkipToken( )

		if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
			exit function
		end if

		'' check for invalid types
		if( subtype <> NULL ) then
			'' only allow if it's an enum
			if( dtype <> FB_DATATYPE_ENUM ) then
				hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
				exit function
			end if
		end if

		select case as const dtype
		case FB_DATATYPE_VOID, FB_DATATYPE_FIXSTR, _
			 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			exit function
		end select

	else
		dtype = INVALID
		subtype = NULL
	end if

	function = TRUE

end function

'':::
''ConstAssign     =   ID (AS SymbolType)? '=' ConstExpression .
''
function cConstAssign _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer static

    static as zstring * FB_MAXNAMELEN+1 id
    dim as integer edtype
    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr ns, litsym
    dim as FBVALUE value

	function = FALSE

	'' don't allow explicit namespaces
	ns = cNamespace( )
    if( ns <> NULL ) then
		if( ns <> symbGetCurrentNamespc( ) ) then
			hReportError( FB_ERRMSG_DECLOUTSIDENAMESPC )
			exit function
    	end if
    else
    	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
    		exit function
    	end if
    end if

	'' ID
	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

    '' if inside a namespace, symbols can't contain periods (.)'s
    if( symbIsGlobalNamespc( ) = FALSE ) then
    	if( lexGetPeriodPos( ) > 0 ) then
    		hReportError( FB_ERRMSG_CANTINCLUDEPERIODS )
    		exit function
    	end if
    end if

	id = *lexGetText( )
	edtype = lexGetType( )
	lexSkipToken( )

	'' not multiple?
	if( dtype = INVALID ) then
		'' (AS SymbolType)?
		if( hGetType( dtype, subtype ) = FALSE ) then
			exit function
		end if
	end if

	'' both suffix and type given?
	if( edtype <> INVALID ) then
		if( dtype <> INVALID ) then
			hReportErrorEx( FB_ERRMSG_SYNTAXERROR, id )
			exit function
		end if

		dtype = edtype
		subtype = NULL
	end if

	'' '='
	if( hMatch( FB_TK_ASSIGN ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEQ )
		exit function
	end if

	'' ConstExpression
	if( cExpression( expr ) = FALSE ) then
		hReportErrorEx( FB_ERRMSG_EXPECTEDCONST, id )
		exit function
	end if

	'' check if it's an string
	edtype = astGetDataType( expr )
	litsym = NULL
	select case edtype
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		litsym = astGetStrLitSymbol( expr )
	end select

	'' string?
	if( litsym <> NULL ) then

		if( dtype <> INVALID ) then
			'' not a string?
			if( dtype <> FB_DATATYPE_STRING ) then
				hReportErrorEx( FB_ERRMSG_INVALIDDATATYPES, id )
				exit function
			end if
		end if

		value.str = litsym

		if( symbAddConst( @id, edtype, NULL, @value ) = NULL ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
    		exit function
		end if

	'' anything else..
	else

		'' not a constant?
		if( astIsCONST( expr ) = FALSE ) then
			hReportErrorEx( FB_ERRMSG_EXPECTEDCONST, id )
			exit function
		end if

		if( dtype <> INVALID ) then
			'' string?
			if( dtype = FB_DATATYPE_STRING ) then
				hReportErrorEx( FB_ERRMSG_INVALIDDATATYPES, id )
				exit function
			end if

			'' convert if needed
			if( (dtype <> edtype) or _
				(subtype <> astGetSubtype( expr )) ) then

				expr = astNewCONV( INVALID, dtype, subtype, expr, FALSE )
				if( expr = NULL ) then
					hReportErrorEx( FB_ERRMSG_INVALIDDATATYPES, id )
					exit function
				end if
			end if

		else
			dtype = edtype
			subtype = astGetSubtype( expr )
		end if

		''
		if( symbAddConst( @id, _
						  dtype, _
						  subtype, _
						  @astGetValue( expr ) ) = NULL ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
    		exit function
		end if

    end if

	''
	astDelNode( expr )

	function = TRUE

end function

'':::::
''ConstDecl       =   CONST (AS SymbolType)? ConstAssign (DECL_SEPARATOR ConstAssign)* .
''
function cConstDecl as integer
    dim as integer dtype
    dim as FBSYMBOL ptr subtype

    function = FALSE

    '' CONST
    lexSkipToken( )

	'' (AS SymbolType)?
	if( hGetType( dtype, subtype ) = FALSE ) then
		exit function
	end if

	do
		'' ConstAssign
		if( cConstAssign( dtype, subtype ) = FALSE ) then
			exit function
		end if

    	'' ','?
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	end if
    	lexSkipToken( )
	loop

	function = TRUE

end function


