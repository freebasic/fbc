'' quirk statements (ON, OPEN, PRINT, ...) parsing top-level
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

#macro CHECK_CODEMASK( )
	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
		exit function
	end if
#endmacro

'':::::
''QuirkStmt       =   GotoStmt
''                |   ArrayStmt
''                |   PrintStmt
''                |   MidStmt
''                |   DataStmt
''                |   etc .
''
function cQuirkStmt _
	( _
		byval tk as FB_TOKEN = INVALID _
	) as integer

	function = FALSE

	if( tk = INVALID ) then
		tk = lexGetToken( )

		select case lexGetClass( )
		case FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
			'' QB mode?
			if( env.clopt.lang = FB_LANG_QB ) then
				if( lexGetType() <> FB_DATATYPE_INVALID ) then
					return FALSE
				end if
			end if

		case else
			'' PRINT as '?', can't be a keyword..
			if( tk = CHAR_QUESTION ) then
				CHECK_CODEMASK( )
				function = cPrintStmt( tk )
			end if
			exit function
		end select
	end if

	dim as integer res = FALSE

	select case as const tk
	case FB_TK_GOTO, FB_TK_GOSUB, FB_TK_RETURN, FB_TK_RESUME
		CHECK_CODEMASK( )
		res = cGotoStmt( tk )

	case FB_TK_PRINT, FB_TK_LPRINT
		CHECK_CODEMASK( )
		res = cPrintStmt( tk )

	case FB_TK_RESTORE, FB_TK_READ, FB_TK_DATA
		CHECK_CODEMASK( )
		res = cDataStmt( tk )

	case FB_TK_ERASE
		CHECK_CODEMASK( )
		res = cEraseStmt()

	case FB_TK_SWAP
		CHECK_CODEMASK( )
		res = cSwapStmt()

	case FB_TK_LINE
		CHECK_CODEMASK( )
		res = cLineInputStmt( )

	case FB_TK_INPUT
		CHECK_CODEMASK( )
		res = cInputStmt( )

	case FB_TK_POKE
		CHECK_CODEMASK( )
		res = cPokeStmt( )

	case FB_TK_OPEN, FB_TK_CLOSE, FB_TK_SEEK, FB_TK_PUT, FB_TK_GET, _
		 FB_TK_LOCK, FB_TK_UNLOCK, FB_TK_NAME
		CHECK_CODEMASK( )
		res = cFileStmt( tk )

	case FB_TK_ON
		CHECK_CODEMASK( )
		res = cOnStmt( )

	case FB_TK_WRITE
		CHECK_CODEMASK( )
		res = cWriteStmt()

	case FB_TK_ERROR
		CHECK_CODEMASK( )
		res = cErrorStmt()

	case FB_TK_ERR
		CHECK_CODEMASK( )
		res = cErrSetStmt()

	case FB_TK_VIEW
		CHECK_CODEMASK( )
		res = (cViewStmt(FALSE) <> NULL)

	case FB_TK_MID
		CHECK_CODEMASK( )
		res = cMidStmt( )

	case FB_TK_LSET, FB_TK_RSET
		CHECK_CODEMASK( )
		res = cLRSetStmt( tk )

	case FB_TK_WIDTH
		CHECK_CODEMASK( )
		res = cWidthStmt( FALSE ) <> NULL

	case FB_TK_COLOR
		CHECK_CODEMASK( )
		res = cColorStmt( FALSE ) <> NULL

	case FB_TK_REM
		'' due the QB quirks..
		if( env.clopt.lang = FB_LANG_QB ) then
			res = cComment( )
		end if

	case FB_TK_CVA_START, FB_TK_CVA_END, FB_TK_CVA_COPY
		CHECK_CODEMASK( )
		res = cVALISTStmt( tk )

	end select

	if( res = FALSE ) then
		res = cGfxStmt( tk )
	end if

	function = res

end function

'':::::
''QuirkFunction =   QBFUNCTION ('(' ProcParamList ')')? .
''
function cQuirkFunction(byval sym as FBSYMBOL ptr) as ASTNODE ptr
	dim as ASTNODE ptr funcexpr = NULL
	dim as FB_TOKEN tk = sym->key.id

	''
	'' Allow quirk function names to be used as literals in PP expressions,
	'' if not followed by '(', or '<' (for type<...>(...)).
	''
	'' There are some cases of quirk functions below that can be called
	'' without ()'s (ERR, THREADCALL, SCREEN) but none of them make sense
	'' in PP expressions anyways, as they can't be evaluated at
	'' compile-time, so there's no harm done disallowing them to be used.
	''
	if( fbGetIsPP( ) ) then
		if( (lexGetLookAhead( 1 ) <> CHAR_LPRNT) and _
		    ((tk <> FB_TK_TYPE) or (lexGetLookAhead( 1 ) <> FB_TK_LT)) ) then
			funcexpr = astNewCONSTstr( ucase( *lexGetText( ) ) )
			lexSkipToken( )
			return funcexpr
		end if
	end if

	select case as const tk
	case FB_TK_MKD, FB_TK_MKS, FB_TK_MKI, FB_TK_MKL, _
	     FB_TK_MKSHORT, FB_TK_MKLONGINT
		funcexpr = cMKXFunct(tk)

	case FB_TK_CVD, FB_TK_CVS, FB_TK_CVI, FB_TK_CVL, _
	     FB_TK_CVSHORT, FB_TK_CVLONGINT
		funcexpr = cCVXFunct(tk)

	case FB_TK_STR, FB_TK_WSTR, FB_TK_MID, FB_TK_STRING, FB_TK_WSTRING, _
	     FB_TK_CHR, FB_TK_WCHR, _
	     FB_TK_ASC, FB_TK_INSTR, FB_TK_INSTRREV, _
	     FB_TK_TRIM, FB_TK_RTRIM, FB_TK_LTRIM, _
	     FB_TK_LCASE, FB_TK_UCASE
		funcexpr = cStringFunct(tk)

	case FB_TK_ABS, FB_TK_SGN, FB_TK_FIX, FB_TK_FRAC, FB_TK_LEN, FB_TK_SIZEOF, _
		 FB_TK_SIN, FB_TK_ASIN, FB_TK_COS, FB_TK_ACOS, FB_TK_TAN, FB_TK_ATN, _
		 FB_TK_SQR, FB_TK_LOG, FB_TK_EXP, FB_TK_ATAN2, FB_TK_INT
		funcexpr = cMathFunct(tk, FALSE)

	case FB_TK_PEEK
		funcexpr = cPeekFunct()

	case FB_TK_LBOUND, FB_TK_UBOUND
		funcexpr = cArrayFunct(tk)

	case FB_TK_SEEK, FB_TK_INPUT, FB_TK_WINPUT, FB_TK_OPEN, FB_TK_CLOSE, _
	     FB_TK_GET, FB_TK_PUT, FB_TK_NAME
		funcexpr = cFileFunct(tk)

	case FB_TK_ERR
		funcexpr = cErrorFunct()

	case FB_TK_IIF
		return cStrIdxOrMemberDeref( cIIFFunct( ) )

	case FB_TK_VA_FIRST
		funcexpr = cVAFunct()

	case FB_TK_CVA_ARG
		funcexpr = cVALISTFunct( tk )

	case FB_TK_CBYTE, FB_TK_CSHORT, FB_TK_CINT, FB_TK_CLNG, FB_TK_CLNGINT, _
	     FB_TK_CUBYTE, FB_TK_CUSHORT, FB_TK_CUINT, FB_TK_CULNG, FB_TK_CULNGINT, _
	     FB_TK_CSNG, FB_TK_CDBL, FB_TK_CSIGN, FB_TK_CUNSG, FB_TK_CBOOL
		return cTypeConvExpr( tk )

	case FB_TK_TYPE
		return cStrIdxOrMemberDeref( cAnonType( ) )

	case FB_TK_VIEW
		funcexpr = cViewStmt(TRUE)

	case FB_TK_WIDTH
		funcexpr = cWidthStmt( TRUE )

	case FB_TK_COLOR
		funcexpr = cColorStmt( TRUE )

	case FB_TK_SCREEN, FB_TK_SCREENQB
		funcexpr = cScreenFunct()

	case FB_TK_THREADCALL
		funcexpr = cThreadCallFunc()

	end select

	if( funcexpr = NULL ) then
		funcexpr = cGfxFunct( tk )
	end if

	function = funcexpr
end function
