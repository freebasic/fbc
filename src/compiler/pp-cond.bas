'' pre-processor conditional (#if, #else, #elseif, #endif) parsing
''
'' chng: dec/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "lex.bi"
#include once "parser.bi"
#include once "pp.bi"

const FB_PP_MAXRECLEVEL = 64

type LEXPP_REC
	istrue      as integer
	elsecnt     as integer
end type

declare sub ppSkip( )

'' globals
	dim shared pptb(1 to FB_PP_MAXRECLEVEL) as LEXPP_REC

sub ppCondInit( )
	pp.level = 0
end sub

sub ppCondEnd( )
end sub

private function ppExpression( ) as integer
	dim as ASTNODE ptr expr = any

	fbSetIsPP( TRUE )
	expr = cExpression( )
	fbSetIsPP( FALSE )

	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		expr = astNewCONSTi( 0 )
	end if

	'' String literals evaluate to FALSE
	if( astGetStrLitSymbol( expr ) <> NULL ) then
		expr = astNewCONSTi( 0 )

	'' Besides that, it must be a numeric constant (that includes the
	'' result of defined() or BOPs)
	elseif( astIsCONST( expr ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDCONST )
		astDelTree( expr )
		expr = astNewCONSTi( 0 )
	end if

	function = not astConstEqZero( expr )
end function

sub ppCondIf( )
	dim as integer istrue = any

	istrue = FALSE

	select case as const lexGetToken( LEXCHECK_KWDNAMESPC )
	'' IFDEF ID
	case FB_TK_PP_IFDEF
		lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_POST_SUFFIX )
		istrue = (cIdentifierOrUDTMember( ) <> NULL)

	'' IFNDEF ID
	case FB_TK_PP_IFNDEF
		lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_POST_SUFFIX )
		istrue = (cIdentifierOrUDTMember( ) = NULL)

	'' IF Expression
	case FB_TK_PP_IF
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		istrue = ppExpression( )

	end select

	pp.level += 1
	if( pp.level > FB_PP_MAXRECLEVEL ) then
		errReport( FB_ERRMSG_RECLEVELTOODEEP )
		errHideFurtherErrors( )
		exit sub
	end if

	pptb(pp.level).istrue = istrue
	pptb(pp.level).elsecnt = 0

	if( istrue = FALSE ) then
		ppSkip( )
	end if
end sub

sub ppCondElse( )
	dim as integer istrue = any

	istrue = FALSE

	if( pp.level = 0 ) then
		errReport( FB_ERRMSG_ILLEGALOUTSIDECOMP )
		'' error recovery: skip statement
		hSkipStmt( )
		exit sub
	end if

	if( pptb(pp.level).elsecnt > 0 ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip statement
		hSkipStmt( )
		exit sub
	end if

	'' ELSEIF?
	if( lexGetToken( LEXCHECK_KWDNAMESPC ) = FB_TK_PP_ELSEIF ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		istrue = ppExpression( )

		if( pptb(pp.level).istrue ) then
			ppSkip( )
			exit sub
		end if

		pptb(pp.level).istrue = istrue
	'' ELSE
	else
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		pptb(pp.level).elsecnt += 1
		pptb(pp.level).istrue = not pptb(pp.level).istrue
	end if

	if( pptb(pp.level).istrue = FALSE ) then
		ppSkip( )
	end if
end sub

sub ppCondEndIf( )
	'' ENDIF
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	if( pp.level > 0 ) then
		pp.level -= 1
	else
		errReport( FB_ERRMSG_ILLEGALOUTSIDECOMP )
	end if
end sub

'':::::
sub ppAssert( )
	dim as integer istrue = any

	'' ASSERT Expression

	istrue = ppExpression( )

	if( istrue = FALSE ) then
		errReport( FB_ERRMSG_PPASSERT_FAILED )
	end if

end sub

'':::::
private sub ppSkip( )
	dim as integer iflevel = any

	pp.skipping = TRUE

	'' Comment?
	cComment( )

	'' emit the current line in text form
	hEmitCurrLine( )

	'' EOL
	if( lexGetToken( ) <> FB_TK_EOL ) then
		errReport( FB_ERRMSG_EXPECTEDEOL )
		'' error recovery: skip until next line
		hSkipUntil( FB_TK_EOL, TRUE )
	else
		lexSkipToken( )
	end if

	iflevel = pp.level

	'' skip lines until a #ENDIF or #ELSE at same level is found
	'' we only care about lines that would affect the level of
	'' PP processing, like multiline comments and #if* pp tokens.
	'' we don't care about invalid directives or line continuation
	'' characters.
	do
		select case lexGetToken( )
		case CHAR_SHARP
			lexSkipToken( LEXCHECK_KWDNAMESPC )

			select case as const lexGetToken( LEXCHECK_KWDNAMESPC )
			case FB_TK_PP_IF, FB_TK_PP_IFDEF, FB_TK_PP_IFNDEF
				iflevel += 1

			case FB_TK_PP_ELSE, FB_TK_PP_ELSEIF
				select case( iflevel )
				case pp.level
					pp.skipping = FALSE
					ppCondElse( )
					exit sub
				case 0
					errReport( FB_ERRMSG_ILLEGALOUTSIDECOMP )
				end select

			case FB_TK_PP_ENDIF
				select case( iflevel )
				case pp.level
					pp.skipping = FALSE
					ppCondEndIf( )
					exit sub
				case 0
					errReport( FB_ERRMSG_ILLEGALOUTSIDECOMP )
				case else
					iflevel -= 1
				end select

			end select

		case FB_TK_EOF
			errReport( FB_ERRMSG_EXPECTEDPPENDIF )
			exit do

		end select

		lexSkipLine( )

		if( lexGetToken( ) = FB_TK_EOL ) then
			lexSkipToken( )
		end if
	loop

	pp.skipping = FALSE
end sub
