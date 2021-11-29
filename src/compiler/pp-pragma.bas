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
	LEXPP_PRAGMAFLAG_NONE                 = 0
	LEXPP_PRAGMAFLAG_CAN_PUSHPOP          = 1
	LEXPP_PRAGMAFLAG_CAN_ASSIGN           = 2
	LEXPP_PRAGMAFLAG_HAS_CALLBACK         = 4
	LEXPP_PRAGMAFLAG_PRESERVE_UNDER_PP    = 8
	LEXPP_PRAGMAFLAG_PDCHECK              = 16

	LEXPP_PRAGMAFLAG_DEFAULT = LEXPP_PRAGMAFLAG_CAN_PUSHPOP or _
								LEXPP_PRAGMAFLAG_CAN_ASSIGN or _
								LEXPP_PRAGMAFLAG_PRESERVE_UNDER_PP
end enum

type LEXPP_PRAGMAOPT
	tk      as zstring * 16
	opt     as integer
	flags   as integer
end type

enum LEXPP_PRAGMAOPT_ENUM
	LEXPP_PRAGMAOPT_BITFIELD
	LEXPP_PRAGMAOPT_ONCE
	LEXPP_PRAGMAOPT_WARNCONSTNESS
	LEXPP_PRAGMAOPT_RESERVE

	LEXPP_PRAGMAS
end enum

type LEXPP_PRAGMASTK
	tos     as integer
	stk(0 to FB_MAXPRAGMARECLEVEL-1) as longint
end type

'' globals
	dim shared pragmaStk(0 to LEXPP_PRAGMAS-1) as LEXPP_PRAGMASTK

	'' same order as LEXPP_PRAGMAOPT_ENUM
	dim shared pragmaOpt(0 to LEXPP_PRAGMAS-1) as LEXPP_PRAGMAOPT => _
	{ _
		("msbitfields", FB_COMPOPT_MSBITFIELDS, LEXPP_PRAGMAFLAG_DEFAULT         ), _
		("once"       , 0                     , LEXPP_PRAGMAFLAG_HAS_CALLBACK    ), _
		("constness"  , FB_PDCHECK_CONSTNESS  , LEXPP_PRAGMAFLAG_PDCHECK or LEXPP_PRAGMAFLAG_DEFAULT ), _
		("reserve"    , 0                     , LEXPP_PRAGMAFLAG_HAS_CALLBACK    ) _
	}

sub ppPragmaInit( )
	'' reset stacks
	for i as integer = 0 to LEXPP_PRAGMAS-1
		pragmaStk(i).tos = 0
	next
end sub

sub ppPragmaEnd( )
end sub

private sub pragmaPush( byval pragmaIdx as LEXPP_PRAGMAOPT_ENUM, byval value as longint )
	with pragmaStk(pragmaIdx)
		if( .tos >= FB_MAXPRAGMARECLEVEL ) then
			errReport( FB_ERRMSG_RECLEVELTOODEEP )
			'' error recovery: skip
			exit sub
		end if

		.stk(.tos) = value
		.tos += 1
	end with
end sub

private sub pragmaPop( byval pragmaIdx as LEXPP_PRAGMAOPT_ENUM, byref value as longint )
	with pragmaStk(pragmaIdx)
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
'' Pragma           =   PRAGMA RESERVE ( '(' (ASM|EXTERN)?  ')' )? symbol
''
private sub pragmaReserve( )
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr base_parent = any, sym = any
	'' dim as FB_SYMBATTRIB attrib = FB_SYMBATTRIB_NONE
	dim as zstring ptr id = any
	dim as integer haveAsm = FALSE
	dim as integer haveExtern = FALSE

	'' preserve under -pp
	if( env.ppfile_num > 0 ) then
		lexPPOnlyEmitText( "#pragma reserve")
	end if

	'' '('?
	if( lexGetToken() = CHAR_LPRNT ) then

		'' '('
		lexSkipToken( )

		if( env.ppfile_num > 0 ) then
			lexPPOnlyEmitToken( )
		end if

		do
			select case lexGetToken( )
			case FB_TK_ASM, FB_TK_EXTERN
				if( parser.scope > FB_MAINSCOPE ) then
					if( fbIsModLevel( ) = FALSE ) then
						errReportEx( FB_ERRMSG_ILLEGALINSIDEASUB, lexGetText() )
					else
						errReportEx( FB_ERRMSG_ILLEGALINSIDEASCOPE, lexGetText() )
					end if
					'' error recovery: skip line
					hSkipUntil( FB_TK_EOL )
					exit sub
				end if

				'' multiple use of ASM/EXTERN is invalid
				if( ((lexGetToken() = FB_TK_ASM) and (haveAsm = TRUE)) _
					or ((lexGetToken() = FB_TK_EXTERN) and (haveExtern = TRUE)) ) then

					errReportEx( FB_ERRMSG_SYNTAXERROR, lexGetText( ) )
					'' error recovery: skip line
					hSkipUntil( FB_TK_EOL )
					exit sub
				end if

				select case lexGetToken( )
				case FB_TK_ASM
					haveAsm    = TRUE
				case FB_TK_EXTERN
					haveExtern = TRUE
				end select

				'' ASM|EXTERN
				lexSkipToken( LEXCHECK_POST_SUFFIX )

			case CHAR_COMMA
				'' ','
				lexSkipToken( )

			case else
				exit do

			end select

			if( env.ppfile_num > 0 ) then
				lexPPOnlyEmitToken( )
			end if

		loop

		'' ')'
		if( lexGetToken() <> CHAR_RPRNT ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		else
			if( env.ppfile_num > 0 ) then
				lexPPOnlyEmitToken( )
			end if

			lexSkipToken( )
		end if
	end if

	chain_ = cIdentifier( base_parent, FB_IDOPT_NONE )
	id = lexGetText( )

	if( hIsValidSymbolName( id ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit sub
	end if

	if( env.ppfile_num > 0 ) then
		lexPPOnlyEmitToken( )
	end if

	if( haveAsm = TRUE ) then
		if( parserInlineAsmAddKeyword( id ) = FALSE ) then
			errReportEx( FB_ERRMSG_DUPDEFINITION, id )
			'' error recovery: skip line
			hSkipUntil( FB_TK_EOL )
			exit sub
		end if
	end if

	if( haveExtern = TRUE ) then
		if( parserGlobalAsmAddKeyword( id ) = FALSE ) then
			errReportEx( FB_ERRMSG_DUPDEFINITION, id )
			'' error recovery: skip line
			hSkipUntil( FB_TK_EOL )
			exit sub
		end if
	end if

	if( (haveAsm = TRUE) or (haveExtern = TRUE) ) then
		'' symbol
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		exit sub
	end if

	sym = symbNewSymbol( FB_SYMBOPT_DOHASH, _
		NULL, _
		symbGetCurrentSymTb( ), symbGetCurrentHashTb( ), _
		FB_SYMBCLASS_RESERVED, _
		id, NULL, _
		FB_DATATYPE_INVALID, NULL, _
		FB_SYMBATTRIB_LOCAL, FB_PROCATTRIB_NONE )

	if( sym = NULL ) then
		errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		'' error recovery: skip line
		hSkipUntil( FB_TK_EOL )
		exit sub
	end if

	'' symbol
	lexSkipToken( LEXCHECK_POST_SUFFIX )

end sub


'':::::
'' Pragma           =   PRAGMA
''                            ONCE
''                          | PUSH '(' symbol (',' expression{int})? ')'
''                          | POP '(' symbol ')'
''                          | symbol ('=' expression{int})?
''                          | RESERVE ( '(' ASM? ','? SHARED? ')' )? symbol
''
sub ppPragma( )
	dim as string tk
	dim as integer p = -1, ispop = FALSE, ispush = FALSE
	dim as longint value = any

	tk = lcase( *lexGetText( ) )
	if( tk = "push" ) then
		ispush = TRUE
	elseif( tk = "pop" ) then
		ispop = TRUE
	end if

	if( ispop or ispush ) then
		'' PUSH | POP
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' '('
		if( lexGetToken() <> CHAR_LPRNT ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
		else
			lexSkipToken( )
		end if

		tk = lcase( *lexGetText( ) )
	end if

	for i as integer = 0 to LEXPP_PRAGMAS-1
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

	'' symbol
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	if( ispop ) then
		pragmaPop( p, value )

		'' Preserve msbitfields #pragmas under -pp
		if( (pragmaOpt(p).flags and LEXPP_PRAGMAFLAG_PRESERVE_UNDER_PP) <> 0 ) then
			if( env.ppfile_num > 0 ) then
				lexPPOnlyEmitText( "#pragma pop(" + str( pragmaOpt(p).tk ) + ")" )
			end if
		end if
	else
		'' assume value is FALSE/TRUE unless the #pragma explicitly uses other values
		value = FALSE

		if( ispush ) then
			if( (pragmaOpt(p).flags and LEXPP_PRAGMAFLAG_PDCHECK) <> 0 ) then
				pragmaPush( p, fbPdCheckIsSet( pragmaOpt(p).opt ) )
			else
				pragmaPush( p, fbGetOption( pragmaOpt(p).opt ) )
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
			if( (pragmaOpt(p).flags and LEXPP_PRAGMAFLAG_PDCHECK) <> 0 ) then
				value = (value <> 0)
			end if
		end if

		'' Preserve some #pragmas under -pp
		if( (pragmaOpt(p).flags and LEXPP_PRAGMAFLAG_PRESERVE_UNDER_PP) <> 0 ) then
			if( env.ppfile_num > 0 ) then
				if( ispush ) then
					lexPPOnlyEmitText( "#pragma push(" + str( pragmaOpt(p).tk ) + ", " + str( value ) + ")" )
				else
					lexPPOnlyEmitText( "#pragma " + str( pragmaOpt(p).tk ) + " = " + str( value ) )
				end if
			end if
		end if
	end if

	''
	if( (pragmaOpt(p).flags and LEXPP_PRAGMAFLAG_HAS_CALLBACK) <> 0 ) then
		select case p
		case LEXPP_PRAGMAOPT_ONCE
			fbPragmaOnce()
		case LEXPP_PRAGMAOPT_RESERVE
			pragmaReserve()
		end select
	else
		if( (pragmaOpt(p).flags and (LEXPP_PRAGMAFLAG_CAN_PUSHPOP or LEXPP_PRAGMAFLAG_CAN_ASSIGN)) <> 0 ) then
			if( (pragmaOpt(p).flags and LEXPP_PRAGMAFLAG_PDCHECK) <> 0 ) then
				value = (value and pragmaOpt(p).opt) or (fbGetOption( FB_COMPOPT_PEDANTICCHK ) and not pragmaOpt(p).opt)
				fbSetOption( FB_COMPOPT_PEDANTICCHK, value )
			else
				fbChangeOption( pragmaOpt(p).opt, value )
			end if
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
