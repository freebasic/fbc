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


'' declarations top-level parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
private function hCheckScope _
	( _
	) as integer

	if( parser.scope = FB_MAINSCOPE ) then
		return TRUE
	end if

	if( fbIsModLevel( ) = FALSE ) then
		errReport( FB_ERRMSG_ILLEGALINSIDEASUB )
	else
		errReport( FB_ERRMSG_ILLEGALINSIDEASCOPE )
	end if

	function = FALSE

end function

'':::::
''Declaration     =   ConstDecl | TypeDecl | VariableDecl | ProcDecl | DefDecl | OptDecl.
''
function cDeclaration _
	( _
	) as integer

	dim as FB_SYMBATTRIB attrib = FB_SYMBATTRIB_NONE

    '' QB mode?
    if( env.clopt.lang = FB_LANG_QB ) then
    	if( lexGetType() <> FB_DATATYPE_INVALID ) then
    		return FALSE
    	end if
    end if

	select case as const lexGetToken( )
	case FB_TK_PUBLIC
		 if( hCheckScope( ) ) then
		 	attrib = FB_SYMBATTRIB_PUBLIC
		 end if

		 lexSkipToken( )

	case FB_TK_PRIVATE
		if( hCheckScope( ) ) then
			attrib = FB_SYMBATTRIB_PRIVATE
		end if

		lexSkipToken( )

	case FB_TK_DECLARE
		return cProcDecl( )

	case FB_TK_DEFBYTE, FB_TK_DEFUBYTE, FB_TK_DEFSHORT, FB_TK_DEFUSHORT, _
		 FB_TK_DEFINT, FB_TK_DEFUINT, FB_TK_DEFLNG, FB_TK_DEFULNG, _
		 FB_TK_DEFSNG, FB_TK_DEFDBL, FB_TK_DEFSTR, _
		 FB_TK_DEFLNGINT, FB_TK_DEFULNGINT
		return cDefDecl( )

	case FB_TK_OPTION
		return cOptDecl( )

	end select

	select case as const lexGetToken( )
	case FB_TK_STATIC
		select case as const lexGetLookAhead( 1 )
		case FB_TK_FUNCTION, FB_TK_SUB, FB_TK_OPERATOR, _
			 FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR, FB_TK_PROPERTY
			function = cProcStmtBegin( attrib )

		case else
			function = cVariableDecl( attrib )
		end select

	case FB_TK_FUNCTION, FB_TK_SUB, FB_TK_DESTRUCTOR, FB_TK_PROPERTY
		if( attrib <> FB_SYMBATTRIB_NONE ) then
			function = cProcStmtBegin( attrib )
		else
			'' not a FUNCTION|PROPERTY '=' ?
			if( lexGetLookAhead( 1 ) <> FB_TK_ASSIGN ) then
				function = cProcStmtBegin( )
			end if
		end if

	case FB_TK_CONSTRUCTOR
		if( attrib <> FB_SYMBATTRIB_NONE ) then
			function = cProcStmtBegin( attrib )
		else
			'' ambiguity: it could be a constructor chain
			if( fbIsModLevel( ) ) then
				function = cProcStmtBegin( )
			end if
		end if

	case FB_TK_OPERATOR
		if( attrib <> FB_SYMBATTRIB_NONE ) then
			function = cProcStmtBegin( attrib )
		else
			'' ambiguity: it could be the operator '=' body
			if( fbIsModLevel( ) ) then
				function = cProcStmtBegin( )
			else
				'' not OPERATOR '=' ?
				if( lexGetLookAhead( 1 ) <> FB_TK_ASSIGN ) then
					function = cProcStmtBegin( )
				end if
			end if
		end if

	case FB_TK_CONST
		function = cConstDecl( attrib )

	case FB_TK_TYPE, FB_TK_UNION
		function = cTypeDecl( attrib )

	case FB_TK_ENUM
		function = cEnumDecl( attrib )

	case FB_TK_DIM, FB_TK_REDIM, FB_TK_COMMON, FB_TK_EXTERN
		function = cVariableDecl( attrib )

	case FB_TK_VAR
		function = cAutoVarDecl( attrib )

	case else
		if( attrib <> FB_SYMBATTRIB_NONE ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
		end if

		function = FALSE
	end select

end function

'':::::
function hDeclCheckParent _
	( _
		byval s as FBSYMBOL ptr _
	) as integer static

	function = FALSE

	select case symbGetClass( s )
	case FB_SYMBCLASS_NAMESPACE
		if( s <> symbGetCurrentNamespc( ) ) then
			if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC ) = FALSE ) then
				exit function
			end if
		end if

	case FB_SYMBCLASS_CLASS
    	if( s <> symbGetCurrentNamespc( ) ) then
			if( errReport( FB_ERRMSG_DECLOUTSIDECLASS ) = FALSE ) then
				exit function
			end if
    	end if

	end select

	function = TRUE

end function



