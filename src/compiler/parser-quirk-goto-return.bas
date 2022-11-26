'' quirk branch statements (GOTO, GOSUB, RETURN, RESUME) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

'':::::
private function hFuncReturn _
	( _
	) as integer

	dim as integer checkexpr = any

	function = FALSE

	dim as FBSYMBOL ptr label = NULL
	if( parser.stmt.proc <> NULL ) then
		label = parser.stmt.proc->proc.endlabel
	end if

	if( label = NULL ) then
		errReport( FB_ERRMSG_ILLEGALOUTSIDEAPROC )
		hSkipStmt( )
		return TRUE
	end if

	'' skip RETURN
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' function?
	if( symbGetType( parser.currproc ) <> FB_DATATYPE_VOID ) then
		checkexpr = TRUE
	else
		'' Comment|StmtSep|EOF|ELSE|END IF|END IF? just exit
		select case as const lexGetToken( )
		case FB_TK_EOL, FB_TK_STMTSEP, FB_TK_EOF, FB_TK_COMMENT, FB_TK_REM, _
			 FB_TK_ELSE, FB_TK_END, FB_TK_ENDIF
			checkexpr = FALSE
		case else
			checkexpr = TRUE
		end select
	end if

	if( checkexpr ) then
		if( cAssignFunctResult( TRUE ) = FALSE ) then
			exit function
		end if
	end if

	'' do an implicit exit function
	astScopeBreak( label )
	function = TRUE

end function

'':::::
private function hGetLabelId _
	( _
		_
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any

	select case as const lexGetClass( )
	case FB_TKCLASS_NUMLITERAL
		sym = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
										lexGetText( ), _
										FB_SYMBCLASS_LABEL, _
										FALSE, _
										FALSE )

	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD, FB_TKCLASS_KEYWORD
		dim as FBSYMBOL ptr base_parent = any
		dim as FBSYMCHAIN ptr chain_ = cIdentifier( base_parent, _
													FB_IDOPT_ISDECL or FB_IDOPT_DEFAULT )

		sym = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )

	case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		hSkipStmt( )
		return NULL
	end select

	if( sym = NULL ) then
		sym = symbAddLabel( lexGetText( ), FB_SYMBOPT_CREATEALIAS )
		if( sym = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		end if
	end if

	lexSkipToken( LEXCHECK_POST_SUFFIX )

	function = sym

end function

private sub hGosubBranch()
	dim as FBSYMBOL ptr l = any

	'' GOSUB
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	l = hGetLabelId( )
	if( l <> NULL ) then
		astGosubAddJmp( parser.currproc, l )
	end if
end sub

'':::::
private function hGosubReturn _
	( _
	) as integer

	dim as FBSYMBOL ptr l = any

	'' it's a GOSUB's RETURN..
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' Comment|StmtSep|EOF|ELSE|END IF|ENDIF? just return
	select case as const lexGetToken( )
	case FB_TK_EOL, FB_TK_STMTSEP, FB_TK_EOF, FB_TK_COMMENT, _
		 FB_TK_REM, FB_TK_ELSE, FB_TK_END, FB_TK_ENDIF

		function = astGosubAddReturn( parser.currproc, NULL )

	'' label?
	case else
		l = hGetLabelId( )
		if( l <> NULL ) then
			function = astGosubAddReturn( parser.currproc, l )
		else
			function = TRUE
		end if
	end select

end function

'':::::
''GotoStmt        =   GOTO LABEL
''                |   GOSUB LABEL
''                |   RETURN LABEL?
''                |   RESUME NEXT? .
''
function cGotoStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

	dim as FBSYMBOL ptr l = any

	function = FALSE

	select case as const tk
	'' GOTO LABEL
	case FB_TK_GOTO
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		l = hGetLabelId( )
		if( l <> NULL ) then
			astScopeBreak( l )
		end if
		function = TRUE

	'' GOSUB LABEL
	case FB_TK_GOSUB

		if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_GOSUB )
			hSkipStmt( )
			return TRUE
		end if

		'' gosub allowed by OPTION GOSUB?
		if( env.opt.gosub ) then
			hGosubBranch()
		else
			'' GOSUB is allowed, but hasn't been enabled with OPTION GOSUB
			errReport( FB_ERRMSG_NOGOSUB )
			hSkipStmt( )
		end if

		return TRUE

	'' RETURN ((LABEL? Comment|StmtSep|EOF) | Expression)
	case FB_TK_RETURN
		'' gosub allowed by dialect?
		if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) ) then
			'' gosub allowed by OPTION GOSUB?
			if( env.opt.gosub ) then
				return hGosubReturn( )
			end if
		end if

		'' must be proc return?
		return hFuncReturn( )

	'' RESUME NEXT?
	case FB_TK_RESUME
		if( fbLangOptIsSet( FB_LANG_OPT_ONERROR ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_ONERROR )
			hSkipStmt( )
			return TRUE
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		rtlErrorResume( hMatch( FB_TK_NEXT, LEXCHECK_POST_SUFFIX ) )

		function = TRUE
	end select

end function
