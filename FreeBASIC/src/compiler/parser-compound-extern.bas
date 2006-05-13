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


'' EXTERN..END EXTERN compound statement parsing
''
'' chng: may/2006 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
''ExternStmtBegin  =   EXTERN "mangling_spec" (LIB LITSTR)? .
''
function cExternStmtBegin _
	( _
	) as integer

    dim as FB_CMPSTMTSTK ptr stk
    dim as integer mangling
    dim as FBLIBRARY ptr library

	function = FALSE

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_EXTERN ) = FALSE ) then
    	exit function
    end if

	'' EXTERN
	lexSkipToken( )

	'' "mangling spec"
	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
	end if

	select case lcase( *lexGetText( ) )
	case "c"
		mangling = FB_MANGLING_CDECL
	case "windows"
		mangling = FB_MANGLING_STDCALL
	case "c++"
		mangling = FB_MANGLING_CPP
	case else
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
	end select

	lexSkipToken( )

	if( lexGetToken( ) = FB_TK_LIB ) then
		lexSkipToken( )

		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

		library = symbAddLib( lexGetText( ) )

		lexSkipToken( )
	else
		library = NULL
	end if

	''
	stk = cCompStmtPush( FB_TK_EXTERN, _
						 FB_CMPSTMT_MASK_ALL and (not FB_CMPSTMT_MASK_CODE) _
						 					 and (not FB_CMPSTMT_MASK_DATA) )

	stk->ext.lastmang = env.mangling
	env.mangling = mangling

	stk->ext.lastlib = library
	env.currlib = library

	function = TRUE

end function

'':::::
''ExternStmtEnd  =     END EXTERN .
''
function cExternStmtEnd as integer
	dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_EXTERN )
	if( stk = NULL ) then
		exit function
	end if

	'' END EXTERN
	lexSkipToken( )
	lexSkipToken( )

	'' pop from stmt stack
	env.currlib = stk->ext.lastlib
	env.mangling = stk->ext.lastmang
	cCompStmtPop( stk )

	function = TRUE

end function


