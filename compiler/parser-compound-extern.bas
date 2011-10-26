'' EXTERN..END EXTERN compound statement parsing
''
'' chng: may/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

'':::::
''ExternStmtBegin  =   EXTERN "mangling_spec" (LIB LITSTR)? .
''
function cExternStmtBegin _
	( _
	) as integer

    dim as FB_CMPSTMTSTK ptr stk = any
    dim as integer mangling = any
    dim as zstring ptr litstr = any

	function = FALSE

    if( fbLangOptIsSet( FB_LANG_OPT_EXTERN ) = FALSE ) then
    	errReportNotAllowed( FB_LANG_OPT_EXTERN )
    	'' error recovery: skip the whole compound stmt
    	hSkipCompound( FB_TK_EXTERN )
    	exit function
    end if

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_EXTERN ) = FALSE ) then
    	'' error recovery: skip the whole compound stmt
    	hSkipCompound( FB_TK_EXTERN )
    	exit function
    end if

	'' EXTERN
	lexSkipToken( )

	'' "mangling spec"
	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		else
			'' error recovery: assume it's "C"
			litstr = @"c"
            
		end if
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

	case else
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		else
			'' error recovery: assume it's "C"
			mangling = FB_MANGLING_CDECL
            lexSkipToken( )
		end if
	end select

	if( lexGetToken( ) = FB_TK_LIB ) then
		lexSkipToken( )

		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if

		else
			fbAddLib(*lexGetText(), FALSE)
			lexSkipToken( )
		end if
	end if

	''
	stk = cCompStmtPush( FB_TK_EXTERN, _
						 FB_CMPSTMT_MASK_ALL and (not FB_CMPSTMT_MASK_CODE) _
						 					 and (not FB_CMPSTMT_MASK_DATA) )

	stk->ext.lastmang = parser.mangling
	parser.mangling = mangling

	function = TRUE

end function

'':::::
''ExternStmtEnd  =     END EXTERN .
''
function cExternStmtEnd as integer
	dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_EXTERN )
	if( stk = NULL ) then
		exit function
	end if

	'' END EXTERN
	lexSkipToken( )
	lexSkipToken( )

	'' pop from stmt stack
	parser.mangling = stk->ext.lastmang
	cCompStmtPop( stk )

	function = TRUE

end function


