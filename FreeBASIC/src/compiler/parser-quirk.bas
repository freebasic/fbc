''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' quirk statements (ON, OPEN, PRINT, ...) parsing top-level
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

#define CHECK_CODEMASK( ) 												_
    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then		:_
    	exit function													:_
    end if

'':::::
''QuirkStmt   	  =   GotoStmt
''				  |   ArrayStmt
''				  |	  PrintStmt
''				  |   MidStmt
''				  |   DataStmt
''				  |   etc .
''
function cQuirkStmt _
	( _
		byval tk as FB_TOKEN = INVALID _
	) as integer

	dim as integer res = any

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
			if( tk = CHAR_QUESTION ) then	'' PRINT as '?', can't be a keyword..
				CHECK_CODEMASK( )
				function = cPrintStmt( tk )
			end if
			exit function
		end select
	end if

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

	case FB_TK_ERASE, FB_TK_SWAP
		CHECK_CODEMASK( )
		res = cArrayStmt( tk )

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
		res = cWriteStmt( )

	case FB_TK_ERROR, FB_TK_ERR
		CHECK_CODEMASK( )
		res = cErrorStmt( tk )

	case FB_TK_VIEW
		CHECK_CODEMASK( )
		res = cViewStmt( )

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

	case else
		res = FALSE
	end select

	if( res = FALSE ) then
		if( errGetLast( ) = FB_ERRMSG_OK ) then
			res = cGfxStmt( tk )
		end if
	end if

	function = res

end function

'':::::
''QuirkFunction =   QBFUNCTION ('(' ProcParamList ')')? .
''
function cQuirkFunction _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as integer res = FALSE
	dim as ASTNODE ptr funcexpr = NULL
	dim as FB_TOKEN tk = sym->key.id

	select case as const tk
	case FB_TK_MKD, FB_TK_MKS, FB_TK_MKI, FB_TK_MKL, _
	     FB_TK_MKSHORT, FB_TK_MKLONGINT

		res = cMKXFunct( tk, funcexpr )

	case FB_TK_CVD, FB_TK_CVS, FB_TK_CVI, FB_TK_CVL, _
	     FB_TK_CVSHORT, FB_TK_CVLONGINT

		res = cCVXFunct( tk, funcexpr )

	case FB_TK_STR, FB_TK_WSTR, FB_TK_MID, FB_TK_STRING, FB_TK_WSTRING, _
		 FB_TK_CHR, FB_TK_WCHR, _
		 FB_TK_ASC, FB_TK_INSTR, FB_TK_INSTRREV, _
		 FB_TK_TRIM, FB_TK_RTRIM, FB_TK_LTRIM

		res = cStringFunct( tk, funcexpr )

	case FB_TK_ABS, FB_TK_SGN, FB_TK_FIX, FB_TK_FRAC, FB_TK_LEN, FB_TK_SIZEOF, _
		 FB_TK_SIN, FB_TK_ASIN, FB_TK_COS, FB_TK_ACOS, FB_TK_TAN, FB_TK_ATN, _
		 FB_TK_SQR, FB_TK_LOG, FB_TK_EXP, FB_TK_ATAN2, FB_TK_INT

		res = cMathFunct( tk, funcexpr )

	case FB_TK_PEEK
		res = cPeekFunct( funcexpr )

	case FB_TK_LBOUND, FB_TK_UBOUND
		res = cArrayFunct( tk, funcexpr )

	case FB_TK_SEEK, FB_TK_INPUT, FB_TK_OPEN, FB_TK_CLOSE, _
		 FB_TK_GET, FB_TK_PUT, FB_TK_NAME

		res = cFileFunct( tk, funcexpr )

	case FB_TK_ERR
		res = cErrorFunct( funcexpr )

	case FB_TK_IIF
		res = cIIFFunct( funcexpr )

	case FB_TK_VA_FIRST
				res = cVAFunct( funcexpr )

	case FB_TK_CBYTE, FB_TK_CSHORT, FB_TK_CINT, FB_TK_CLNG, FB_TK_CLNGINT, _
		 FB_TK_CUBYTE, FB_TK_CUSHORT, FB_TK_CUINT, FB_TK_CULNG, FB_TK_CULNGINT, _
		 FB_TK_CSNG, FB_TK_CDBL, _
         FB_TK_CSIGN, FB_TK_CUNSG

		return cTypeConvExpr( tk )

	case FB_TK_TYPE
		return cAnonUDT( )

	case FB_TK_VIEW
		res = cViewStmt( TRUE, funcexpr )

    case FB_TK_WIDTH
        funcexpr = cWidthStmt( TRUE )
        res = funcexpr <> NULL

	case FB_TK_COLOR
		funcexpr = cColorStmt( TRUE )
		res = funcexpr <> NULL

	case FB_TK_SCREEN
		res = cScreenFunct( funcexpr )

	end select

	if( res = FALSE ) then
		if( errGetLast( ) = FB_ERRMSG_OK ) then
			funcexpr = cGfxFunct( tk )
		end if
	end if

	function = funcexpr

end function
