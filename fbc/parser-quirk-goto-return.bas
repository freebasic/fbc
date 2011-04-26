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
		if( errReport( FB_ERRMSG_ILLEGALOUTSIDEAPROC ) = FALSE ) then
			exit function
		else
			hSkipStmt( )
			return TRUE
		end if
	end if

	'' skip RETURN
	lexSkipToken( )

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
		if( cAssignFunctResult( parser.currproc, TRUE ) = FALSE ) then
			exit function
		end if
	end if

	'' do an implicit exit function
	function = astScopeBreak( label )

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
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

		sym = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )

	case else
		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) ) then
			hSkipStmt( )
		end if

		return NULL
	end select

	if( sym = NULL ) then
		sym = symbAddLabel( lexGetText( ), FB_SYMBOPT_CREATEALIAS )
	end if

	lexSkipToken( )

	function = sym

end function

'':::::
private function hGosubBranch _
	( _
	) as integer

	dim as FBSYMBOL ptr l = any

	lexSkipToken( )

	l = hGetLabelId( )
	if( l <> NULL ) then
		function = astGosubAddJmp( parser.currproc, l )
		
	else
		function = (errGetLast( ) = FB_ERRMSG_OK)
	end if

end function

'':::::
private function hGosubReturn _
	( _
	) as integer

	dim as FBSYMBOL ptr l = any

	'' it's a GOSUB's RETURN..
	lexSkipToken( )

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
			function = (errGetLast( ) = FB_ERRMSG_OK)
		end if
	end select

end function

'':::::
''GotoStmt		  =   GOTO LABEL
''				  |   GOSUB LABEL
''				  |   RETURN LABEL?
''				  |   RESUME NEXT? .
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
		lexSkipToken( )

		l = hGetLabelId( )
		if( l <> NULL ) then
			function = astScopeBreak( l )
		else
			function = (errGetLast( ) = FB_ERRMSG_OK)
		end if

	'' GOSUB LABEL
	case FB_TK_GOSUB

		if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) = FALSE ) then
			if( errReportNotAllowed( FB_LANG_OPT_GOSUB ) = FALSE ) then
				exit function
			else
				hSkipStmt( )
				return TRUE
			end if
		end if

		'' gosub allowed by OPTION GOSUB?
		if( env.opt.gosub ) then
			return hGosubBranch( )

		else
			'' GOSUB is allowed, but hasn't been enabled with OPTION GOSUB
			if( errReport( FB_ERRMSG_NOGOSUB ) = FALSE ) then
				exit function
			else
				hSkipStmt( )
				return TRUE
			end if

		end if

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
			if( errReportNotAllowed( FB_LANG_OPT_ONERROR ) = FALSE ) then
				exit function
			else
				hSkipStmt( )
				return TRUE
			end if
		end if

		lexSkipToken( )

		rtlErrorResume( hMatch( FB_TK_NEXT ) )

		function = TRUE
	end select

end function

