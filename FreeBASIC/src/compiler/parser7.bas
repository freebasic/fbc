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
option escape

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\parser.bi'
'$include: 'inc\rtl.bi'
'$include: 'inc\ast.bi'
'$include: 'inc\ir.bi'

const FBGFX_LINETYPE_LINE = 0
const FBGFX_LINETYPE_B    = 1
const FBGFX_LINETYPE_BF   = 2

const FBGFX_COORDTYPE_AA  = 0
const FBGFX_COORDTYPE_AR  = 1
const FBGFX_COORDTYPE_RA  = 2
const FBGFX_COORDTYPE_RR  = 3
const FBGFX_COORDTYPE_A   = 4
const FBGFX_COORDTYPE_R   = 5

const FBGFX_DEFAULTCOLOR  = &HFFFF0000

const FBGFX_PUTMODE_TRANS  = 0
const FBGFX_PUTMODE_PSET   = 1
const FBGFX_PUTMODE_PRESET = 2
const FBGFX_PUTMODE_AND    = 3
const FBGFX_PUTMODE_OR     = 4
const FBGFX_PUTMODE_XOR    = 5



'':::::
'' GfxPset     =   PSET STEP? '(' Expr ',' Expr ')' (',' Expr )?
''
function cGfxPset as integer
    dim coordtype as integer
    dim xexpr as integer, yexpr as integer, cexpr as integer

	cGfxPset = FALSE

	'' STEP?
	if( hMatch( FB.TK.STEP ) ) then
		coordtype = FBGFX_COORDTYPE_R
	else
		coordtype = FBGFX_COORDTYPE_A
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
		cexpr = astNewCONST( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
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
		coordtype = FBGFX_COORDTYPE_R
	else
		coordtype = FBGFX_COORDTYPE_A
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
		coordtype = FBGFX_COORDTYPE_R
		x1expr = astNewCONST( 0, IR.DATATYPE.SINGLE )
		y1expr = astNewCONST( 0, IR.DATATYPE.SINGLE )
	end if

	'' '-'
	if( not hMatch( CHAR_MINUS ) ) then
		hReportError FB.ERRMSG.EXPECTEDMINUS
		exit function
	end if

	'' STEP?
	if( hMatch( FB.TK.STEP ) ) then
		if( coordtype = FBGFX_COORDTYPE_R ) then
			coordtype = FBGFX_COORDTYPE_RR
		else
			coordtype = FBGFX_COORDTYPE_AR
		end if
	else
		if( coordtype = FBGFX_COORDTYPE_R ) then
			coordtype = FBGFX_COORDTYPE_RA
		else
			coordtype = FBGFX_COORDTYPE_AA
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

	linetype = FBGFX_LINETYPE_LINE
	styleexpr = INVALID

	'' (',' Expr? (',' LIT_STRING? (',' Expr )?)?)?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( cexpr ) ) then
			cexpr = astNewCONST( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
		end if

		'' ',' LIT_STRING? - linetype
		if( hMatch( CHAR_COMMA ) ) then
			select case ucase$( lexTokenText )
			case "B"
				lexSkipToken
				linetype = FBGFX_LINETYPE_B
			case "BF"
				lexSkipToken
		    	linetype = FBGFX_LINETYPE_BF
		    end select

			''  (',' Expr )? - style
			if( hMatch( CHAR_COMMA ) ) then
				if( not cExpression( styleexpr ) ) then
					hReportError FB.ERRMSG.EXPECTEDEXPRESSION
					exit function
				end if
			end if
		end if
	else
		cexpr = astNewCONST( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
	end if

	''
	rtlGfxLine x1expr, y1expr, x2expr, y2expr, cexpr, linetype, styleexpr, coordtype

	cGfxLine = TRUE

end function

'':::::
'' GfxCircle     =   CIRCLE STEP? '(' Expr ',' Expr ')' ',' Expr ((',' Expr? (',' Expr? (',' Expr? (',' Expr (',' Expr)? )? )?)?)?)?
''
function cGfxCircle as integer
    dim coordtype as integer, fillflag as integer
    dim xexpr as integer, yexpr as integer, cexpr as integer
    dim radexpr as integer, iniexpr as integer, endexpr as integer, aspexpr as integer

	cGfxCircle = FALSE

	'' STEP?
	if( hMatch( FB.TK.STEP ) ) then
		coordtype = FBGFX_COORDTYPE_R
	else
		coordtype = FBGFX_COORDTYPE_A
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

	'' ',' Expr - radius
	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	if( not cExpression( radexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	aspexpr = INVALID
	iniexpr = INVALID
	endexpr = INVALID
	fillflag = FALSE

	'' (',' Expr? )? - color
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( cexpr ) ) then
			cexpr = astNewCONST( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
		end if

        '' (',' Expr? )? - iniarc
        if( hMatch( CHAR_COMMA ) ) then
        	if( not cExpression( iniexpr ) ) then
        		iniexpr = INVALID
        	end if

        	'' (',' Expr? )? - endarc
        	if( hMatch( CHAR_COMMA ) ) then
        		if( not cExpression( endexpr ) ) then
        			endexpr = INVALID
        		end if

            	'' (',' Expr )? - aspect
            	if( hMatch( CHAR_COMMA ) ) then
            		if( not cExpression( aspexpr ) ) then
            			aspexpr = INVALID
            		end if

            		'' (',' Expr )? - fillflag
            		if( hMatch( CHAR_COMMA ) ) then
            			if( ucase$( lexTokenText ) <> "F" ) then
							hReportError FB.ERRMSG.EXPECTEDEXPRESSION
							exit function
						end if
						lexSkipToken
						fillflag = TRUE
            		end if
            	end if
        	end if
        end if

	else
		cexpr = astNewCONST( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
	end if

	''
	rtlGfxCircle xexpr, yexpr, radexpr, cexpr, aspexpr, iniexpr, endexpr, fillflag, coordtype

	cGfxCircle = TRUE

end function

'':::::
'' GfxPaint   =   PAINT STEP? '(' expr ',' expr ')' (',' expr? (',' expr? ) )
''
function cGfxPaint as integer
    dim xexpr as integer, yexpr as integer, pexpr as integer, bexpr as integer
	dim coord_type as integer

	cGfxPaint = FALSE

	'' STEP?
	if( hMatch( FB.TK.STEP ) ) then
		coord_type = FBGFX_COORDTYPE_R
	else
		coord_type = FBGFX_COORDTYPE_A
	end if

	'' '(' Expr ',' Expr ')' - x and y
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

	pexpr = INVALID
	bexpr = INVALID

	'' color/pattern
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( pexpr ) ) then
			pexpr = INVALID
		end if

		'' background color
		if( hMatch( CHAR_COMMA ) ) then
			if( not cExpression( bexpr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		end if
	end if

	if( pexpr = INVALID ) then
		pexpr = astNewCONST( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
	end if

	if( bexpr = INVALID ) then
		bexpr = astNewCONST( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
	end if

	rtlGfxPaint xexpr, yexpr, pexpr, bexpr, coord_type

	cGfxPaint = TRUE

end function

'':::::
'' GfxView    =   VIEW (SCREEN? '(' Expr ',' Expr ')' '-' '(' Expr ',' Expr ')' (',' Expr? (',' Expr)?)? )?
''
function cGfxView( byval isview as integer ) as integer
    dim screenflag as integer
    dim x1expr as integer, y1expr as integer, x2expr as integer, y2expr as integer
    dim fillexpr as integer, bordexpr as integer

	cGfxView = FALSE

	'' SCREEN? (not a keyword or the Screen stmt would need a parser routine too)
	if( ucase$( lexTokenText ) = "SCREEN" ) then
		lexSkipToken
		screenflag = TRUE
	else
    	screenflag = FALSE
	end if

	''
	x1expr = INVALID
	y1expr = INVALID
	x2expr = INVALID
	y2expr = INVALID
	fillexpr = INVALID
    bordexpr = INVALID

	if( hMatch( CHAR_LPRNT ) ) then
		'' '(' Expr ',' Expr ')' - x1 and y1
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

		'' '-'
		if( not hMatch( CHAR_MINUS ) ) then
			hReportError FB.ERRMSG.EXPECTEDMINUS
			exit function
		end if

		'' '(' Expr ',' Expr ')' - x2 and y2
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

		if( isview ) then
			'' (',' Expr? )? - color
			if( hMatch( CHAR_COMMA ) ) then
				if( not cExpression( fillexpr ) ) then
					fillexpr = INVALID
				end if

        		'' (',' Expr? )? - border
        		if( hMatch( CHAR_COMMA ) ) then
					if( not cExpression( bordexpr ) ) then
						hReportError FB.ERRMSG.EXPECTEDEXPRESSION
						exit function
					end if
        		end if
        	end if
        end if

	end if

	''
	if( isview ) then
		rtlGfxView x1expr, y1expr, x2expr, y2expr, fillexpr, bordexpr, screenflag
	else
		rtlGfxWindow x1expr, y1expr, x2expr, y2expr, screenflag
	end if

	cGfxView = TRUE

end function

'':::::
'' GfxPalette   =   PALETTE ((USING Variable) | (Expr ',' Expr)?)
''
function cGfxPalette as integer
    dim arrayexpr as integer, s as FBSYMBOL ptr
    dim attexpr as integer, colexpr as integer

	cGfxPalette = FALSE

	if( hMatch( FB.TK.USING ) ) then

		if( not cVarOrDeref( arrayexpr ) ) then
            hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
            exit function
        end if

		s = astGetSymbol( arrayexpr )
		if( s = NULL ) then
            hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
            exit function
        end if

		if( not symbIsArray( s ) or (astGetClass( arrayexpr ) <> AST.NODECLASS.IDX) ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		end if

        rtlGfxPaletteUsing arrayexpr

	else

		attexpr = INVALID
		colexpr = INVALID

		if( cExpression( attexpr ) ) then
			if( not hMatch( CHAR_COMMA ) ) then
				hReportError FB.ERRMSG.EXPECTEDCOMMA
				exit function
			end if

			if( not cExpression( colexpr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		end if

		rtlGfxPalette attexpr, colexpr

	end if

	cGfxPalette = TRUE

end function

'':::::
private function hMakeArrayIndex( byval sym as FBSYMBOL ptr, byval arrayexpr as integer ) as integer
    dim idxexpr as integer

    ''  argument passed by descriptor?
    if( (symbGetAllocType( sym ) and FB.ALLOCTYPE.ARGUMENTBYDESC) > 0 ) then

    	astDelTree arrayexpr
    	arrayexpr = astNewVAR( sym, NULL, 0, IR.DATATYPE.INTEGER )
    	idxexpr = astNewPTR( sym, NULL, FB.ARRAYDESC.DATAOFFS, arrayexpr, IR.DATATYPE.INTEGER, NULL )
    	idxexpr = astNewLOAD( idxexpr, IR.DATATYPE.INTEGER )

    '' dynamic array? (this will handle common's too)
    elseif( symbGetIsDynamic( sym ) ) then

    	idxexpr = astNewVAR( symbGetArrayDescriptor( sym ), NULL, FB.ARRAYDESC.DATAOFFS, IR.DATATYPE.INTEGER )
    	idxexpr = astNewLOAD( idxexpr, IR.DATATYPE.INTEGER )

    '' static array
    else

    	idxexpr = astNewCONST( 0, IR.DATATYPE.INTEGER )

    end if

    hMakeArrayIndex = astNewIDX( arrayexpr, idxexpr, INVALID, NULL )

end function

'':::::
'' GfxPut   =   PUT STEP? '(' Expr ',' Expr ')' ',' Variable (',' Mode)?
''
function cGfxPut as integer
    dim coordtype as integer, mode as integer
    dim xexpr as integer, yexpr as integer
    dim arrayexpr as integer, s as FBSYMBOL ptr

	cGfxPut = FALSE

	'' STEP?
	if( hMatch( FB.TK.STEP ) ) then
		coordtype = FBGFX_COORDTYPE_R
	else
		coordtype = FBGFX_COORDTYPE_A
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

	'' ',' Variable
	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	if( not cVarOrDeref( arrayexpr, FALSE ) ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	s = astGetSymbol( arrayexpr )
	if( s = NULL ) then
    	hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	if( not symbIsArray( s ) ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	if( astGetClass( arrayexpr ) <> AST.NODECLASS.IDX ) then
		arrayexpr = hMakeArrayIndex( s, arrayexpr )
	end if

	'' (',' Mode)?
	mode = FBGFX_PUTMODE_XOR
	if( hMatch( CHAR_COMMA ) ) then
		select case lexCurrentToken

		case FB.TK.PSET
			lexSkipToken
			mode = FBGFX_PUTMODE_PSET

		case FB.TK.PRESET
			lexSkipToken
			mode = FBGFX_PUTMODE_PRESET

		case FB.TK.AND
			lexSkipToken
			mode = FBGFX_PUTMODE_AND

		case FB.TK.OR
			lexSkipToken
			mode = FBGFX_PUTMODE_OR

		case FB.TK.XOR
			lexSkipToken
			mode = FBGFX_PUTMODE_XOR

		case else
			if (ucase$( lexTokenText ) = "TRANS") then
				lexSkipToken
				mode = FBGFX_PUTMODE_TRANS
			else
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if
		end select
	end if

	''
	rtlGfxPut xexpr, yexpr, arrayexpr, mode, coordtype

	cGfxPut = TRUE

end function

'':::::
'' GfxGet   =   GET STEP? '(' Expr ',' Expr ')' '-' STEP? '(' Expr ',' Expr ')' ',' Variable
''
function cGfxGet as integer
    dim coordtype as integer
    dim x1expr as integer, y1expr as integer, x2expr as integer, y2expr as integer
    dim arrayexpr as integer, s as FBSYMBOL ptr

	cGfxGet = FALSE

	'' STEP?
	if( hMatch( FB.TK.STEP ) ) then
		coordtype = FBGFX_COORDTYPE_R
	else
		coordtype = FBGFX_COORDTYPE_A
	end if

	'' '(' Expr ',' Expr ')' - x1 and y1
	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

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

	'' '-'
	if( not hMatch( CHAR_MINUS ) ) then
		hReportError FB.ERRMSG.EXPECTEDMINUS
		exit function
	end if

	'' STEP?
	if( hMatch( FB.TK.STEP ) ) then
		if( coordtype = FBGFX_COORDTYPE_R ) then
			coordtype = FBGFX_COORDTYPE_RR
		else
			coordtype = FBGFX_COORDTYPE_AR
		end if
	else
		if( coordtype = FBGFX_COORDTYPE_R ) then
			coordtype = FBGFX_COORDTYPE_RA
		else
			coordtype = FBGFX_COORDTYPE_AA
		end if
	end if

	'' '(' Expr ',' Expr ')' - x2 and y2
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

	'' ',' Variable
	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	if( not cVarOrDeref( arrayexpr, FALSE ) ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	s = astGetSymbol( arrayexpr )
	if( s = NULL ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	if( not symbIsArray( s ) ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	if( astGetClass( arrayexpr ) <> AST.NODECLASS.IDX ) then
		arrayexpr = hMakeArrayIndex( s, arrayexpr )
	end if

    ''
	rtlGfxGet x1expr, y1expr, x2expr, y2expr, arrayexpr, s, coordtype

	cGfxGet = TRUE

end function

'':::::
'' GfxScreen     =   SCREEN (num | ((expr ((',' expr)? ',' expr)? expr)?)
''
function cGfxScreen as integer
    dim wexpr as integer, hexpr as integer, dexpr as integer, fexpr as integer

	cGfxScreen = FALSE

	if( not cExpression( wexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	hexpr = INVALID
	dexpr = INVALID
	fexpr = INVALID

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( hexpr ) ) then
			hexpr = INVALID
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( dexpr ) ) then
			dexpr = INVALID
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( fexpr ) ) then
			fexpr = INVALID
		end if
	end if

	''
	rtlGfxScreenSet wexpr, hexpr, dexpr, fexpr

	cGfxScreen = TRUE

end function

'':::::
'' GfxBload   =   BLOAD str (',' expr)?
''
function cGfxBload as integer
	dim fexpr as integer, dexpr as integer

	cGfxBload = FALSE

	if( not cExpression( fexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	dexpr = INVALID
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( dexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
	end if

	''
	rtlGfxBload fexpr, dexpr

	cGfxBload = TRUE

end function

'':::::
'' GfxBsave   =   BSAVE str ',' expr ',' expr
''
function cGfxBsave as integer
	dim fexpr as integer, sexpr as integer, lexpr as integer

	cGfxBsave = FALSE

	'' str
	if( not cExpression( fexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	'' ','
	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if
	
	'' expr
	if( not cExpression( sexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if
	
	'' ','
	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	'' expr
	if( not cExpression( lexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	''
	rtlGfxBsave fexpr, sexpr, lexpr

	cGfxBsave = TRUE

end function

'':::::
function cGfxStmt as integer

	cGfxStmt = FALSE

	select case lexCurrentToken
	case FB.TK.PSET, FB.TK.PRESET
		lexSkipToken
		cGfxStmt = cGfxPSet

	case FB.TK.LINE
		lexSkipToken
		cGfxStmt = cGfxLine

	case FB.TK.CIRCLE
		lexSkipToken
		cGfxStmt = cGfxCircle

	case FB.TK.PAINT
		lexSkipToken
		cGfxStmt = cGfxPaint

	case FB.TK.VIEW
		lexSkipToken
		cGfxStmt = cGfxView( TRUE )

	case FB.TK.WINDOW
		lexSkipToken
		cGfxStmt = cGfxView( FALSE )

	case FB.TK.PALETTE
		lexSkipToken
		cGfxStmt = cGfxPalette

	case FB.TK.PUT
		lexSkipToken
		cGfxStmt = cGfxPut

	case FB.TK.GET
		lexSkipToken
		cGfxStmt = cGfxGet

	case FB.TK.SCREEN
		lexSkipToken
		cGfxStmt = cGfxScreen

	case FB.TK.BLOAD
		lexSkipToken
		cGfxStmt = cGfxBload

	case FB.TK.BSAVE
		lexSkipToken
		cGfxStmt = cGfxBsave

	end select

end function

'':::::
function cGfxFunct ( funcexpr as integer ) as integer

	cGfxFunct = FALSE

end function

