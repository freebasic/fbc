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

declare sub parserCompoundStmtInit ( )

declare sub parserCompoundStmtEnd ( )

declare sub parserCompoundStmtSetCtx ( )

declare sub parserProcCallInit ( )

declare sub parserProcCallEnd ( )

declare sub parserLetInit( )

declare sub parserLetEnd( )

'' globals
	dim shared as PARSERCTX parser

'':::::
sub parserSetCtx( )

	parser.stage = 0 '' start in preprocessor stage
	parser.scope = FB_MAINSCOPE

	parser.currproc = NULL
	parser.currblock = NULL

	parser.nspcrec = 0
	parser.nsprefix = NULL

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
sub parserInit( )

	parserCompoundStmtInit( )

	parserProcCallInit( )

	parserLetInit( )

	parserAsmInit( )

end sub

'':::::
sub parserEnd( )

	parserAsmEnd( )

	parserLetEnd( )

	parserProcCallEnd( )

	parserCompoundStmtEnd( )

end sub

private sub hEmitCurrentLineText( )
	dim as ASTNODE ptr n = any

	'' Notes:
	''  - The text is only available after the lexer parsed through it,
	''    so this must be done after parsing it
	''  - And yet, the text (in form of a LIT node) should be inserted
	''    above the code generated for it, so we need to use astAddAfter()
	''  - No assumptions about the current procedure should be made, as it
	''    can change when parsing the line/statement

	'' Find the last DBG( AST_OP_DBG_LINEINI ) node
	'' in the current proc and insert behind it
	n = astGetProcTailNode( )
	while( n )
		if( n->class = AST_NODECLASS_DBG ) then
			if( n->dbg.op = AST_OP_DBG_LINEINI ) then
				astAddAfter( astNewLIT( lexCurrLineGet( ) ), n )
				exit while
			end if
		end if
		n = n->prev
	wend

	lexCurrLineReset( )
end sub

'' Program = (Label? Statement? Comment?)* EOF?
sub cProgram()
	dim as integer startlevel = pp.level

	#macro maybeExitParser()
		if( fbShouldContinue() = FALSE ) then
			exit sub
		end if
	#endmacro

	#macro maybeRestartParser()
		if( fbShouldRestart() ) then
			exit sub
		elseif( fbShouldContinue() = FALSE ) then
			exit sub
		end if
	#endmacro

	'' For each line...
	do
		'' parse the empty lines and comments and process directives, but
		'' don't write to the ASM output.  Clear the output buffer for
		'' the current line instead of calling hEmitCurrentLineText( )
		'' parser.stmt.cnt still needs to increment on FB_TK_EOL or else
		'' the scope indexes and error reporting gets messed.
		'' note: lexGetToken() = FB_TK_EOL must be called first because if
		'' cComment() is true and we reset the loop, we should be looking
		'' for the FB_TK_EOL immediately after.  If next token is FB_TK_EOF
		'' then we should fall through to emit a debug node for the last
		'' line in the file.

		if( lexGetToken( ) = FB_TK_EOL ) then
			'' must reset the output here because lexSkipToken() will load
			'' the next token in to the buffer, and we don't want to lose
			'' it if it is a statement
			lexCurrLineReset( )
			lexSkipToken( )
			'' need to check for exit here because directives may have been
			'' invoked or errors occur in ppCheck() calls in lexSkipToken()
			maybeExitParser()

			'' must increment statement count after EOL's
			parser.stmt.cnt += 1
			continue do
		end if

		'' assuming that cComment() won't generate any executable
		'' statements in the current file scope.  if #include is
		'' invoked, then should be handled by new include scope
		if( cComment() ) then
			maybeExitParser()
			continue do
		end if

		maybeRestartParser()

		'' if it wasn't an empty line, comment, or directive then
		'' we should expect a statement next requiring debug nodes
		'' i.e. even on first entry to CProgram(), if execution makes
		'' it to this point then next statement is expected to be something
		'' executable.  And if the parser or fbc needed to be restarted,
		'' it would have happened already in maybeExitParser() above

		'' set parser executable code stage
		parser.stage = 1

		'' line begin
		astAdd( astNewDBG( AST_OP_DBG_LINEINI, lexLineNum( ), env.inf.incfile ) )

		'' Label?
		cLabel( )

		'' Statement?
		cStatement( )

		'' Comment?
		cComment( )

		maybeExitParser()

		'' Emit the current line in text form, for debugging purposes
		if( env.clopt.debuginfo ) then
			if( env.includerec = 0 ) then
				hEmitCurrentLineText( )
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

		maybeExitParser()

		'' line end
		astAdd( astNewDBG( AST_OP_DBG_LINEEND ) )

		'' A new statement starts behind EOL
		'' (and EOF too, for implicitly generated code)
		parser.stmt.cnt += 1  '' end-of-statement seen
	loop while (lexGetToken() <> FB_TK_EOF)

	'' EOF
	assert(lexGetToken() = FB_TK_EOF)

	if (pp.level <> startlevel) then '' inside #IF block?
		errReport( FB_ERRMSG_EXPECTEDPPENDIF )
	end if

	lexSkipToken( )

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
