'' label declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
''Label           =   NUM_LIT
''                |   ID ':' .
''
function cLabel as integer
	dim as FBSYMBOL ptr l = NULL
	dim as FBSYMCHAIN ptr chain_ = any

	function = FALSE

	'' NUM_LIT
	select case as const lexGetClass( )
	case FB_TKCLASS_NUMLITERAL

		'' between SELECT CASE and first CASE? ... that's not allowed
		if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
			hSkipStmt( )
			exit function
		end if

		if( fbLangOptIsSet( FB_LANG_OPT_NUMLABEL ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_NUMLABEL )
			'' error recovery: skip stmt
			hSkipStmt( )
		else
			l = symbAddLabel( lexGetText( ), _
							  FB_SYMBOPT_DECLARING or FB_SYMBOPT_CREATEALIAS )
			if( l = NULL ) then
				errReport( FB_ERRMSG_DUPDEFINITION )
				'' error recovery: skip stmt
				hSkipStmt( )
			else
				lexSkipToken( )
			end if

			'' fake a ':'
			parser.stmt.cnt += 1
		end if

	'' ID (labels can't be quirk-keywords)
	case FB_TKCLASS_IDENTIFIER
		'' ':'
		if( lexGetLookAhead( 1 ) = FB_TK_STMTSEP ) then

			'' between SELECT CASE and first CASE? ... that's not allowed
			if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
				hSkipStmt( )
				exit function
			end if

			'' ambiguity: it could be a proc call followed by a ':' stmt separator..
			'' no need to call Identifier(), ':' wouldn't follow 'ns.symbol' ids
			chain_ = lexGetSymChain( )
			if( symbFindByClass( chain_, FB_SYMBCLASS_PROC ) <> NULL ) then
				exit function
			end if

			l = symbAddLabel( lexGetText( ), _
							  FB_SYMBOPT_DECLARING or FB_SYMBOPT_CREATEALIAS )
			if( l = NULL ) then
				errReport( FB_ERRMSG_DUPDEFINITION )
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )

			'' skip ':'
			lexSkipToken( )
		end if
	end select

	if( l <> NULL ) then
		astAdd( astNewLABEL( l ) )

		symbSetLastLabel( l )

		function = TRUE
	end if

end function
