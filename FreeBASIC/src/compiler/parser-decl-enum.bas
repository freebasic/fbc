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
function cEnumConstDecl( byval id as zstring ptr, _
						 byref value as integer ) as integer
    static as ASTNODE ptr expr

	function = FALSE

	'' ID
	lexEatToken( id )

	'' '='?
	if( lexGetToken( ) = FB_TK_ASSIGN ) then
		lexSkipToken( )

		'' ConstExpression
		if( cExpression( expr ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDCONST )
			exit function
		end if

		if( astIsCONST( expr ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDCONST )
			exit function
		end if

		'' not an integer? (CHAR or WCHAR will fail in astIsCONST())
		if( astGetDataClass( expr ) <> FB_DATACLASS_INTEGER ) then
			hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION, id )
		end if

		value = astGetValueAsInt( expr )
		astDel( expr )

    end if

	function = TRUE

end function

'':::::
''EnumBody      =   (EnumDecl (',' EnumDecl)? Comment? SttSeparator)+ .
''
function cEnumBody( byval s as FBSYMBOL ptr ) as integer
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
					hReportErrorEx( FB_ERRMSG_DUPDEFINITION, ename )
					exit function
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
    			hReportError( FB_ERRMSG_EXPECTEDEOL )
    			exit function
			end if
		end select

	loop

	'' nothing added?
	if( symbGetEnumElements( s ) = 0 ) then
		hReportError( FB_ERRMSG_ELEMENTNOTDEFINED )
		exit function
	end if

    function = TRUE

end function

'':::::
''EnumDecl        =   ENUM ID? Comment? SttSeparator
''                        EnumLine+
''					  END ENUM .
function cEnumDecl as integer static
    static as zstring * FB_MAXNAMELEN+1 id
    dim as FBSYMBOL ptr e

	function = FALSE

	'' ENUM
	lexSkipToken( )

	'' ID?
	if( lexGetClass( ) = FB_TKCLASS_IDENTIFIER ) then
    	lexEatToken( id )
    else
    	id = *hMakeTmpStr( FALSE )
    end if

	e = symbAddEnum( @id )
	if( e = NULL ) then
    	hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
    	exit function
	end if

	'' Comment? SttSeparator
	cComment( )

	if( cStmtSeparator( ) = FALSE ) then
    	hReportError( FB_ERRMSG_SYNTAXERROR )
    	exit function
	end if

	'' EnumBody
	if( cEnumBody( e ) = FALSE ) then
		exit function
	end if

	'' END ENUM
	if( hMatch( FB_TK_END ) = FALSE ) then
    	hReportError( FB_ERRMSG_EXPECTEDENDENUM )
    	exit function
	end if
	if( hMatch( FB_TK_ENUM ) = FALSE ) then
    	hReportError( FB_ERRMSG_EXPECTEDENDENUM )
    	exit function
	end if

    ''
	function = TRUE

end function

