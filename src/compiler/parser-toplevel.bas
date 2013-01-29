'' top-level parser
''
'' a deterministic, top-down, linear directional (LL(2)), recursive descent parser
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "pp.bi"

declare sub	parserCompoundStmtInit ( )

declare sub	parserCompoundStmtEnd ( )

declare sub	parserCompoundStmtSetCtx ( )

declare sub	parserProcCallInit ( )

declare sub	parserProcCallEnd ( )

declare sub	parserLetInit( )

declare sub parserLetEnd( )

'' globals
	dim shared as PARSERCTX parser

'':::::
sub parserSetCtx( )

	parser.scope = FB_MAINSCOPE

	parser.currproc	= NULL
	parser.currblock = NULL

	parser.nspcrec = 0

	parser.mangling = FB_MANGLING_BASIC

	parser.stmt.cnt = 0
	parser.stmt.id = 0

	parser.prntcnt = 0
	parser.options = FB_PARSEROPT_CHKARRAY
	parser.ctxsym    = NULL
	parser.ctx_dtype = FB_DATATYPE_INVALID

	parserCompoundStmtSetCtx( )

end sub

'':::::
sub	parserInit( )

	parserCompoundStmtInit( )

	parserProcCallInit( )

	parserLetInit( )

end sub

'':::::
sub	parserEnd( )

	parserLetEnd( )

	parserProcCallEnd( )

	parserCompoundStmtEnd( )

end sub

'' Program = (Label? Statement? Comment?)* EOF?
sub cProgram()
	dim as integer startlevel = pp.level

	'' For each line...
	do
		parser.stmt.cnt += 1

		'' line begin
		astAdd( astNewDBG( AST_OP_DBG_LINEINI, lexLineNum( ) ) )

		dim as ASTNODE ptr proc = astGetProc( ), expr = astGetProcTailNode( )

		'' Label?
		cLabel( )

		'' Statement?
		cStatement( )

		'' Comment?
		cComment( )

		if (fbShouldContinue() = FALSE) then
			exit sub
		end if

		'' emit the current line in text form
		if( env.clopt.debug ) then
			if( env.includerec = 0 ) then
				'' don't add if proc changed (from main() to proc block or the inverse)
				if( proc = astGetProc( ) ) then
					astAddAfter( astNewLIT( lexCurrLineGet( ) ), expr )
				end if
				lexCurrLineReset( )
			end if
		end if

		select case (lexGetToken())
		case FB_TK_EOL
			lexSkipToken( )

		case FB_TK_EOF

		case else
			errReport( FB_ERRMSG_EXPECTEDEOL )
			'' error recovery: skip until EOL
			hSkipUntil( FB_TK_EOL, TRUE )
		end select

		if (fbShouldContinue() = FALSE) then
			exit sub
		end if

		'' line end
		astAdd( astNewDBG( AST_OP_DBG_LINEEND ) )
	loop while (lexGetToken() <> FB_TK_EOF)

	'' EOF
	assert(lexGetToken() = FB_TK_EOF)

	parser.stmt.cnt += 1

	if (pp.level <> startlevel) then '' inside #IF block?
		errReport( FB_ERRMSG_EXPECTEDPPENDIF )
	end if

	lexSkipToken()

	'' only check compound stmts if not parsing an include file
	if (env.includerec = 0) then
		cCompStmtCheck()
	end if
end sub

''::::
sub hSkipUntil _
	( _
		byval token as integer, _
		byval doeat as integer, _
		byval flags as LEXCHECK, _
		byval stop_on_comma as integer _
	)

	dim as integer prntcnt

	prntcnt = 0
	do
		select case as const lexGetToken( flags )
		case FB_TK_EOL
			exit do

		case FB_TK_STMTSEP, FB_TK_COMMENT, FB_TK_REM
			'' anything but EOL? exit..
			if( token <> FB_TK_EOL ) then
				exit do
			end if

		case FB_TK_EOF
			exit sub

		'' '('?
		case CHAR_LPRNT
			if( token = CHAR_LPRNT ) then
				exit do
			end if

			prntcnt += 1

		case CHAR_LBRACE
			prntcnt += 1

		'' ')'?
		case CHAR_RPRNT
			'' inside parentheses?
			if( prntcnt > 0 ) then
				prntcnt -= 1
			else
				if( token = CHAR_RPRNT ) then
					exit do
				end if
			end if

		case CHAR_RBRACE
			'' inside braces?
			if( prntcnt > 0 ) then
				prntcnt -= 1
			else
				if( token = CHAR_RBRACE ) then
					exit do
				end if
			end if

		'' ','?
		case CHAR_COMMA
			'' skip until ','?
			if( (token = CHAR_COMMA) or stop_on_comma ) then
				'' not inside parentheses?
				if( prntcnt = 0 ) then
					exit do
				end if
			end if

		case else
			'' token found? exit..
			if( lexGetToken( flags ) = token ) then
				exit do
			end if

		end select

		lexSkipToken( flags )
	loop

	'' skip token?
	if( doeat ) then
		'' same?
		if( token = lexGetToken( flags ) ) then
			lexSkipToken( flags )
		end if
	end if

end sub

'':::::
sub hSkipCompound _
	( _
		byval for_token as integer, _
		byval until_token as integer, _
		byval flags as LEXCHECK _
	)

	dim as integer cnt, iscomment

	if( until_token = INVALID ) then
		until_token = for_token
	end if

	cnt = 0
	iscomment = FALSE
	do
		select case lexGetToken( flags )
		case FB_TK_EOF
			exit sub

		case FB_TK_EOL
			iscomment = FALSE

		case FB_TK_COMMENT, FB_TK_REM
			iscomment = TRUE

		case FB_TK_END
			if( iscomment = FALSE ) then
				if( lexGetLookAhead( 1, flags ) = until_token ) then
					lexSkipToken( flags )

					if( cnt > 0 ) then
						cnt -= 1
                    end if

					if( cnt = 0 ) then
						exit do
					end if
				end if
			end if

		case for_token
			if( iscomment = FALSE ) then
				cnt += 1
			end if

		end select

		lexSkipToken( flags )
	loop

	lexSkipToken( flags )

end sub

'':::::
function hMatchExpr _
	( _
		byval dtype as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr

	expr = cExpression( )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: fake an expr
		if( dtype = FB_DATATYPE_INVALID ) then
			return NULL
		end if

		expr = astNewCONSTz( dtype )
	end if

	function = expr

end function
