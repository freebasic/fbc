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
'$include once: 'inc\fb.bi'
'$include once: 'inc\fbint.bi'
'$include once: 'inc\parser.bi'
'$include once: 'inc\rtl.bi'
'$include once: 'inc\ast.bi'
'$include once: 'inc\ir.bi'

const FBGFX_LINETYPE_LINE = 0
const FBGFX_LINETYPE_B    = 1
const FBGFX_LINETYPE_BF   = 2

const FBGFX_COORDTYPE_AA  = 0
const FBGFX_COORDTYPE_AR  = 1
const FBGFX_COORDTYPE_RA  = 2
const FBGFX_COORDTYPE_RR  = 3
const FBGFX_COORDTYPE_A   = 4
const FBGFX_COORDTYPE_R   = 5

const FBGFX_DEFAULTCOLOR  = &HFFFFFFFF

const FBGFX_PUTMODE_TRANS  = 0
const FBGFX_PUTMODE_PSET   = 1
const FBGFX_PUTMODE_PRESET = 2
const FBGFX_PUTMODE_AND    = 3
const FBGFX_PUTMODE_OR     = 4
const FBGFX_PUTMODE_XOR    = 5
const FBGFX_PUTMODE_ALPHA  = 6



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

    	idxexpr = astNewCONSTi( 0, IR.DATATYPE.INTEGER )

    end if

    hMakeArrayIndex = astNewIDX( arrayexpr, idxexpr, INVALID, NULL )

end function

'':::::
private function hGetTarget( targetexpr as integer, isptr as integer, byval fetchexpr as integer = TRUE ) as FBSYMBOL ptr
	dim s as FBSYMBOL ptr

	hGetTarget = NULL

	if( fetchexpr ) then
		targetexpr = INVALID
		if( not cVarOrDeref( targetexpr, FALSE, TRUE ) ) then
			exit function
		end if
	end if

	s = astGetSymbol( targetexpr )
	if( s = NULL ) then
		exit function
	end if

	'' address of?
	if( astIsADDR( targetexpr ) ) then
		isptr = TRUE
	else
		'' array?
		if( symbIsArray( s ) ) then
			'' no index given?
			if( not astIsIDX( targetexpr ) ) then
				targetexpr = hMakeArrayIndex( s, targetexpr )
			end if
			isptr = FALSE
		'' pointer?
		elseif( symbGetType( s ) >= FB.SYMBTYPE.POINTER ) then
			isptr = TRUE
		'' fail..
		else
			exit function
		end if
	end if

	hGetTarget = s

end function

'':::::
'' GfxPset     =   PSET ( Expr ',' )? STEP? '(' Expr ',' Expr ')' (',' Expr )?
''
function cGfxPset as integer
    dim coordtype as integer
    dim xexpr as integer, yexpr as integer, cexpr as integer
    dim texpr as integer, tisptr as integer, target as FBSYMBOL ptr

	cGfxPset = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( target ) then
		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if
	end if

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
		cexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
	end if

	''
	cGfxPset = rtlGfxPset( texpr, tisptr, xexpr, yexpr, cexpr, coordtype )

end function

'':::::
'' LINE ( Expr ',' )? STEP? ('(' Expr ',' Expr ')')? '-' STEP? '(' Expr ',' Expr ')' (',' Expr? (',' LIT_STRING? (',' Expr )?)?)?
''
function cGfxLine as integer
    dim coordtype as integer, linetype as integer, styleexpr as integer
    dim x1expr as integer, y1expr as integer, x2expr as integer, y2expr as integer
    dim cexpr as integer
    dim texpr as integer, tisptr as integer, target as FBSYMBOL ptr

	cGfxLine = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( target ) then
		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if
	end if

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
		x1expr = astNewCONSTf( 0, IR.DATATYPE.SINGLE )
		y1expr = astNewCONSTf( 0, IR.DATATYPE.SINGLE )
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
			cexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
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
		cexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
	end if

	''
	cGfxLine = rtlGfxLine( texpr, tisptr, x1expr, y1expr, x2expr, y2expr, cexpr, linetype, styleexpr, coordtype )

end function

'':::::
'' GfxCircle     =   CIRCLE ( Expr ',' )? STEP? '(' Expr ',' Expr ')' ',' Expr ((',' Expr? (',' Expr? (',' Expr? (',' Expr (',' Expr)? )? )?)?)?)?
''
function cGfxCircle as integer
    dim coordtype as integer, fillflag as integer
    dim xexpr as integer, yexpr as integer, cexpr as integer
    dim radexpr as integer, iniexpr as integer, endexpr as integer, aspexpr as integer
    dim texpr as integer, tisptr as integer, target as FBSYMBOL ptr

	cGfxCircle = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( target ) then
		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if
	end if

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
			cexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
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
		cexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
	end if

	''
	cGfxCircle = rtlGfxCircle( texpr, tisptr, xexpr, yexpr, radexpr, cexpr, aspexpr, iniexpr, endexpr, fillflag, coordtype )

end function

'':::::
'' GfxPaint   =   PAINT ( Expr ',' )? STEP? '(' expr ',' expr ')' (',' expr? (',' expr? ) )
''
function cGfxPaint as integer
    dim xexpr as integer, yexpr as integer, pexpr as integer, bexpr as integer
	dim coord_type as integer
    dim texpr as integer, tisptr as integer, target as FBSYMBOL ptr

	cGfxPaint = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( target ) then
		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if
	end if

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
		pexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
	end if

	if( bexpr = INVALID ) then
		bexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR.DATATYPE.UINT )
	end if

	cGfxPaint = rtlGfxPaint( texpr, tisptr, xexpr, yexpr, pexpr, bexpr, coord_type )

end function

'':::::
'' GfxDraw    =   DRAW ( Expr ',' )? Expr
''
function cGfxDraw as integer
	dim cexpr as integer
    dim texpr as integer, tisptr as integer, target as FBSYMBOL ptr

	cGfxDraw = FALSE

	if( not cExpression( texpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	if( hMatch( CHAR_COMMA ) ) then
		target = hGetTarget( texpr, tisptr, FALSE )
		if( target = NULL ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
		if( not cExpression( cexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
	else
		cexpr = texpr
		texpr = INVALID
	end if

	cGfxDraw = rtlGfxDraw( texpr, tisptr, cexpr )

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
		cGfxView = rtlGfxView( x1expr, y1expr, x2expr, y2expr, fillexpr, bordexpr, screenflag )
	else
		cGfxView = rtlGfxWindow( x1expr, y1expr, x2expr, y2expr, screenflag )
	end if

end function

'':::::
'' GfxPalette   =   PALETTE ((USING Variable) | (Expr ',' Expr (',' Expr ',' Expr)?)?)
''
function cGfxPalette as integer
    dim arrayexpr as integer, s as FBSYMBOL ptr
    dim attexpr as integer, rexpr as integer, gexpr as integer, bexpr as integer

	cGfxPalette = FALSE

	if( hMatch( FB.TK.USING ) ) then

		if( not cVarOrDeref( arrayexpr, FALSE, TRUE ) ) then
            hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
            exit function
        end if

		s = astGetSymbol( arrayexpr )
		if( s = NULL ) then
            hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
            exit function
        end if

		if( symbIsArray( s ) ) then
			if( not astIsIDX( arrayexpr ) ) then
				arrayexpr = hMakeArrayIndex( s, arrayexpr )
			end if
		elseif( symbGetType( s ) < FB.SYMBTYPE.POINTER ) then
			hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
			exit function
		end if

        cGfxPalette = rtlGfxPaletteUsing( arrayexpr )

	else

		attexpr = INVALID
		rexpr = INVALID
		gexpr = INVALID
		bexpr = INVALID

		if( cExpression( attexpr ) ) then
			if( not hMatch( CHAR_COMMA ) ) then
				hReportError FB.ERRMSG.EXPECTEDCOMMA
				exit function
			end if

			if( not cExpression( rexpr ) ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if

			if( hMatch( CHAR_COMMA ) ) then
				if( not cExpression( gexpr ) ) then
					hReportError FB.ERRMSG.EXPECTEDEXPRESSION
					exit function
				end if

				if( not hMatch( CHAR_COMMA ) ) then
					hReportError FB.ERRMSG.EXPECTEDCOMMA
					exit function
				end if

				if( not cExpression( bexpr ) ) then
					hReportError FB.ERRMSG.EXPECTEDEXPRESSION
					exit function
				end if
			end if
		end if

		cGfxPalette = rtlGfxPalette( attexpr, rexpr, gexpr, bexpr )

	end if

end function

'':::::
'' GfxPut   =   PUT ( Expr ',' )? STEP? '(' Expr ',' Expr ')' ',' Variable (',' Mode)?
''
function cGfxPut as integer
    dim coordtype as integer, mode as integer
    dim xexpr as integer, yexpr as integer
    dim arrayexpr as integer, s as FBSYMBOL ptr
    dim isptr as integer
    dim texpr as integer, tisptr as integer, target as FBSYMBOL ptr

	cGfxPut = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( target ) then
		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if
	end if

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

	s = hGetTarget( arrayexpr, isptr )
	if( s = NULL ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

	'' (',' Mode)?
	mode = FBGFX_PUTMODE_XOR
	if( hMatch( CHAR_COMMA ) ) then
		select case as const lexCurrentToken

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
			elseif (ucase$( lexTokenText ) = "ALPHA") then
				lexSkipToken
				mode = FBGFX_PUTMODE_ALPHA
			else
				hReportError FB.ERRMSG.SYNTAXERROR
				exit function
			end if
		end select
	end if

	''
	cGfxPut = rtlGfxPut( texpr, tisptr, xexpr, yexpr, arrayexpr, isptr, mode, coordtype )

end function

'':::::
'' GfxGet   =   GET ( Expr ',' )? STEP? '(' Expr ',' Expr ')' '-' STEP? '(' Expr ',' Expr ')' ',' Variable
''
function cGfxGet as integer
    dim coordtype as integer
    dim x1expr as integer, y1expr as integer, x2expr as integer, y2expr as integer
    dim arrayexpr as integer, s as FBSYMBOL ptr
    dim isptr as integer
    dim texpr as integer, tisptr as integer, target as FBSYMBOL ptr

	cGfxGet = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( target ) then
		if( not hMatch( CHAR_COMMA ) ) then
			hReportError FB.ERRMSG.EXPECTEDCOMMA
			exit function
		end if
	end if

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

	s = hGetTarget( arrayexpr, isptr )
	if( s = NULL ) then
		hReportError FB.ERRMSG.EXPECTEDIDENTIFIER
		exit function
	end if

    ''
	cGfxGet = rtlGfxGet( texpr, tisptr, x1expr, y1expr, x2expr, y2expr, arrayexpr, isptr, s, coordtype )

end function

'':::::
'' GfxScreen     =   SCREEN (num | ((expr (((',' expr)? ',' expr)? expr)? ',' expr))
''
function cGfxScreen as integer
    dim mexpr as integer, dexpr as integer, pexpr as integer, fexpr as integer, rexpr

	cGfxScreen = FALSE

	if( not cExpression( mexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	dexpr = INVALID
	pexpr = INVALID
	fexpr = INVALID
	rexpr = INVALID

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( dexpr ) ) then
			dexpr = INVALID
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( pexpr ) ) then
			pexpr = INVALID
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( fexpr ) ) then
			fexpr = INVALID
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( rexpr ) ) then
			rexpr = INVALID
		end if
	end if

	''
	cGfxScreen = rtlGfxScreenSet( mexpr, INVALID, dexpr, pexpr, fexpr, rexpr )

end function

'':::::
'' GfxScreenRes     =   SCREENRES expr ',' expr (((',' expr)? ',' expr)? ',' expr)?
''
function cGfxScreenRes as integer
    dim wexpr as integer, hexpr as integer, dexpr as integer, pexpr as integer, fexpr as integer, rexpr as integer

	cGfxScreenRes = FALSE

	if( not cExpression( wexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	if( not cExpression( hexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	dexpr = INVALID
	pexpr = INVALID
	fexpr = INVALID
	rexpr = INVALID

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( dexpr ) ) then
			dexpr = INVALID
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( pexpr ) ) then
			pexpr = INVALID
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( fexpr ) ) then
			fexpr = INVALID
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( rexpr ) ) then
			rexpr = INVALID
		end if
	end if

	''
	cGfxScreenRes = rtlGfxScreenSet( wexpr, hexpr, dexpr, pexpr, fexpr, rexpr )

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
	cGfxBload = rtlGfxBload( fexpr, dexpr )

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
	cGfxBsave = rtlGfxBsave( fexpr, sexpr, lexpr )

end function

'':::::
function cGfxStmt as integer

	cGfxStmt = FALSE

	select case as const lexCurrentToken
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

	case FB.TK.DRAW
		lexSkipToken
		cGfxStmt = cGfxDraw

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

	case FB.TK.SCREENRES
		lexSkipToken
		cGfxStmt = cGfxScreenRes

	case FB.TK.BLOAD
		lexSkipToken
		cGfxStmt = cGfxBload

	case FB.TK.BSAVE
		lexSkipToken
		cGfxStmt = cGfxBsave

	end select

end function

'':::::
'' GfxPoint    =   POINT '(' Expr ( ',' ( Expr )? ( ',' Expr )? )? ')'
''
function cGfxPoint( funcexpr as integer ) as integer
	dim xexpr as integer, yexpr as integer
    dim texpr as integer, tisptr as integer, target as FBSYMBOL ptr

	cGfxPoint = FALSE

	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

	if( not cExpression( xexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	yexpr = INVALID
	texpr = INVALID

	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( yexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if

		if( hMatch( CHAR_COMMA ) ) then
			target = hGetTarget( texpr, tisptr )
			if( target = NULL ) then
				hReportError FB.ERRMSG.EXPECTEDEXPRESSION
				exit function
			end if
		end if
	end if

	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
		exit function
	end if

	funcexpr = rtlGfxPoint( texpr, tisptr, xexpr, yexpr )

	cGfxPoint = TRUE

end function


'':::::
'' ConsoleReadXY   =   SCREEN '(' expr ',' expr ( ',' expr )? ')'
''
function cConsoleReadXY( funcexpr as integer ) as integer
    dim yexpr as integer, xexpr as integer, fexpr as integer

	cConsoleReadXY = FALSE

	if( not hMatch( CHAR_LPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDLPRNT
		exit function
	end if

	if( not cExpression( yexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	if( not hMatch( CHAR_COMMA ) ) then
		hReportError FB.ERRMSG.EXPECTEDCOMMA
		exit function
	end if

	if( not cExpression( xexpr ) ) then
		hReportError FB.ERRMSG.EXPECTEDEXPRESSION
		exit function
	end if

	fexpr = INVALID
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( fexpr ) ) then
			hReportError FB.ERRMSG.EXPECTEDEXPRESSION
			exit function
		end if
	end if

	if( not hMatch( CHAR_RPRNT ) ) then
		hReportError FB.ERRMSG.EXPECTEDRPRNT
		exit function
	end if

	funcexpr = rtlConsoleReadXY( yexpr, xexpr, fexpr )

	cConsoleReadXY = TRUE

end function

'':::::
function cGfxFunct ( funcexpr as integer ) as integer

	cGfxFunct = FALSE

	select case lexCurrentToken
	case FB.TK.POINT
		lexSkipToken
		cGfxFunct = cGfxPoint( funcexpr )

	case FB.TK.SCREEN
		lexSkipToken
		cGfxFunct = cConsoleReadXY( funcexpr )

	end select

end function

