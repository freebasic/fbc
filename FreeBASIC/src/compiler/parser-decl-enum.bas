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


'' enumerator (ENUM) declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::
''EnumConstDecl     =   ID ('=' ConstExpression)? .
''
function cEnumConstDecl _
	( _
		byval id as zstring ptr, _
		byref value as integer _
	) as integer

    static as ASTNODE ptr expr

	function = FALSE

    '' contains a period?
    if( lexGetPeriodPos( ) > 0 ) then
    	if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
    		exit function
    	end if
    end if

	'' ID
	*id = *lexGetText( )
	lexSkipToken( )

	'' '='?
	if( lexGetToken( ) = FB_TK_ASSIGN ) then
		lexSkipToken( )

		'' ConstExpression
		if( cExpression( expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
				exit function
			else
				'' error recovery: skip till next ','
				hSkipUntil( CHAR_COMMA )
				return TRUE
			end if
		end if

		if( astIsCONST( expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
				exit function
			else
				'' error recovery: no value change
				astDelTree( expr )
				return TRUE
			end if
		end if

		'' not an integer? (CHAR or WCHAR will fail in astIsCONST())
		if( astGetDataClass( expr ) <> FB_DATACLASS_INTEGER ) then
			errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION, id )
		end if

		value = astGetValueAsInt( expr )
		astDelNode( expr )

    end if

	function = TRUE

end function

'':::::
''EnumBody      =   (EnumDecl (',' EnumDecl)? Comment? SttSeparator)+ .
''
function cEnumBody _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

	static as zstring * FB_MAXNAMELEN+1 ename
	dim as integer value

	function = FALSE

	value = 0

	do
		'' Comment? SttSeparator?
		do while( cComment( ) or cStmtSeparator( ) )
		loop

		select case lexGetToken( )
		'' EOF?
		case FB_TK_EOF
			exit do

		'' END?
		case FB_TK_END
			exit do

		case else

			'' ID ConstDecl (',' ID ConstDecl)*
			do
				'' ID?
				if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
					exit do
				end if

				'' ConstDecl
				if( cEnumConstDecl( @ename, value ) = FALSE ) then
					exit function
				end if

				if( symbAddEnumElement( s, @ename, value ) = NULL ) then
					if( errReportEx( FB_ERRMSG_DUPDEFINITION, ename ) = FALSE ) then
						exit function
					end if
				end if

				value += 1

				'' ','?
				if( lexGetToken( ) <> CHAR_COMMA ) then
					exit do
				end if

				lexSkipToken( )
			loop

			'' Comment? SttSeparator
			cComment( )

			if( cStmtSeparator( ) = FALSE ) then
    			if( errReport( FB_ERRMSG_EXPECTEDEOL ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: skip until next line or stmt
    				hSkipUntil( INVALID, TRUE )
    			end if
			end if
		end select

	loop

	'' nothing added?
	if( symbGetEnumElements( s ) = 0 ) then
		if( errReport( FB_ERRMSG_ELEMENTNOTDEFINED ) = FALSE ) then
			exit function
		end if
	end if

    function = TRUE

end function

'':::::
''EnumDecl        =   ENUM ID? (ALIAS LITSTR)? Comment? SttSeparator
''                        EnumLine+
''					  END ENUM .
function cEnumDecl( ) as integer static
    static as zstring * FB_MAXNAMELEN+1 id, id_alias
    dim as zstring ptr palias
    dim as FBSYMBOL ptr ns, e

	function = FALSE

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
    	'' error recovery: skip the whole compound stmt
    	hSkipCompound( FB_TK_ENUM )
    	exit function
    end if

	'' ENUM
	lexSkipToken( )

	'' ID?
	if( lexGetClass( ) = FB_TKCLASS_IDENTIFIER ) then
		'' don't allow explicit namespaces
		ns = cNamespace( )
    	if( ns <> NULL ) then
			if( ns <> symbGetCurrentNamespc( ) ) then
				if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC ) = FALSE ) then
					exit function
				end if
    		end if
    	else
    		if( errGetLast( ) <> FB_ERRMSG_OK ) then
    			exit function
    		end if
    	end if

    	'' contains a period?
    	if( lexGetPeriodPos( ) > 0 ) then
    		if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
    			exit function
    		end if
    	end if

		lexEatToken( @id )

    else
    	id = *hMakeTmpStr( FALSE )
    end if

	'' (ALIAS LITSTR)?
	palias = NULL
	if( lexGetToken( ) = FB_TK_ALIAS ) then
    	lexSkipToken( )

		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if
        else
			lexEatToken( @id_alias )
			palias = @id_alias
		end if
	end if

	e = symbAddEnum( @id, palias )
	if( e = NULL ) then
    	if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: create a fake symbol
    		e = symbAddEnum( hMakeTmpStr( ), NULL )
    	end if
	end if

	'' Comment? SttSeparator
	cComment( )

	if( cStmtSeparator( ) = FALSE ) then
    	if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: skip until next line or stmt
    		hSkipUntil( INVALID, TRUE )
    	end if
	end if

	'' EnumBody
	if( cEnumBody( e ) = FALSE ) then
		exit function
	end if

	'' END ENUM
	if( lexGetToken( ) <> FB_TK_END ) then
    	if( errReport( FB_ERRMSG_EXPECTEDENDENUM ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: skip until next stmt
    		hSkipStmt( )
    	end if

	else
		lexSkipToken( )

		if( lexGetToken( ) <> FB_TK_ENUM ) then
    		if( errReport( FB_ERRMSG_EXPECTEDENDENUM ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: skip until next stmt
    			hSkipStmt( )
    		end if

		else
			lexSkipToken( )
		end if
	end if

    ''
	function = TRUE

end function

