''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''QuirkStmt   	  =   GotoStmt
''				  |   ArrayStmt
''				  |	  PrintStmt
''				  |   MidStmt
''				  |   DataStmt
''				  |   etc .
''
function cQuirkStmt as integer
	dim as integer res

	function = FALSE

	if( lexGetClass( ) <> FB_TKCLASS_KEYWORD ) then
		if( lexGetToken( ) = CHAR_QUESTION ) then	'' PRINT as '?', can't be a keyword..
			function = cPrintStmt( )
		end if
		exit function
	end if

	res = FALSE

	select case as const lexGetToken( )
	case FB_TK_GOTO, FB_TK_GOSUB, FB_TK_RETURN, FB_TK_RESUME
		res = cGotoStmt( )
	case FB_TK_PRINT, FB_TK_LPRINT
		res = cPrintStmt( )
	case FB_TK_RESTORE, FB_TK_READ, FB_TK_DATA
		res = cDataStmt( )
	case FB_TK_ERASE, FB_TK_SWAP
		res = cArrayStmt( )
	case FB_TK_LINE
		res = cLineInputStmt( )
	case FB_TK_INPUT
		res = cInputStmt( )
	case FB_TK_POKE
		res = cPokeStmt( )
	case FB_TK_OPEN, FB_TK_CLOSE, FB_TK_SEEK, FB_TK_PUT, FB_TK_GET, _
		 FB_TK_LOCK, FB_TK_UNLOCK, FB_TK_NAME
		res = cFileStmt( )
	case FB_TK_LOCATE
		res = cLocateStmt( FALSE ) <> NULL
	case FB_TK_ON
		res = cOnStmt( )
	case FB_TK_WRITE
		res = cWriteStmt( )
	case FB_TK_ERROR, FB_TK_ERR
		res = cErrorStmt( )
	case FB_TK_VIEW
		res = cViewStmt( )
	case FB_TK_MID
		res = cMidStmt( )
	case FB_TK_LSET
		res = cLSetStmt( )
    case FB_TK_WIDTH
        res = cWidthStmt( FALSE ) <> NULL

	end select

	if( res = FALSE ) then
		if( hGetLastError( ) = FB_ERRMSG_OK ) then
			res = cGfxStmt( )
		end if
	end if

	function = res

end function

'':::::
''QuirkFunction =   QBFUNCTION ('(' ProcParamList ')')? .
''
function cQuirkFunction( byref funcexpr as ASTNODE ptr ) as integer
	dim as integer res

	function = FALSE

	if( lexGetClass( ) <> FB_TKCLASS_KEYWORD ) then
		exit function
	end if

	res = FALSE

	select case as const lexGetToken( )
	case FB_TK_STR, FB_TK_WSTR, FB_TK_MID, FB_TK_STRING, FB_TK_WSTRING, _
		 FB_TK_CHR, FB_TK_WCHR, FB_TK_ASC, _
		 FB_TK_INSTR, FB_TK_TRIM, FB_TK_RTRIM, FB_TK_LTRIM
		res = cStringFunct( funcexpr )

	case FB_TK_ABS, FB_TK_SGN, FB_TK_FIX, FB_TK_LEN, FB_TK_SIZEOF, _
		 FB_TK_SIN, FB_TK_ASIN, FB_TK_COS, FB_TK_ACOS, FB_TK_TAN, FB_TK_ATN, _
		 FB_TK_SQR, FB_TK_LOG, FB_TK_ATAN2, FB_TK_INT
		res = cMathFunct( funcexpr )

	case FB_TK_PEEK
		res = cPeekFunct( funcexpr )

	case FB_TK_LBOUND, FB_TK_UBOUND
		res = cArrayFunct( funcexpr )

	case FB_TK_SEEK, FB_TK_INPUT, FB_TK_OPEN, FB_TK_CLOSE, _
		 FB_TK_GET, FB_TK_PUT, FB_TK_NAME
		res = cFileFunct( funcexpr )

	case FB_TK_LOCATE
		funcexpr = cLocateStmt( TRUE )
        res = funcexpr <> NULL

	case FB_TK_ERR
		res = cErrorFunct( funcexpr )

	case FB_TK_IIF
		res = cIIFFunct( funcexpr )

	case FB_TK_VA_FIRST
		res = cVAFunct( funcexpr )

	case FB_TK_CBYTE, FB_TK_CSHORT, FB_TK_CINT, FB_TK_CLNG, FB_TK_CLNGINT, _
		 FB_TK_CUBYTE, FB_TK_CUSHORT, FB_TK_CUINT, FB_TK_CULNGINT, _
		 FB_TK_CSNG, FB_TK_CDBL, _
         FB_TK_CSIGN, FB_TK_CUNSG
		res = cTypeConvExpr( funcexpr )

	case FB_TK_VIEW
		res = cViewStmt( TRUE, funcexpr )

    case FB_TK_WIDTH
        funcexpr = cWidthStmt( TRUE )
        res = funcexpr <> NULL

	case FB_TK_SCREEN
		res = cScreenFunct( funcexpr )
	end select

	if( res = FALSE ) then
		if( hGetLastError( ) = FB_ERRMSG_OK ) then
			res = cGfxFunct( funcexpr )
		end if
	end if

	function = res

end function
