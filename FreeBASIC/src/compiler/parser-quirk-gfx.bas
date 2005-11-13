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


'' quirk graphic statements and functions (SCREEN, PSET, LINE, ...) parsing
''
'' chng: dec/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

const FBGFX_LINETYPE_LINE = 0
const FBGFX_LINETYPE_B    = 1
const FBGFX_LINETYPE_BF   = 2

const FBGFX_COORDTYPE_AA  = 0
const FBGFX_COORDTYPE_AR  = 1
const FBGFX_COORDTYPE_RA  = 2
const FBGFX_COORDTYPE_RR  = 3
const FBGFX_COORDTYPE_A   = 4
const FBGFX_COORDTYPE_R   = 5

const FBGFX_DEFAULTCOLOR  = &hFEFF00FF

const FBGFX_PUTMODE_TRANS  = 0
const FBGFX_PUTMODE_PSET   = 1
const FBGFX_PUTMODE_PRESET = 2
const FBGFX_PUTMODE_AND    = 3
const FBGFX_PUTMODE_OR     = 4
const FBGFX_PUTMODE_XOR    = 5
const FBGFX_PUTMODE_ALPHA  = 6
const FBGFX_PUTMODE_CUSTOM = 7



'':::::
private function hMakeArrayIndex( byval sym as FBSYMBOL ptr, _
								  byval arrayexpr as ASTNODE ptr ) as ASTNODE ptr
    dim as ASTNODE ptr idxexpr, temp

    '' field?
    if( astIsFIELD( arrayexpr ) ) then
    	return arrayexpr
    end if

    ''  argument passed by descriptor?
    if( symbIsArgByDesc( sym ) ) then

    	astDelTree( arrayexpr )

    	temp	  = astNewVAR( sym, 0, IR_DATATYPE_INTEGER )
    	idxexpr   = astNewPTR( FB_ARRAYDESC_DATAOFFS, temp, IR_DATATYPE_INTEGER, NULL )
    	idxexpr   = astNewLOAD( idxexpr, IR_DATATYPE_INTEGER )
    	arrayexpr = astNewVAR( sym, 0, IR_DATATYPE_INTEGER )

    '' dynamic array? (this will handle common's too)
    elseif( symbGetIsDynamic( sym ) ) then

    	idxexpr = astNewVAR( symbGetArrayDescriptor( sym ), _
    						 FB_ARRAYDESC_DATAOFFS, _
    						 IR_DATATYPE_INTEGER )
    	idxexpr = astNewLOAD( idxexpr, IR_DATATYPE_INTEGER )

    '' static array
    else

    	idxexpr = astNewCONSTi( 0, IR_DATATYPE_INTEGER )

    end if

    function = astNewIDX( arrayexpr, idxexpr, _
    					  astGetDataType( arrayexpr ), astGetSubType( arrayexpr ) )

end function

'':::::
private function hGetTarget( byref targetexpr as ASTNODE ptr, _
							 byref isptr as integer, _
							 byval fetchexpr as integer = TRUE ) as FBSYMBOL ptr
	dim as FBSYMBOL ptr s

	function = NULL

	isptr = FALSE

	if( fetchexpr ) then
		targetexpr = NULL
		if( lexGetToken( ) <> CHAR_LPRNT ) then
			if( not cVarOrDeref( targetexpr, FALSE, TRUE ) ) then
				exit function
			end if
		else
			exit function
		end if
	end if

	'' address of?
	if( astIsADDR( targetexpr ) ) then
		isptr = TRUE
	else
		s = astGetSymbol( targetexpr )
		if( s = NULL ) then
			exit function
		end if

		'' pointer?
		if( symbGetType( s ) >= FB_SYMBTYPE_POINTER ) then
			isptr = TRUE
		'' array?
		elseif( symbIsArray( s ) ) then
			'' no index given?
			if( not astIsIDX( targetexpr ) ) then
				targetexpr = hMakeArrayIndex( s, targetexpr )
			end if
			isptr = FALSE
		'' fail..
		else
			exit function
		end if
	end if

	function = s

end function

'':::::
'' GfxPset     =   PSET ( Expr ',' )? STEP? '(' Expr ',' Expr ')' (',' Expr )?
''
function cGfxPset( byval ispreset as integer ) as integer
    dim as integer coordtype, tisptr
    dim as ASTNODE ptr xexpr, yexpr, cexpr, texpr
    dim as FBSYMBOL ptr target

	function = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( (target <> NULL) or (tisptr) ) then
		hMatchCOMMA( )
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
		coordtype = FBGFX_COORDTYPE_R
	else
		coordtype = FBGFX_COORDTYPE_A
	end if

	'' '(' Expr ',' Expr ')'
	hMatchLPRNT( )

	hMatchExpression( xexpr )

	hMatchCOMMA( )

	hMatchExpression( yexpr )

	hMatchRPRNT( )

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		hMatchExpression( cexpr )
	else
		cexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR_DATATYPE_UINT )
	end if

	''
	function = rtlGfxPset( texpr, tisptr, xexpr, yexpr, cexpr, coordtype, ispreset )

end function

'':::::
'' LINE ( Expr ',' )? STEP? ('(' Expr ',' Expr ')')? '-' STEP? '(' Expr ',' Expr ')' (',' Expr? (',' LIT_STRING? (',' Expr )?)?)?
''
function cGfxLine as integer
    dim as integer coordtype, linetype, tisptr
    dim as ASTNODE ptr styleexpr, x1expr, y1expr, x2expr, y2expr, cexpr, texpr
    dim as FBSYMBOL ptr target

	function = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( (target <> NULL) or (tisptr) ) then
		hMatchCOMMA( )
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
		coordtype = FBGFX_COORDTYPE_R
	else
		coordtype = FBGFX_COORDTYPE_A
	end if

	'' ('(' Expr ',' Expr ')')?
	if( hMatch( CHAR_LPRNT ) ) then

		hMatchExpression( x1expr )

		hMatchCOMMA( )

		hMatchExpression( y1expr )

		hMatchRPRNT( )

	else
		coordtype = FBGFX_COORDTYPE_R
		x1expr = astNewCONSTf( 0, IR_DATATYPE_SINGLE )
		y1expr = astNewCONSTf( 0, IR_DATATYPE_SINGLE )
	end if

	'' '-'
	if( not hMatch( CHAR_MINUS ) ) then
		hReportError FB_ERRMSG_EXPECTEDMINUS
		exit function
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
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
	hMatchLPRNT( )

	hMatchExpression( x2expr )

	hMatchCOMMA( )

	hMatchExpression( y2expr )

	hMatchRPRNT( )

	linetype = FBGFX_LINETYPE_LINE
	styleexpr = NULL

	'' (',' Expr? (',' LIT_STRING? (',' Expr )?)?)?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( cexpr ) ) then
			cexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR_DATATYPE_UINT )
		end if

		'' ',' LIT_STRING? - linetype
		if( hMatch( CHAR_COMMA ) ) then
			select case ucase$( *lexGetText( ) )
			case "B"
				lexSkipToken( )
				linetype = FBGFX_LINETYPE_B
			case "BF"
				lexSkipToken( )
		    	linetype = FBGFX_LINETYPE_BF
		    end select

			''  (',' Expr )? - style
			if( hMatch( CHAR_COMMA ) ) then
				hMatchExpression( styleexpr )
			end if
		end if
	else
		cexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR_DATATYPE_UINT )
	end if

	''
	function = rtlGfxLine( texpr, tisptr, x1expr, y1expr, x2expr, y2expr, _
						   cexpr, linetype, styleexpr, coordtype )

end function

'':::::
'' GfxCircle     =   CIRCLE ( Expr ',' )? STEP? '(' Expr ',' Expr ')' ',' Expr ((',' Expr? (',' Expr? (',' Expr? (',' Expr (',' Expr)? )? )?)?)?)?
''
function cGfxCircle as integer
    dim as integer coordtype, fillflag, tisptr
    dim as ASTNODE ptr xexpr, yexpr, cexpr, radexpr, iniexpr, endexpr, aspexpr, texpr
    dim as FBSYMBOL ptr target

	function = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( (target <> NULL) or (tisptr) ) then
		hMatchCOMMA( )
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
		coordtype = FBGFX_COORDTYPE_R
	else
		coordtype = FBGFX_COORDTYPE_A
	end if

	'' '(' Expr ',' Expr ')'
	hMatchLPRNT( )

	hMatchExpression( xexpr )

	hMatchCOMMA( )

	hMatchExpression( yexpr )

	hMatchRPRNT( )

	'' ',' Expr - radius
	hMatchCOMMA( )

	hMatchExpression( radexpr )

	aspexpr = NULL
	iniexpr = NULL
	endexpr = NULL
	fillflag = FALSE

	'' (',' Expr? )? - color
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( cexpr ) ) then
			cexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR_DATATYPE_UINT )
		end if

        '' (',' Expr? )? - iniarc
        if( hMatch( CHAR_COMMA ) ) then
        	if( not cExpression( iniexpr ) ) then
        		iniexpr = NULL
        	end if

        	'' (',' Expr? )? - endarc
        	if( hMatch( CHAR_COMMA ) ) then
        		if( not cExpression( endexpr ) ) then
        			endexpr = NULL
        		end if

            	'' (',' Expr )? - aspect
            	if( hMatch( CHAR_COMMA ) ) then
            		if( not cExpression( aspexpr ) ) then
            			aspexpr = NULL
            		end if

            		'' (',' Expr )? - fillflag
            		if( hMatch( CHAR_COMMA ) ) then
            			if( ucase$( *lexGetText( ) ) <> "F" ) then
							hReportError FB_ERRMSG_EXPECTEDEXPRESSION
							exit function
						end if
						lexSkipToken( )
						fillflag = TRUE
            		end if
            	end if
        	end if
        end if

	else
		cexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR_DATATYPE_UINT )
	end if

	''
	function = rtlGfxCircle( texpr, tisptr, xexpr, yexpr, radexpr, cexpr, _
			  			     aspexpr, iniexpr, endexpr, fillflag, coordtype )

end function

'':::::
'' GfxPaint   =   PAINT ( Expr ',' )? STEP? '(' expr ',' expr ')' (',' expr? (',' expr? ) )
''
function cGfxPaint as integer
    dim as ASTNODE ptr xexpr, yexpr, pexpr, bexpr, texpr
	dim as integer coord_type, tisptr
    dim as FBSYMBOL ptr target

	function = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( (target <> NULL) or (tisptr) ) then
		hMatchCOMMA( )
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
		coord_type = FBGFX_COORDTYPE_R
	else
		coord_type = FBGFX_COORDTYPE_A
	end if

	'' '(' Expr ',' Expr ')' - x and y
	hMatchLPRNT( )

	hMatchExpression( xexpr )

	hMatchCOMMA( )

	hMatchExpression( yexpr )

	hMatchRPRNT( )

	pexpr = NULL
	bexpr = NULL

	'' color/pattern
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( pexpr ) ) then
			pexpr = NULL
		end if

		'' background color
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpression( bexpr )
		end if
	end if

	if( pexpr = NULL ) then
		pexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR_DATATYPE_UINT )
	end if

	if( bexpr = NULL ) then
		bexpr = astNewCONSTi( FBGFX_DEFAULTCOLOR, IR_DATATYPE_UINT )
	end if

	function = rtlGfxPaint( texpr, tisptr, xexpr, yexpr, pexpr, bexpr, coord_type )

end function

'':::::
'' GfxDraw    =   DRAW ( Expr ',' )? Expr
''
function cGfxDraw as integer
	dim as ASTNODE ptr cexpr, texpr
    dim as integer tisptr
    dim as FBSYMBOL ptr target

	function = FALSE

	texpr = NULL

	if( lexGetLookAhead( 1 ) = CHAR_COMMA ) then
		target = hGetTarget( texpr, tisptr )
		if( target = NULL and not tisptr ) then
			hReportError FB_ERRMSG_EXPECTEDEXPRESSION
			exit function
		end if
		hMatch( CHAR_COMMA )
	end if

	hMatchExpression( cexpr )

	function = rtlGfxDraw( texpr, tisptr, cexpr )

end function

'':::::
'' GfxView    =   VIEW (SCREEN? '(' Expr ',' Expr ')' '-' '(' Expr ',' Expr ')' (',' Expr? (',' Expr)?)? )?
''
function cGfxView( byval isview as integer ) as integer
    dim as integer screenflag
    dim as ASTNODE ptr x1expr, y1expr, x2expr, y2expr, fillexpr, bordexpr

	function = FALSE

	'' SCREEN?
	if( lexGetToken() = FB_TK_SCREEN ) then
		lexSkipToken
		screenflag = TRUE
	else
    	screenflag = FALSE
	end if

	''
	x1expr = NULL
	y1expr = NULL
	x2expr = NULL
	y2expr = NULL
	fillexpr = NULL
    bordexpr = NULL

	if( hMatch( CHAR_LPRNT ) ) then
		'' '(' Expr ',' Expr ')' - x1 and y1
		hMatchExpression( x1expr )

		hMatchCOMMA( )

		hMatchExpression( y1expr )

		hMatchRPRNT( )

		'' '-'
		if( not hMatch( CHAR_MINUS ) ) then
			hReportError FB_ERRMSG_EXPECTEDMINUS
			exit function
		end if

		'' '(' Expr ',' Expr ')' - x2 and y2
		hMatchLPRNT( )

		hMatchExpression( x2expr )

		hMatchCOMMA( )

		hMatchExpression( y2expr )

		hMatchRPRNT( )

		if( isview ) then
			'' (',' Expr? )? - color
			if( hMatch( CHAR_COMMA ) ) then
				if( not cExpression( fillexpr ) ) then
					fillexpr = NULL
				end if

        		'' (',' Expr? )? - border
        		if( hMatch( CHAR_COMMA ) ) then
					hMatchExpression( bordexpr )
        		end if
        	end if
        end if

	end if

	''
	if( isview ) then
		function = rtlGfxView( x1expr, y1expr, x2expr, y2expr, fillexpr, bordexpr, screenflag )
	else
		function = rtlGfxWindow( x1expr, y1expr, x2expr, y2expr, screenflag )
	end if

end function

'':::::
'' GfxPalette   =   PALETTE GET? ((USING Variable) | (Expr ',' Expr (',' Expr ',' Expr)?)?)
''
function cGfxPalette as integer
    dim as ASTNODE ptr arrayexpr, attexpr, rexpr, gexpr, bexpr
    dim as FBSYMBOL ptr s
    dim as integer isget

	function = FALSE

	if( hMatch( FB_TK_GET ) ) then
		isget = TRUE
	else
		isget = FALSE
	end if

	if( hMatch( FB_TK_USING ) ) then

		if( not cVarOrDeref( arrayexpr, FALSE, TRUE ) ) then
            hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
            exit function
        end if

		s = astGetSymbol( arrayexpr )
		if( s = NULL ) then
            hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
            exit function
        end if

		if( symbIsArray( s ) ) then
			if( not astIsIDX( arrayexpr ) ) then
				arrayexpr = hMakeArrayIndex( s, arrayexpr )
			end if
		elseif( symbGetType( s ) < FB_SYMBTYPE_POINTER ) then
			hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
			exit function
		end if

        function = rtlGfxPaletteUsing( arrayexpr, isget )

	else

		attexpr = NULL
		rexpr = NULL
		gexpr = NULL
		bexpr = NULL

		if( cExpression( attexpr ) ) then
			hMatchCOMMA( )

			if( isget ) then
				if( not cVarOrDeref( rexpr, FALSE, TRUE ) ) then
		            hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
		            exit function
		        end if
	        else
				hMatchExpression( rexpr )
    	    end if

			if( hMatch( CHAR_COMMA ) ) then
				if( isget ) then
					if( not cVarOrDeref( gexpr, FALSE, TRUE ) ) then
			            hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
			            exit function
			        end if
				else
					hMatchExpression( gexpr )
				end if

				hMatchCOMMA( )

				if( isget ) then
					if( not cVarOrDeref( bexpr, FALSE, TRUE ) ) then
			            hReportError FB_ERRMSG_EXPECTEDIDENTIFIER
			            exit function
			        end if
				else
					hMatchExpression( bexpr )
				end if
			end if
		else
			if( isget ) then
				hReportError FB_ERRMSG_EXPECTEDEXPRESSION
				exit function
			end if
		end if

		function = rtlGfxPalette( attexpr, rexpr, gexpr, bexpr, isget )

	end if

end function

'':::::
'' GfxPut   =   PUT ( Expr ',' )? STEP? '(' Expr ',' Expr ')' ',' ('(' Expr ',' Expr ')' '-' '(' Expr ',' Expr ')' ',')? Variable (',' Mode (',' Alpha)?)?
''
function cGfxPut as integer
    dim as integer coordtype, mode, isptr, tisptr, expectmode
    dim as ASTNODE ptr xexpr, yexpr, arrayexpr, texpr, alphaexpr, funcexpr, x1expr, y1expr, x2expr, y2expr
    dim as FBSYMBOL ptr s, target, arg1, arg2

	function = FALSE

	alphaexpr = NULL
	funcexpr = NULL
	x1expr = NULL

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( (target <> NULL) or (tisptr) ) then
		hMatchCOMMA( )
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
		coordtype = FBGFX_COORDTYPE_R
	else
		coordtype = FBGFX_COORDTYPE_A
	end if

	'' '(' Expr ',' Expr ')'
	hMatchLPRNT( )

	hMatchExpression( xexpr )

	hMatchCOMMA( )

	hMatchExpression( yexpr )

	hMatchRPRNT( )

	'' ',' Variable
	hMatchCOMMA( )

	s = hGetTarget( arrayexpr, isptr )
	if( (s = NULL) and (not isptr) ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

	'' (',' Mode)?
	mode = FBGFX_PUTMODE_XOR
	if( hMatch( CHAR_COMMA ) ) then

		expectmode = TRUE

		if( hMatch( CHAR_LPRNT ) ) then

			hMatchExpression( x1expr )
			hMatchCOMMA( )
			hMatchExpression( y1expr )
			hMatchRPRNT( )

			if( not hMatch( CHAR_MINUS ) ) then
				hReportError FB_ERRMSG_EXPECTEDMINUS
				exit function
			end if

			hMatchLPRNT( )
			hMatchExpression( x2expr )
			hMatchCOMMA( )
			hMatchExpression( y2expr )
			hMatchRPRNT( )

			if( not hMatch( CHAR_COMMA ) ) then
				expectmode = FALSE
			end if
		end if

		if( expectmode ) then
			select case as const lexGetToken

			case FB_TK_PSET
				lexSkipToken
				mode = FBGFX_PUTMODE_PSET

			case FB_TK_PRESET
				lexSkipToken
				mode = FBGFX_PUTMODE_PRESET

			case FB_TK_AND
				lexSkipToken
				mode = FBGFX_PUTMODE_AND

			case FB_TK_OR
				lexSkipToken
				mode = FBGFX_PUTMODE_OR

			case FB_TK_XOR
				lexSkipToken
				mode = FBGFX_PUTMODE_XOR

			case else
				if (ucase$( *lexGetText( ) ) = "TRANS") then
					lexSkipToken( )
					mode = FBGFX_PUTMODE_TRANS

				elseif (ucase$( *lexGetText( ) ) = "ALPHA") then
					lexSkipToken( )
					mode = FBGFX_PUTMODE_ALPHA

					if( hMatch( CHAR_COMMA ) ) then
						hMatchExpression( alphaexpr )
					end if

				elseif (ucase$( *lexGetText( ) ) = "CUSTOM") then
					lexSkipToken( )

					mode = FBGFX_PUTMODE_CUSTOM

					hMatchCOMMA( )

					hMatchExpression( funcexpr )

					s = astGetSymbol( funcexpr )
					if( s = NULL ) then
						hReportError FB_ERRMSG_TYPEMISMATCH
						exit function
					end if

					if( not symbIsProc( s ) ) then
						hReportError FB_ERRMSG_TYPEMISMATCH
						exit function
					end if

					if( ( symbGetType( s ) <> FB_SYMBTYPE_UINT ) or _
						( symbGetProcArgs( s ) <> 2 ) ) then
						hReportError FB_ERRMSG_TYPEMISMATCH
						exit function
					end if

					arg1 = symbGetProcHeadArg( s )

					arg2 = symbGetArgNext( arg1 )

					if( ( symbGetType( arg1 ) <> FB_SYMBTYPE_UINT ) or _
						( symbGetType( arg2 ) <> FB_SYMBTYPE_UINT ) or _
						( arg1->arg.mode <> FB_ARGMODE_BYVAL ) or _
						( arg2->arg.mode <> FB_ARGMODE_BYVAL ) ) then
						hReportError( FB_ERRMSG_TYPEMISMATCH )
						exit function
					end if

				else
					hReportError( FB_ERRMSG_SYNTAXERROR )
					exit function
				end if
			end select
		end if
	end if

	''
	function = rtlGfxPut( texpr, tisptr, xexpr, yexpr, arrayexpr, isptr, _
						  x1expr, y1expr, x2expr, y2expr, _
						  mode, alphaexpr, funcexpr, coordtype )

end function

'':::::
'' GfxGet   =   GET ( Expr ',' )? STEP? '(' Expr ',' Expr ')' '-' STEP? '(' Expr ',' Expr ')' ',' Variable
''
function cGfxGet as integer
    dim as integer coordtype, isptr, tisptr
    dim as ASTNODE ptr x1expr, y1expr, x2expr, y2expr, arrayexpr, texpr
    dim as FBSYMBOL ptr s, target

	function = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( (target <> NULL) or (tisptr) ) then
		hMatchCOMMA( )
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
		coordtype = FBGFX_COORDTYPE_R
	else
		coordtype = FBGFX_COORDTYPE_A
	end if

	'' '(' Expr ',' Expr ')' - x1 and y1
	hMatchLPRNT( )

	hMatchExpression( x1expr )

	hMatchCOMMA( )

	hMatchExpression( y1expr )

	hMatchRPRNT( )

	'' '-'
	if( not hMatch( CHAR_MINUS ) ) then
		hReportError FB_ERRMSG_EXPECTEDMINUS
		exit function
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
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
	hMatchLPRNT( )

	hMatchExpression( x2expr )

	hMatchCOMMA( )

	hMatchExpression( y2expr )

	hMatchRPRNT( )

	'' ',' Variable
	hMatchCOMMA( )

	s = hGetTarget( arrayexpr, isptr )
	if( (s = NULL) and (not isptr) ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

    ''
	function = rtlGfxGet( texpr, tisptr, x1expr, y1expr, x2expr, y2expr, _
						  arrayexpr, isptr, s, coordtype )

end function

'':::::
'' GfxScreen     =   SCREEN (num | ((expr (((',' expr)? ',' expr)? expr)? ',' expr))
''
function cGfxScreen as integer
    dim as ASTNODE ptr mexpr, dexpr, pexpr, fexpr, rexpr

	function = FALSE

	hMatchExpression( mexpr )

	dexpr = NULL
	pexpr = NULL
	fexpr = NULL
	rexpr = NULL

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( dexpr ) ) then
			dexpr = NULL
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( pexpr ) ) then
			pexpr = NULL
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( fexpr ) ) then
			fexpr = NULL
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( rexpr ) ) then
			rexpr = NULL
		end if
	end if

	''
	function = rtlGfxScreenSet( mexpr, NULL, dexpr, pexpr, fexpr, rexpr )

end function

'':::::
'' GfxScreenRes     =   SCREENRES expr ',' expr (((',' expr)? ',' expr)? ',' expr)?
''
function cGfxScreenRes as integer
    dim as ASTNODE ptr wexpr, hexpr, dexpr, pexpr, fexpr, rexpr

	function = FALSE

	hMatchExpression( wexpr )

	hMatchCOMMA( )

	hMatchExpression( hexpr )

	dexpr = NULL
	pexpr = NULL
	fexpr = NULL
	rexpr = NULL

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( dexpr ) ) then
			dexpr = NULL
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( pexpr ) ) then
			pexpr = NULL
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( fexpr ) ) then
			fexpr = NULL
		end if
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		if( not cExpression( rexpr ) ) then
			rexpr = NULL
		end if
	end if

	''
	function = rtlGfxScreenSet( wexpr, hexpr, dexpr, pexpr, fexpr, rexpr )

end function

'':::::
'' GfxPoint    =   POINT '(' Expr ( ',' ( Expr )? ( ',' Expr )? )? ')'
''
function cGfxPoint( byref funcexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr xexpr, yexpr, texpr
    dim as integer tisptr
    dim as FBSYMBOL ptr target

	function = FALSE

	hMatchLPRNT( )

	hMatchExpression( xexpr )

	yexpr = NULL
	texpr = NULL

	if( hMatch( CHAR_COMMA ) ) then
		hMatchExpression( yexpr )

		if( hMatch( CHAR_COMMA ) ) then
			target = hGetTarget( texpr, tisptr )
			if( target = NULL and not tisptr ) then
				hReportError FB_ERRMSG_EXPECTEDEXPRESSION
				exit function
			end if
		end if
	end if

	hMatchRPRNT( )

	funcexpr = rtlGfxPoint( texpr, tisptr, xexpr, yexpr )

	function = funcexpr <> NULL

end function

'':::::
function cGfxStmt as integer

	function = FALSE

	select case as const lexGetToken( )
	case FB_TK_PSET
		lexSkipToken( )
		function = cGfxPSet( FALSE )

	case FB_TK_PRESET
		lexSkipToken( )
		function = cGfxPSet( TRUE )

	case FB_TK_LINE
		lexSkipToken( )
		function = cGfxLine( )

	case FB_TK_CIRCLE
		lexSkipToken( )
		function = cGfxCircle( )

	case FB_TK_PAINT
		lexSkipToken( )
		function = cGfxPaint( )

	case FB_TK_DRAW
		lexSkipToken( )
		function = cGfxDraw( )

	case FB_TK_VIEW
		lexSkipToken( )
		function = cGfxView( TRUE )

	case FB_TK_WINDOW
		lexSkipToken( )
		function = cGfxView( FALSE )

	case FB_TK_PALETTE
		lexSkipToken( )
		function = cGfxPalette( )

	case FB_TK_PUT
		lexSkipToken( )
		function = cGfxPut( )

	case FB_TK_GET
		lexSkipToken( )
		function = cGfxGet( )

	case FB_TK_SCREEN
		lexSkipToken( )
		function = cGfxScreen( )

	case FB_TK_SCREENRES
		lexSkipToken( )
		function = cGfxScreenRes( )

	end select

end function

'':::::
function cGfxFunct ( byref funcexpr as ASTNODE ptr ) as integer

	function = FALSE

	select case lexGetToken( )
	case FB_TK_POINT
		lexSkipToken( )
		function = cGfxPoint( funcexpr )

	end select

end function

