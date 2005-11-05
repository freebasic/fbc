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


'' constant (CONST) declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''ConstDecl       =   CONST ConstAssign (DECL_SEPARATOR ConstAssign)* .
''
function cConstDecl as integer

    function = FALSE

    '' CONST
    if( not hMatch( FB_TK_CONST ) ) then
    	exit function
    end if

	do
		'' ConstAssign
		if( not cConstAssign( ) ) then
			exit function
		end if

    	'' ','
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken( )
    	end if
	loop

	function = TRUE

end function

'':::
''ConstAssign     =   ID (AS SymbolType)? ASSIGN ConstExpression .
''
function cConstAssign as integer static
    static as zstring * FB_MAXNAMELEN+1 id
    dim as integer sdtype, edtype, lgt, ptrcnt
    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr litsym, subtype
    dim as FBVALUE value

	function = FALSE

	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

	'' ID
	sdtype = lexGetType( )
	lexEatToken( id )

	'' (AS SymbolType)?
	if( hMatch( FB_TK_AS ) ) then
		if( sdtype <> INVALID ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

		if( not cSymbolType( sdtype, subtype, lgt, ptrcnt ) ) then
			exit function
		end if

		'' check for invalid types
		if( subtype <> NULL ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			exit function
		end if

		select case as const sdtype
		case FB_SYMBTYPE_VOID, FB_SYMBTYPE_FIXSTR, _
			 FB_SYMBTYPE_CHAR, FB_SYMBTYPE_WCHAR
			hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			exit function
		end select

	end if

	'' '='
	if( not hMatch( FB_TK_ASSIGN ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEQ )
		exit function
	end if

	'' ConstExpression
	if( not cExpression( expr ) ) then
		hReportErrorEx( FB_ERRMSG_EXPECTEDCONST, id )
		exit function
	end if

	'' check if it's an string
	edtype = astGetDataType( expr )
	litsym = NULL
	select case edtype
	case IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR
		litsym = astGetStrLitSymbol( expr )
	end select

	'' string?
	if( litsym <> NULL ) then

		if( sdtype <> INVALID ) then
			'' not a string?
			if( sdtype <> FB_SYMBTYPE_STRING ) then
				hReportErrorEx( FB_ERRMSG_INVALIDDATATYPES, id )
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
		if( not astIsCONST( expr ) ) then
			hReportErrorEx( FB_ERRMSG_EXPECTEDCONST, id )
			exit function
		end if

		if( sdtype <> INVALID ) then
			'' string?
			if( sdtype = FB_SYMBTYPE_STRING ) then
				hReportErrorEx( FB_ERRMSG_INVALIDDATATYPES, id )
			end if
		end if

		if( symbAddConst( @id, _
						  edtype, _
						  astGetSubtype( expr ), _
						  @astGetValue( expr ) ) = NULL ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
    		exit function
		end if

    end if

	''
	astDel( expr )

	function = TRUE

end function

