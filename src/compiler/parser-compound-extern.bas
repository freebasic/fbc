'' EXTERN..END EXTERN compound statement parsing
''
'' chng: may/2006 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

'' ExternStmtBegin  =  EXTERN "mangling_spec" (LIB LITSTR)? .
sub cExternStmtBegin( )
	dim as FB_CMPSTMTSTK ptr stk = any
	dim as integer mangling = any
	dim as const zstring ptr litstr = any

	if( fbLangOptIsSet( FB_LANG_OPT_EXTERN ) = FALSE ) then
		errReportNotAllowed( FB_LANG_OPT_EXTERN )
		'' error recovery: skip the whole compound stmt
		hSkipCompound( FB_TK_EXTERN )
		exit sub
	end if

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_EXTERN ) = FALSE ) then
		'' error recovery: skip the whole compound stmt
		hSkipCompound( FB_TK_EXTERN )
		exit sub
	end if

	'' EXTERN
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' "mangling spec"
	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: assume it's "C"
		litstr = @"c"
	else
		litstr = lexGetText( )
	end if

	select case lcase( *litstr )
	case "c"
		mangling = FB_MANGLING_CDECL
		lexSkipToken( )

	case "windows"
		mangling = FB_MANGLING_STDCALL
		lexSkipToken( )

	case "windows-ms"
		mangling = FB_MANGLING_STDCALL_MS
		lexSkipToken( )

	case "c++"
		mangling = FB_MANGLING_CPP
		lexSkipToken( )

	case "rtlib"
		mangling = FB_MANGLING_RTLIB
		lexSkipToken( )

	case else
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: assume it's "C"
		mangling = FB_MANGLING_CDECL
		lexSkipToken( )

	end select

	'' [LIB "string"]
	cLibAttribute()

	stk = cCompStmtPush( FB_TK_EXTERN, _
	                     FB_CMPSTMT_MASK_ALL and (not FB_CMPSTMT_MASK_CODE) _
	                     and (not FB_CMPSTMT_MASK_DATA) )

	stk->ext.lastmang = parser.mangling
	parser.mangling = mangling
end sub

'' ExternStmtEnd  =  END EXTERN .
sub cExternStmtEnd( )
	dim as FB_CMPSTMTSTK ptr stk = any

	stk = cCompStmtGetTOS( FB_TK_EXTERN )
	if( stk = NULL ) then
		hSkipStmt( )
		exit sub
	end if

	'' END EXTERN
	lexSkipToken( LEXCHECK_POST_SUFFIX )
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' pop from stmt stack
	parser.mangling = stk->ext.lastmang
	cCompStmtPop( stk )
end sub
