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

'' pre-processor #pragma parsing
''
'' chng: oct/2005 written [v1ctor]
''       jan/2006 updated [jeffm] added 'once'

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\lex.bi"
#include once "inc\parser.bi"
#include once "inc\pp.bi"

enum LEXPP_PRAGMAFLAG_ENUM
	LEXPP_PRAGMAFLAG_NONE = 0
	LEXPP_PRAGMAFLAG_CAN_PUSHPOP = 1
	LEXPP_PRAGMAFLAG_CAN_ASSIGN = 2
	LEXPP_PRAGMAFLAG_HAS_CALLBACK = 4

	LEXPP_PRAGMAFLAG_DEFAULT = LEXPP_PRAGMAFLAG_CAN_PUSHPOP or LEXPP_PRAGMAFLAG_CAN_ASSIGN
end enum

type LEXPP_PRAGMAOPT
	tk		as zstring * 16
	opt 	as integer
	flags	as integer
end type

enum LEXPP_PRAGMAOPT_ENUM
	LEXPP_PRAGMAOPT_BITFIELD
	LEXPP_PRAGMAOPT_ONCE

	LEXPP_PRAGMAS
end enum

type LEXPP_PRAGMASTK
	tos 	as integer
	stk(0 to FB_MAXPRAGMARECLEVEL-1) as integer
end type

'' globals
	dim shared pragmaStk(0 to FB_COMPOPTIONS-1) as LEXPP_PRAGMASTK

	'' same order as LEXPP_PRAGMAOPT_ENUM
	dim shared pragmaOpt(0 to LEXPP_PRAGMAS-1) as LEXPP_PRAGMAOPT => _
	{ _
		("msbitfields", FB_COMPOPT_MSBITFIELDS, LEXPP_PRAGMAFLAG_DEFAULT         ), _
		("once"       , 0                     , LEXPP_PRAGMAFLAG_HAS_CALLBACK    ) _
	}


''::::
sub ppPragmaInit( )
	dim as integer i

	'' reset stacks
	for i = 0 to FB_COMPOPTIONS-1
		pragmaStk(i).tos = 0
	next

end sub

''::::
sub ppPragmaEnd( )

end sub

'':::::
private function pragmaPush _
	( _
		byval opt as integer, _
		byval value as integer _
	) as integer

	function = FALSE

	with pragmaStk(opt)
		if( .tos >= FB_MAXPRAGMARECLEVEL ) then
			 if( errReport( FB_ERRMSG_RECLEVELTOODEEP ) = FALSE ) then
				exit function
			 else
				'' error recovery: skip
				return TRUE
			 end if
		end if

		.stk(.tos) = value
		.tos += 1
	end with

	function = TRUE

end function

'':::::
private function pragmaPop _
	( _
		byval opt as integer, _
		byref value as integer _
	) as integer

	function = FALSE

	with pragmaStk(opt)
		if( .tos <= 0 ) then
			 if( errReport( FB_ERRMSG_STACKUNDERFLOW ) = FALSE ) then
				exit function
			 else
				'' error recovery: skip
				value = FALSE
				return TRUE
			 end if
		end if

		.tos -= 1
		value = .stk(.tos)
	end with

	function = TRUE

end function

'':::::
'' Pragma			=	PRAGMA
''							  PUSH '(' symbol (',' expression{int})? ')'
''							| POP '(' symbol ')'
''							| symbol ('=' expression{int})?
''
function ppPragma( ) as integer
	dim as string tk
	dim as integer i = any, p = any, value = any, ispop = FALSE, ispush = FALSE

	function = FALSE

	tk = lcase( *lexGetText( ) )
	if( tk = "push" ) then
		ispush = TRUE
	elseif( tk = "pop" ) then
		ispop = TRUE
	end if

	if( ispop or ispush ) then
		lexSkipToken( )

		'' '('
		if( lexGetToken() <> CHAR_LPRNT ) then
			if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
				exit function
			end if
		else
			lexSkipToken( )
		end if

		tk = lcase( *lexGetText( ) )
	end if

	p = -1
	for i = 0 to LEXPP_PRAGMAS-1
		if( tk = pragmaOpt(i).tk ) then
			p = i
			exit for
		end if
	next

	if( p = -1 ) then
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		else
			'' error recovery: skip line
			if( ispop or ispush ) then
				hSkipUntil( CHAR_RPRNT, TRUE )
			else
				hSkipUntil( FB_TK_EOL )
			end if
			return TRUE
		end if
	end if

	if( ispush or ispop ) then
		if( (pragmaOpt(p).flags and LEXPP_PRAGMAFLAG_CAN_PUSHPOP) = 0 ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			else
				'' error recovery: skip line
				if( ispop or ispush ) then
					hSkipUntil( CHAR_RPRNT, TRUE )
				else
					hSkipUntil( FB_TK_EOL )
				end if
				return TRUE
			end if
		end if
	end if

	lexSkipToken( )

	if( ispop ) then
		if( pragmaPop( pragmaOpt(p).opt, value ) = FALSE ) then
			exit function
		end if

	else
		'' assume value is FALSE/TRUE unless the #pragma explicitly uses other values
		value = FALSE

		if( ispush ) then
			if( pragmaPush( pragmaOpt(p).opt, _
							fbGetOption( pragmaOpt(p).opt ) ) = FALSE ) then
				exit function
			end if

			'' ','?
			if( lexGetToken() = CHAR_COMMA ) then
				lexSkipToken( )
			else
				value = TRUE
			end if


		else
			'' '='?
			if( lexGetToken() = FB_TK_EQ ) then

				if( (pragmaOpt(p).flags and LEXPP_PRAGMAFLAG_CAN_ASSIGN) = 0 ) then
					if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
						exit function
					else
						'' error recovery: skip line
						hSkipUntil( FB_TK_EOL )
						return TRUE
					end if
				end if

				lexSkipToken( )
			else
				value = TRUE
			end if

		end if

		if( value = FALSE ) then
			'' expr
			if( cConstExprValue( value ) = FALSE ) then
				exit function
			end if
		end if
	end if

	''
	if( (pragmaOpt(p).flags and LEXPP_PRAGMAFLAG_HAS_CALLBACK) <> 0 ) then
		select case p
		case LEXPP_PRAGMAOPT_ONCE
			fbPragmaOnce()
		end select
	else
		if( (pragmaOpt(p).flags and (LEXPP_PRAGMAFLAG_CAN_PUSHPOP or LEXPP_PRAGMAFLAG_CAN_ASSIGN)) <> 0 ) then
			if( fbChangeOption( pragmaOpt(p).opt, value ) = FALSE ) then
				exit function
			end if
		end if
	end if

	''
	if( ispop or ispush ) then
		'' ')'
		if( lexGetToken() <> CHAR_RPRNT ) then
			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
			end if

		else
			lexSkipToken( )
		end if
	end if

	function = TRUE

end function


