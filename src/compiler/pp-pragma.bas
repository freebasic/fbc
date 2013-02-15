'' pre-processor #pragma parsing
''
'' chng: oct/2005 written [v1ctor]
''       jan/2006 updated [jeffm] added 'once'

#include once "fb.bi"
#include once "fbint.bi"
#include once "lex.bi"
#include once "parser.bi"
#include once "pp.bi"

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

sub ppPragmaInit( )
	'' reset stacks
	for i as integer = 0 to FB_COMPOPTIONS-1
		pragmaStk(i).tos = 0
	next
end sub

sub ppPragmaEnd( )
end sub

private sub pragmaPush( byval opt as integer, byval value as integer )
	with pragmaStk(opt)
		if( .tos >= FB_MAXPRAGMARECLEVEL ) then
			errReport( FB_ERRMSG_RECLEVELTOODEEP )
			'' error recovery: skip
			exit sub
		end if

		.stk(.tos) = value
		.tos += 1
	end with
end sub

private sub pragmaPop( byval opt as integer, byref value as integer )
	with pragmaStk(opt)
		if( .tos <= 0 ) then
			errReport( FB_ERRMSG_STACKUNDERFLOW )
			'' error recovery: skip
			value = FALSE
			exit sub
		end if

		.tos -= 1
		value = .stk(.tos)
	end with
end sub

'':::::
'' Pragma			=	PRAGMA
''							  PUSH '(' symbol (',' expression{int})? ')'
''							| POP '(' symbol ')'
''							| symbol ('=' expression{int})?
''
sub ppPragma( )
	dim as string tk
	dim as integer i = any, p = any, value = any, ispop = FALSE, ispush = FALSE

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
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
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
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip line
		if( ispop or ispush ) then
			hSkipUntil( CHAR_RPRNT, TRUE )
		else
			hSkipUntil( FB_TK_EOL )
		end if
		return
	end if

	if( ispush or ispop ) then
		if( (pragmaOpt(p).flags and LEXPP_PRAGMAFLAG_CAN_PUSHPOP) = 0 ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
			'' error recovery: skip line
			if( ispop or ispush ) then
				hSkipUntil( CHAR_RPRNT, TRUE )
			else
				hSkipUntil( FB_TK_EOL )
			end if
			return
		end if
	end if

	lexSkipToken( )

	if( ispop ) then
		pragmaPop( pragmaOpt(p).opt, value )
	else
		'' assume value is FALSE/TRUE unless the #pragma explicitly uses other values
		value = FALSE

		if( ispush ) then
			pragmaPush( pragmaOpt(p).opt, fbGetOption( pragmaOpt(p).opt ) )

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
					errReport( FB_ERRMSG_SYNTAXERROR )
					'' error recovery: skip line
					hSkipUntil( FB_TK_EOL )
					return
				end if

				lexSkipToken( )
			else
				value = TRUE
			end if
		end if

		if( value = FALSE ) then
			'' expr
			value = cConstIntExpr( cExpression( ) )
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
			fbChangeOption( pragmaOpt(p).opt, value )
		end if
	end if

	''
	if( ispop or ispush ) then
		'' ')'
		if( lexGetToken() <> CHAR_RPRNT ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		else
			lexSkipToken( )
		end if
	end if
end sub
