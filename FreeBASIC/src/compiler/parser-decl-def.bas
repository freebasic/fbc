''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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


'' DEF### declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
''DefDecl         =   (DEFINT|DEFLNG|DEFSNG|DEFDBL|DEFSTR) (CHAR '-' CHAR ','?)* .
''
function cDefDecl as integer static
    static as zstring * 32+1 char
    dim as integer dtype, ichar, echar

	function = FALSE

    if( fbLangOptIsSet( FB_LANG_OPT_DEFTYPE ) = FALSE ) then
	    if( errReportNotAllowed( FB_LANG_OPT_DEFTYPE ) = FALSE ) then
			exit function
		else
			'' error recovery: skip stmt
			hSkipStmt( )
			return TRUE
	    end if
	end if

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
		if( fbLangIsSet( FB_LANG_QB ) = FALSE ) then '' QBASIC allows DEF___ in procs/compound statements
			exit function
		end if
	end if

	dtype = FB_DATATYPE_INVALID

	select case as const lexGetToken( )
	case FB_TK_DEFBYTE
		dtype = FB_DATATYPE_BYTE

	case FB_TK_DEFUBYTE
		dtype = FB_DATATYPE_UBYTE

	case FB_TK_DEFSHORT
		dtype = FB_DATATYPE_SHORT

	case FB_TK_DEFUSHORT
		dtype = FB_DATATYPE_USHORT

	case FB_TK_DEFINT
		dtype = fbLangGetType( INTEGER )

	case FB_TK_DEFUINT
		dtype = FB_DATATYPE_UINT

	case FB_TK_DEFLNG
		dtype = fbLangGetType( LONG )

	case FB_TK_DEFULNG
		dtype = FB_DATATYPE_ULONG

	case FB_TK_DEFLNGINT
		dtype = FB_DATATYPE_LONGINT

	case FB_TK_DEFULNGINT
		dtype = FB_DATATYPE_ULONGINT

	case FB_TK_DEFSNG
		dtype = FB_DATATYPE_SINGLE

	case FB_TK_DEFDBL
		dtype = FB_DATATYPE_DOUBLE

	case FB_TK_DEFSTR
		dtype = FB_DATATYPE_STRING
	end select

	if( dtype <> FB_DATATYPE_INVALID ) then
		lexSkipToken( )

		'' (CHAR '-' CHAR ','?)*
		do
			'' CHAR
			char = ucase( *lexGetText( ) )
			if( len( char ) <> 1 ) then
				if( errReport( FB_ERRMSG_EXPECTEDCOMMA ) = FALSE ) then
					exit function
				end if
			end if
			ichar = asc( char )
			lexSkipToken( )

			'' '-'
			if( lexGetToken( ) = CHAR_MINUS ) then
				lexSkipToken( )

				'' CHAR
				char = ucase( *lexGetText( ) )
				if( len( char ) <> 1 ) then
					if( errReport( FB_ERRMSG_EXPECTEDCOMMA ) = FALSE ) then
						exit function
					end if
				end if
				echar = asc( char )
				lexSkipToken( )

			else
				echar = ichar
			end if

			symbSetDefType( ichar, echar, dtype )

      		'' ','
      		if( lexGetToken( ) <> CHAR_COMMA ) then
      			exit do
      		end if

			lexSkipToken( )
		loop

		function = TRUE
	end if

end function

