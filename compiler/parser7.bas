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


'' parser part 7 - QB GFX routines (SCREEN, PSET, LINE, etc)
''
'' chng: dec/2004 written [v1ctor]

option explicit

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\parser.bi'
'$include: 'inc\rtl.bi'
'$include: 'inc\ast.bi'
'$include: 'inc\ir.bi'

const LINE_TYPE_LINE = 0
const LINE_TYPE_B    = 1
const LINE_TYPE_BF   = 2

const COORD_TYPE_AA  = 0
const COORD_TYPE_AR  = 1
const COORD_TYPE_RA  = 2
const COORD_TYPE_RR  = 3
const COORD_TYPE_A   = 4
const COORD_TYPE_R   = 5

const DEFAULT_COLOR  = &HFFFF0000
const DEFAULT_STYLE	 = -1

'':::::
'' GfxPset     =   PSET STEP? '(' Expr ',' Expr ')' (',' Expr )?
''
function cGfxPset as integer
    dim coordtype as integer
    dim xexpr as integer, yexpr as integer, cexpr as integer

	cGfxPset = FALSE

	'' STEP?
	if( hMatch( FB.TK.STEP ) ) then
		coordtype = COORD_TYPE_R
	else
		coordtype = COORD_TYPE_A
	end if

	'' '(' Expr ',' Expr ')'
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

	if( not cExpression( xexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	if( not cExpression( yexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
		exit function
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( cexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
	else
		cexpr = astNewCONST( DEFAULT_COLOR, IR.DATATYPE.UINT )
	end if

	''
	rtlGfxPset xexpr, yexpr, cexpr, coordtype

	cGfxPset = TRUE

end function

'':::::
'' LINE STEP? ('(' Expr ',' Expr ')')? '-' STEP? '(' Expr ',' Expr ')' (',' Expr? (',' LIT_STRING? (',' Expr )?)?)?
''
function cGfxLine as integer
    dim coordtype as integer, linetype as integer, styleexpr as integer
    dim x1expr as integer, y1expr as integer, x2expr as integer, y2expr as integer
    dim cexpr as integer

	cGfxLine = FALSE

	'' STEP?
	if( hMatch( FB.TK.STEP ) ) then
		coordtype = COORD_TYPE_R
	else
		coordtype = COORD_TYPE_A
	end if

	'' ('(' Expr ',' Expr ')')?
	if( hMatch( CHAR_LPRNT ) ) then

		if( not cExpression( x1expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if

		if( not cExpression( y1expr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( not hMatch( CHAR_RPRNT ) ) then
			hReportError FB.ERRMSG.EXPECTEDRPRNT
			exit function
		end if

	else
		x1expr = astNewCONST( 0, IR.DATATYPE.SINGLE )
		y1expr = astNewCONST( 0, IR.DATATYPE.SINGLE )
	end if

	'' '-'
	if( not hMatch( CHAR_MINUS ) ) then
		hReportError FB.ERRMSG.SYNTAXERROR
		exit function
	end if

	'' STEP?
	if( hMatch( FB.TK.STEP ) ) then
		if( coordtype = COORD_TYPE_R ) then
			coordtype = COORD_TYPE_RR
		else
			coordtype = COORD_TYPE_AR
		end if
	else
		if( coordtype = COORD_TYPE_R ) then
			coordtype = COORD_TYPE_RA
		else
			coordtype = COORD_TYPE_AA
		end if
	end if

	'' '(' Expr ',' Expr ')'
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

	if( not cExpression( x2expr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	if( not cExpression( y2expr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
		exit function
	end if

	'' (',' Expr? (',' LIT_STRING? (',' Expr )?)?)?
	linetype = LINE_TYPE_LINE
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( cexpr ) ) then
			cexpr = astNewCONST( DEFAULT_COLOR, IR.DATATYPE.UINT )
		end if

		'' ',' LIT_STRING?
		if( hMatch( CHAR_COMMA ) ) then
			select case ucase$( lexTokenText )
			case "B"
				lexSkipToken
				linetype = LINE_TYPE_B
			case "BF"
				lexSkipToken
		    	linetype = LINE_TYPE_BF
		    end select

			''  (',' Expr )?
			if( hMatch( CHAR_COMMA ) ) then
				if( not cExpression( styleexpr ) ) then
					hReportError FB.ERRMSG.EXPECTEDEXPRESSION
					exit function
				end if
			else
				styleexpr = astNewCONST( DEFAULT_STYLE, IR.DATATYPE.UINT )
			end if

		else
			styleexpr = astNewCONST( DEFAULT_STYLE, IR.DATATYPE.UINT )
		end if
	else
		cexpr = astNewCONST( DEFAULT_COLOR, IR.DATATYPE.UINT )
		styleexpr = astNewCONST( DEFAULT_STYLE, IR.DATATYPE.UINT )
	end if

	''
	rtlGfxLine x1expr, y1expr, x2expr, y2expr, cexpr, linetype, styleexpr, coordtype

	cGfxLine = TRUE

end function

'':::::
function cGfxStmt as integer

	cGfxStmt = FALSE

	select case lexCurrentToken
	case FB.TK.PSET
		lexSkipToken
		cGfxStmt = cGfxPSet

	case FB.TK.LINE
		lexSkipToken
		cGfxStmt = cGfxLine

	end select

end function

