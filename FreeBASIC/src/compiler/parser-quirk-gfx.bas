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


'' quirk graphic statements and functions (SCREEN, PSET, LINE, ...) parsing
''
'' chng: dec/2004 written [v1ctor]


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

const FBGFX_DEFAULT_COLOR_FLAG     = &h80000000
const FBGFX_DEFAULT_AUX_COLOR_FLAG = &h40000000
const FBGFX_VIEW_SCREEN_FLAG       = &h00000001

'' match, not using a token, but a raw text value
'':::::
private function hMakeArrayIndex _
	( _
		byval sym as FBSYMBOL ptr, _
		byval varexpr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr idxexpr, dataOffset

    '' field? (assuming field arrays can't be dynamic)
    if( astIsFIELD( varexpr ) ) then
    	return varexpr
    end if

    ''  argument passed by descriptor?
    if( symbIsParamByDesc( sym ) ) then

		'' deref descriptor->data
		idxexpr = astNewDEREF( astNewVAR( sym, 0, FB_DATATYPE_INTEGER ), _
                               FB_DATATYPE_INTEGER, _
                               NULL, _
                               FB_ARRAYDESC_DATAOFFS )

		'' descriptor->dimTB(0).lBound
		dataOffset = astNewDEREF( astNewVAR( sym, 0, FB_DATATYPE_INTEGER ), _
                                  FB_DATATYPE_INTEGER, _
                                  NULL, _
                                  FB_ARRAYDESCLEN + FB_ARRAYDESC_LBOUNDOFS )

		'' lBound * elemLen
		dataOffset = astNewBOP( AST_OP_MUL, _
								dataOffset, _
								astNewCONSTi( symbGetLen( sym ), FB_DATATYPE_UINT ) )

		'' add above to data ptr
		idxexpr = astNewBOP( AST_OP_ADD, idxexpr, dataOffset )

		'' ...
		astNewLOAD( idxexpr, FB_DATATYPE_INTEGER )

		'' can't reuse varexpr
		astDelTree( varexpr )
		varexpr = astNewVAR( sym, 0, FB_DATATYPE_INTEGER )

    '' dynamic array? (this will handle common's too)
    elseif( symbGetIsDynamic( sym ) ) then
    	'' deref descriptor.data
		idxexpr = astNewVAR( symbGetArrayDescriptor( sym ), _
                             FB_ARRAYDESC_DATAOFFS, _
                             FB_DATATYPE_INTEGER )

		'' descriptor->dimTB(0).lBound
		dataOffset = astNewVAR( symbGetArrayDescriptor( sym ), _
                                FB_ARRAYDESCLEN + FB_ARRAYDESC_LBOUNDOFS, _
                                FB_DATATYPE_INTEGER )

		'' lBound * elemLen
		dataOffset = astNewBOP( AST_OP_MUL, _
								dataOffset, _
								astNewCONSTi( symbGetLen( sym ), FB_DATATYPE_UINT ) )

		'' add above to data ptr
		idxexpr = astNewBOP( AST_OP_ADD, idxexpr, dataOffset )

		'' ...
		idxexpr = astNewLOAD( idxexpr, FB_DATATYPE_INTEGER )

    '' static array..
    else

      idxexpr = astNewBOP( AST_OP_MUL, _
                           astNewCONSTi( symbGetArrayFirstDim( sym )->lower, _
                           				 FB_DATATYPE_INTEGER ), _
                           astNewCONSTi( symbCalcLen( astGetDataType( varexpr ), _
                           				 astGetSubType( varexpr ) ), FB_DATATYPE_UINT ) )

    end if

    function = astNewIDX( varexpr, idxexpr, _
    					  astGetFullType( varexpr ), astGetSubType( varexpr ) )

end function

'':::::
private function hGetTarget _
	( _
		byref expr as ASTNODE ptr, _
		byref isptr as integer, _
		byval allow_const as integer = FALSE _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = any
	dim as integer nidx_array = FALSE

	function = NULL

	isptr = FALSE
	expr = NULL

	if( lexGetToken( ) = CHAR_LPRNT ) then
		exit function
	end if

    '' flag it as an expression so
    '' properties don't get confused
	expr = cVarOrDeref( FALSE, TRUE, TRUE )
	if( expr = NULL ) then
		exit function
	end if

	'' remove any casting if they won't do any conversion
	if( astIsCAST( expr ) ) then
		if( astGetCASTDoConv( expr ) = FALSE ) then
			dim as ASTNODE ptr l = astGetLeft( expr )
			astDelNode( expr )
			expr = l
		end if
	end if

	select case as const astGetClass( expr )
	'' ugly hack to deal with arrays w/o indexes
	case AST_NODECLASS_NIDXARRAY
		nidx_array = TRUE
		dim as ASTNODE ptr arrayexpr = astGetLeft( expr )
		astDelNode( expr )
		s = astGetSymbol( arrayexpr )
		expr = hMakeArrayIndex( s, arrayexpr )

	'' address-of or pointer deref?
	case AST_NODECLASS_ADDROF, AST_NODECLASS_OFFSET, _
		 AST_NODECLASS_DEREF, AST_NODECLASS_BOP

		isptr = TRUE
		s = NULL

	'' var, idx, ...
	case else
		s = astGetSymbol( expr )
		if( s = NULL ) then
			'' pointer?
			if( typeIsPtr( astGetDataType( expr ) ) ) then
				isptr = TRUE
				return NULL
			else
				exit function
			end if
		end if

		'' ptr?
		isptr = typeIsPtr( symbGetType( s ) )

		'' array?
		if( symbIsArray( s ) ) then
			'' no index given?
			if( astIsIDX( expr ) = FALSE ) then
				expr = hMakeArrayIndex( s, expr )
			end if

		'' not a ptr? fail..
		elseif( isptr = FALSE ) then
			exit function
		end if

	end select
	
	'' don't allow a pointer to a const...
	if( allow_const = FALSE ) then
		if( (typeGetConstMask( astGetFullType( expr ) ) and (1 shl (FB_DT_CONSTPOS + iif( nidx_array, 0, 1 )))) ) then
			errReport( FB_ERRMSG_CONSTANTCANTBECHANGED, TRUE )
			exit function
		end if
	end if
	
	function = s

end function

'':::::
private function hGetMode _
	( _
		byref mode as integer, _
		byref alphaexpr as ASTNODE ptr, _
		byref funcexpr as ASTNODE ptr, _
		byref paramexpr as ASTNODE ptr _
	)  as integer

    dim as FBSYMBOL ptr s, arg1, arg2, arg3

	function = FALSE

	select case as const lexGetToken

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
		select case ucase( *lexGetText( ) )
		case "PSET"
			lexSkipToken( )
			mode = FBGFX_PUTMODE_PSET

		case "PRESET"
			lexSkipToken( )
			mode = FBGFX_PUTMODE_PRESET

		case "TRANS"
			lexSkipToken( )
			mode = FBGFX_PUTMODE_TRANS

		case "ADD"
			lexSkipToken( )
			mode = FBGFX_PUTMODE_ADD

			if( hMatch( CHAR_COMMA ) ) then
				hMatchExpression( alphaexpr )
			else
				alphaexpr = astNewCONSTi( 255, FB_DATATYPE_UINT )
			end if

		case "ALPHA"
			lexSkipToken( )
			mode = FBGFX_PUTMODE_ALPHA

			if( hMatch( CHAR_COMMA ) ) then
				hMatchExpression( alphaexpr )
				mode = FBGFX_PUTMODE_BLEND
			end if

		case "CUSTOM"
			lexSkipToken( )

			mode = FBGFX_PUTMODE_CUSTOM

			hMatchCOMMA( )

			hMatchExpression( funcexpr )

			if( hMatch( CHAR_COMMA ) ) then
				hMatchExpression( paramexpr )
			end if

			s = astGetSubType( funcexpr )
			if( s = NULL ) then
				errReport( FB_ERRMSG_TYPEMISMATCH )
				exit function
			end if
				if( symbIsProc( s ) = FALSE ) then
				errReport( FB_ERRMSG_TYPEMISMATCH )
				exit function
			end if
			if( ( symbGetType( s ) <> FB_DATATYPE_UINT ) or _
				( symbGetProcParams( s ) <> 3 ) ) then
				errReport( FB_ERRMSG_TYPEMISMATCH )
				exit function
			end if

			arg1 = symbGetProcHeadParam( s )

			arg2 = symbGetParamNext( arg1 )

			arg3 = symbGetParamNext( arg2 )

			if( s->proc.mode = FB_FUNCMODE_PASCAL ) then
				swap arg1, arg3
			end if

			if( ( symbGetType( arg1 ) <> FB_DATATYPE_UINT ) or _
				( symbGetType( arg2 ) <> FB_DATATYPE_UINT ) or _
				( typeIsPtr( symbGetType( arg3 ) ) = FALSE ) or _
				( arg1->param.mode <> FB_PARAMMODE_BYVAL ) or _
				( arg2->param.mode <> FB_PARAMMODE_BYVAL ) or _
				( arg3->param.mode <> FB_PARAMMODE_BYVAL ) ) then
				errReport( FB_ERRMSG_TYPEMISMATCH )
				exit function
			end if

		case else
			errReport( FB_ERRMSG_SYNTAXERROR )
			exit function
		end select
	end select

	function = TRUE

end function

'':::::
'' GfxPset     =   PSET ( Expr ',' )? STEP? '(' Expr ',' Expr ')' (',' Expr )?
''
function cGfxPset( byval ispreset as integer ) as integer
    dim as integer flags, tisptr
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
		flags = FBGFX_COORDTYPE_R
	else
		flags = FBGFX_COORDTYPE_A
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
		cexpr = astNewCONSTi( 0, FB_DATATYPE_UINT )
		flags or= FBGFX_DEFAULT_COLOR_FLAG
	end if

	''
	function = rtlGfxPset( texpr, tisptr, xexpr, yexpr, cexpr, flags, ispreset )

end function

'':::::
'' LINE ( Expr ',' )? STEP? ('(' Expr ',' Expr ')')? '-' STEP? '(' Expr ',' Expr ')' (',' Expr? (',' LIT_STRING? (',' Expr )?)?)?
''
function cGfxLine as integer
    dim as integer flags, linetype, tisptr
    dim as ASTNODE ptr styleexpr, x1expr, y1expr, x2expr, y2expr, cexpr, texpr
    dim as FBSYMBOL ptr target

	function = FALSE

	'' '-'?
	if( hMatch( CHAR_MINUS ) ) then

		flags = FBGFX_COORDTYPE_R
		x1expr = astNewCONSTf( 0, FB_DATATYPE_SINGLE )
		y1expr = astNewCONSTf( 0, FB_DATATYPE_SINGLE )

	else

		'' ( Expr ',' )?
		target = hGetTarget( texpr, tisptr )
		if( (target <> NULL) or (tisptr) ) then
			hMatchCOMMA( )
		end if

		'' STEP?
		if( hMatch( FB_TK_STEP ) ) then
			flags = FBGFX_COORDTYPE_R
		else
			flags = FBGFX_COORDTYPE_A
		end if

		'' ('(' Expr ',' Expr ')')?
		if( hMatch( CHAR_LPRNT ) ) then

			hMatchExpression( x1expr )

			hMatchCOMMA( )

			hMatchExpression( y1expr )

			hMatchRPRNT( )

		else
			flags = FBGFX_COORDTYPE_R
			x1expr = astNewCONSTf( 0, FB_DATATYPE_SINGLE )
			y1expr = astNewCONSTf( 0, FB_DATATYPE_SINGLE )
		end if

		'' '-'
		if( hMatch( CHAR_MINUS ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDMINUS )
			exit function
		end if
	
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
		if( flags = FBGFX_COORDTYPE_R ) then
			flags = FBGFX_COORDTYPE_RR
		else
			flags = FBGFX_COORDTYPE_AR
		end if
	else
		if( flags = FBGFX_COORDTYPE_R ) then
			flags = FBGFX_COORDTYPE_RA
		else
			flags = FBGFX_COORDTYPE_AA
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
		cexpr = cExpression( )
		if( cexpr = NULL ) then
			cexpr = astNewCONSTi( 0, FB_DATATYPE_UINT )
			flags or= FBGFX_DEFAULT_COLOR_FLAG
		end if

		'' ',' LIT_STRING? - linetype
		if( hMatch( CHAR_COMMA ) ) then
			select case ucase( *lexGetText( ) )
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
		cexpr = astNewCONSTi( 0, FB_DATATYPE_UINT )
		flags or= FBGFX_DEFAULT_COLOR_FLAG
	end if

	''
	function = rtlGfxLine( texpr, tisptr, x1expr, y1expr, x2expr, y2expr, _
						   cexpr, linetype, styleexpr, flags )

end function

'':::::
'' GfxCircle     =   CIRCLE ( Expr ',' )? STEP? '(' Expr ',' Expr ')' ',' Expr ((',' Expr? (',' Expr? (',' Expr? (',' Expr (',' Expr)? )? )?)?)?)?
''
function cGfxCircle as integer
    dim as integer flags, fillflag, tisptr
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
		flags = FBGFX_COORDTYPE_R
	else
		flags = FBGFX_COORDTYPE_A
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
		cexpr = cExpression( )
		if( cexpr = NULL ) then
			cexpr = astNewCONSTi( 0, FB_DATATYPE_UINT )
			flags or= FBGFX_DEFAULT_COLOR_FLAG
		end if

        '' (',' Expr? )? - iniarc
        if( hMatch( CHAR_COMMA ) ) then
        	iniexpr = cExpression( )

        	'' (',' Expr? )? - endarc
        	if( hMatch( CHAR_COMMA ) ) then
        		endexpr = cExpression( )

            	'' (',' Expr )? - aspect
            	if( hMatch( CHAR_COMMA ) ) then
            		aspexpr = cExpression( )

            		'' (',' Expr )? - fillflag
            		if( hMatch( CHAR_COMMA ) ) then
            			if( ucase( *lexGetText( ) ) <> "F" ) then
							errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
							exit function
						end if
						lexSkipToken( )
						fillflag = TRUE
            		end if
            	end if
        	end if
        end if

	else
		cexpr = astNewCONSTi( 0, FB_DATATYPE_UINT )
		flags or= FBGFX_DEFAULT_COLOR_FLAG
	end if

	''
	function = rtlGfxCircle( texpr, tisptr, xexpr, yexpr, radexpr, cexpr, _
			  			     aspexpr, iniexpr, endexpr, fillflag, flags )

end function

'':::::
'' GfxPaint   =   PAINT ( Expr ',' )? STEP? '(' expr ',' expr ')' (',' expr? (',' expr? ) )
''
function cGfxPaint as integer
    dim as ASTNODE ptr xexpr, yexpr, pexpr, bexpr, texpr
	dim as integer flags, tisptr
    dim as FBSYMBOL ptr target

	function = FALSE

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( (target <> NULL) or (tisptr) ) then
		hMatchCOMMA( )
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
		flags = FBGFX_COORDTYPE_R
	else
		flags = FBGFX_COORDTYPE_A
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
		pexpr = cExpression( )

		'' background color
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpression( bexpr )
		end if
	end if

	if( pexpr = NULL ) then
		pexpr = astNewCONSTi( 0, FB_DATATYPE_UINT )
		flags or= FBGFX_DEFAULT_COLOR_FLAG
	end if

	if( bexpr = NULL ) then
		bexpr = astNewCONSTi( 0, FB_DATATYPE_UINT )
		flags or= FBGFX_DEFAULT_AUX_COLOR_FLAG
	end if

	function = rtlGfxPaint( texpr, tisptr, xexpr, yexpr, pexpr, bexpr, flags )

end function

'':::::
'' GfxDrawString   =   DRAW STRING ( Expr ',' )? STEP? '(' Expr ',' Expr ')' ',' Expr ( ',' Expr ( ',' Expr ( ',' Expr ( ',' Expr )? )? )? )?
''
function cGfxDrawString as integer
	dim as ASTNODE ptr texpr, xexpr, yexpr, sexpr, cexpr, fexpr, alphaexpr, funcexpr, paramexpr
	dim as integer tisptr, fisptr, flags, mode
    dim as FBSYMBOL ptr target

	function = FALSE

	texpr = NULL

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( (target <> NULL) or (tisptr) ) then
		hMatchCOMMA( )
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
		flags = FBGFX_COORDTYPE_R
	else
		flags = FBGFX_COORDTYPE_A
	end if

	'' '(' Expr ',' Expr ')' - x and y
	hMatchLPRNT( )

	hMatchExpression( xexpr )

	hMatchCOMMA( )

	hMatchExpression( yexpr )

	hMatchRPRNT( )

	'' ',' Expr
	hMatchCOMMA( )

	hMatchExpression( sexpr )

	cexpr = NULL
	fexpr = NULL
	alphaexpr = NULL
	funcexpr = NULL
	paramexpr = NULL
	mode = FBGFX_PUTMODE_TRANS

	'' color/font/mode
	if( hMatch( CHAR_COMMA ) ) then
		cexpr = cExpression( )

		'' custom user font
		if( hMatch( CHAR_COMMA ) ) then
			target = hGetTarget( fexpr, fisptr )

			'' mode
			if( hMatch( CHAR_COMMA ) ) then
				if( hGetMode( mode, alphaexpr, funcexpr, paramexpr ) = FALSE ) then
					exit function
				end if
			end if
		end if
	end if

	if( cexpr = NULL ) then
		cexpr = astNewCONSTi( 0, FB_DATATYPE_UINT )
		flags or= FBGFX_DEFAULT_COLOR_FLAG
	end if

	function = rtlGfxDrawString( texpr, tisptr, xexpr, yexpr, sexpr, cexpr, fexpr, fisptr, flags, mode, alphaexpr, funcexpr, paramexpr )

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
	if( hMatch( FB_TK_STRING ) ) then
		function = cGfxDrawString
		exit function
	else
		select case lexGetLookAhead( 1 )

        '' dot handling needed because of the
        '' "period in symbol" ambiguity -cha0s
        case CHAR_COMMA, CHAR_DOT
			target = hGetTarget( texpr, tisptr )
			if( (target = NULL) and (tisptr = FALSE) ) then
				errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if
			hMatch( CHAR_COMMA )
		end select
	end if

	hMatchExpression( cexpr )

	function = rtlGfxDraw( texpr, tisptr, cexpr )

end function

'':::::
'' GfxView    =   VIEW (SCREEN? '(' Expr ',' Expr ')' '-' '(' Expr ',' Expr ')' (',' Expr? (',' Expr)?)? )?
''
function cGfxView( byval isview as integer ) as integer
    dim as integer flags
    dim as ASTNODE ptr x1expr, y1expr, x2expr, y2expr, fillexpr, bordexpr

	function = FALSE

	'' SCREEN?
	select case lexGetToken() 
	case FB_TK_SCREEN, FB_TK_SCREENQB
		lexSkipToken
		flags = FBGFX_VIEW_SCREEN_FLAG
	case else
    	flags = 0
	end select

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
		if( hMatch( CHAR_MINUS ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDMINUS )
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
			flags or= ( FBGFX_DEFAULT_COLOR_FLAG or FBGFX_DEFAULT_AUX_COLOR_FLAG )
			if( hMatch( CHAR_COMMA ) ) then
				fillexpr = cExpression( )
				if( fillexpr <> NULL ) then
					flags and= not FBGFX_DEFAULT_COLOR_FLAG
				end if

        		'' (',' Expr? )? - border
        		if( hMatch( CHAR_COMMA ) ) then
					hMatchExpression( bordexpr )
					flags and= not FBGFX_DEFAULT_AUX_COLOR_FLAG
        		end if
        	end if
        end if

	end if

	''
	if( isview ) then
		function = rtlGfxView( x1expr, y1expr, x2expr, y2expr, fillexpr, bordexpr, flags )
	else
		function = rtlGfxWindow( x1expr, y1expr, x2expr, y2expr, flags )
	end if

end function

'':::::
'' GfxPalette   =   PALETTE GET? ((USING Variable) | (Expr ',' Expr (',' Expr ',' Expr)?)?)
''
function cGfxPalette as integer
    dim as ASTNODE ptr arrayexpr, attexpr, rexpr, gexpr, bexpr
    dim as FBSYMBOL ptr s
    dim as integer isget, isptr

	function = FALSE

	if( hMatchText( "GET" ) ) then
		isget = TRUE
	else
		isget = FALSE
	end if

    '' this could fail if using was #undef'ed and made a method...
	if( hMatch( FB_TK_USING ) ) then

		s = hGetTarget( arrayexpr, isptr, not isget )
		if( (s = NULL) and (isptr = FALSE) ) then
            errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
            exit function
        end if
		
        function = rtlGfxPaletteUsing( arrayexpr, isptr, isget )

	else

		attexpr = NULL
		rexpr = NULL
		gexpr = NULL
		bexpr = NULL

		attexpr = cExpression( )
		if( attexpr <> NULL ) then
			hMatchCOMMA( )

			if( isget ) then
				rexpr = cVarOrDeref( )
				if( rexpr = NULL ) then
		            errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		            exit function
		        end if
	        else
				hMatchExpression( rexpr )
    	    end if

			if( hMatch( CHAR_COMMA ) ) then
				if( isget ) then
					gexpr = cVarOrDeref( )
					if( gexpr = NULL ) then
			            errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			            exit function
			        end if
				else
					hMatchExpression( gexpr )
				end if

				hMatchCOMMA( )

				if( isget ) then
					bexpr = cVarOrDeref( )
					if( bexpr = NULL ) then
			            errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			            exit function
			        end if
				else
					hMatchExpression( bexpr )
				end if
			end if
		else
			if( isget ) then
				errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if
		end if
		
		dim as integer has_const = FALSE
		if( isget ) then
			has_const or= iif( rexpr, typeIsConst( astGetFullType( rexpr ) ), FALSE )
			has_const or= iif( gexpr, typeIsConst( astGetFullType( gexpr ) ), FALSE )
			has_const or= iif( bexpr, typeIsConst( astGetFullType( bexpr ) ), FALSE )
		end if
		
		if( has_const ) then
			errReport( FB_ERRMSG_CONSTANTCANTBECHANGED, TRUE )
		end if
		
		function = rtlGfxPalette( attexpr, rexpr, gexpr, bexpr, isget )

	end if

end function

'':::::
'' GfxPut   =   PUT ( Expr ',' )? STEP? '(' Expr ',' Expr ')' ',' ('(' Expr ',' Expr ')' '-' '(' Expr ',' Expr ')' ',')? Variable (',' Mode (',' Alpha)?)?
''
function cGfxPut as integer
    dim as integer coordtype, mode, isptr, tisptr, expectmode
    dim as ASTNODE ptr xexpr, yexpr, arrayexpr, texpr, alphaexpr, _
    				   funcexpr, paramexpr, x1expr, y1expr, x2expr, y2expr
    dim as FBSYMBOL ptr s, target, arg1, arg2

	function = FALSE

	alphaexpr = NULL
	funcexpr = NULL
	paramexpr = NULL
	x1expr = NULL

	'' ( Expr ',' )?
	target = hGetTarget( texpr, tisptr )
	if( (target <> NULL) or (tisptr) ) then
		hMatchCOMMA( )
	end if

	'' STEP?
	if( hMatch( FB_TK_STEP ) ) then
		coordtype = FBGFX_COORDTYPE_RA
	else
		coordtype = FBGFX_COORDTYPE_AA
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
	if( (s = NULL) and (isptr = FALSE) ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
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

			if( hMatch( CHAR_MINUS ) = FALSE ) then
				errReport FB_ERRMSG_EXPECTEDMINUS
				exit function
			end if

			'' STEP?
			if( hMatch( FB_TK_STEP ) ) then
				if( coordtype = FBGFX_COORDTYPE_RA ) then
					coordtype = FBGFX_COORDTYPE_RR
				else
					coordtype = FBGFX_COORDTYPE_AR
				end if
			end if

			hMatchLPRNT( )
			hMatchExpression( x2expr )
			hMatchCOMMA( )
			hMatchExpression( y2expr )
			hMatchRPRNT( )

			if( hMatch( CHAR_COMMA ) = FALSE ) then
				expectmode = FALSE
			end if
		end if

		if( expectmode ) then
			if( hGetMode( mode, alphaexpr, funcexpr, paramexpr ) = FALSE ) then
				exit function
			end if
		end if
	end if

	''
	function = rtlGfxPut( texpr, tisptr, xexpr, yexpr, arrayexpr, isptr, _
						  x1expr, y1expr, x2expr, y2expr, _
						  mode, alphaexpr, funcexpr, paramexpr, coordtype )

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
	if( hMatch( CHAR_MINUS ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDMINUS )
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
	if( (s = NULL) and (isptr = FALSE) ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

    ''
	function = rtlGfxGet( texpr, tisptr, x1expr, y1expr, x2expr, y2expr, _
						  arrayexpr, isptr, s, coordtype )

end function

'':::::
'' GfxScreen     =   SCREEN (num | ((expr (((',' expr)? ',' expr)? expr)? ',' expr))
''
function cGfxScreen( byval isqb as integer ) as integer

	function = FALSE

	if( isqb = FALSE ) then
		'' Expr?
		dim as ASTNODE ptr mexpr = cExpression( )

		'' (',' Expr )?
		dim as ASTNODE ptr dexpr = NULL
		if( hMatch( CHAR_COMMA ) ) then
			dexpr = cExpression( )
		end if

		'' (',' Expr )?
		dim as ASTNODE ptr pexpr = NULL
		if( hMatch( CHAR_COMMA ) ) then
			pexpr = cExpression( )
		end if

		'' page set?
		if( mexpr = NULL ) then
			return rtlPageSet( dexpr, pexpr, FALSE ) <> NULL
		end if

		'' (',' Expr )?
		dim as ASTNODE ptr fexpr = NULL
		if( hMatch( CHAR_COMMA ) ) then
			fexpr = cExpression( )
		end if

		'' (',' Expr )?
		dim as ASTNODE ptr rexpr = NULL
		if( hMatch( CHAR_COMMA ) ) then
			rexpr = cExpression( )
		end if

		function = rtlGfxScreenSet( mexpr, NULL, dexpr, pexpr, fexpr, rexpr )

	else
		'' mode?
		dim as ASTNODE ptr mode = cExpression( )

		'' (',' colorswitch )?
		if( hMatch( CHAR_COMMA ) ) then
			dim as ASTNODE ptr cswitch = cExpression( )
			if( cswitch <> NULL ) then
				'' unused
				astDelTree( cswitch )
			end if
		end if

		'' (',' active )?
		dim as ASTNODE ptr active = NULL
		if( hMatch( CHAR_COMMA ) ) then
			active = cExpression( )
		end if

		'' (',' visible )?
		dim as ASTNODE ptr visible = NULL
		if( hMatch( CHAR_COMMA ) ) then
			visible = cExpression( )
		end if

		if( mode = NULL ) then
			function = rtlPageSet( active, visible, FALSE ) <> NULL
		else
			function = rtlGfxScreenSetQB( mode, active, visible )
		end if
	end if

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
		dexpr = cExpression( )
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		pexpr = cExpression( )
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		fexpr = cExpression( )
	end if

	'' (',' Expr )?
	if( hMatch( CHAR_COMMA ) ) then
		rexpr = cExpression( )
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
			if( (target = NULL) and (tisptr = FALSE) ) then
				errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if
		end if
	end if

	hMatchRPRNT( )

	funcexpr = rtlGfxPoint( texpr, tisptr, xexpr, yexpr )

	function = funcexpr <> NULL

end function

'':::::
'' GfxImageCreate    =   IMAGECREATE '(' Expr ',' Expr ( ',' ( Expr )? ( ',' Expr )? )? ')'
''
function cGfxImageCreate( byref funcexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr wexpr, hexpr, cexpr, dexpr
	dim as integer flags

	function = FALSE

	hMatchLPRNT( )

	hMatchExpression( wexpr )

	hMatchCOMMA( )

	hMatchExpression( hexpr )

	cexpr = NULL
	dexpr = NULL
	flags = FBGFX_DEFAULT_COLOR_FLAG

	if( hMatch( CHAR_COMMA ) ) then
		cexpr = cExpression( )
		if( cexpr <> NULL ) then
			flags = 0
		end if
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpression( dexpr )
		end if
	end if

	hMatchRPRNT( )

	funcexpr = rtlGfxImageCreate( wexpr, hexpr, cexpr, dexpr, flags )

	function = funcexpr <> NULL

end function

#define CHECK_CODEMASK( ) 												_
    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then		:_
    	exit function													:_
    end if

'':::::
function cGfxStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

	function = FALSE

	select case as const tk
	case FB_TK_PSET
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxPSet( FALSE )

	case FB_TK_PRESET
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxPSet( TRUE )

	case FB_TK_LINE
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxLine( )

	case FB_TK_CIRCLE
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxCircle( )

	case FB_TK_PAINT
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxPaint( )

	case FB_TK_DRAW
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxDraw( )

	case FB_TK_VIEW
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxView( TRUE )

	case FB_TK_WINDOW
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxView( FALSE )

	case FB_TK_PALETTE
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxPalette( )

	case FB_TK_PUT
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxPut( )

	case FB_TK_GET
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxGet( )

	case FB_TK_SCREEN
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxScreen( FALSE )

	case FB_TK_SCREENQB
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxScreen( TRUE )

	case FB_TK_SCREENRES
		CHECK_CODEMASK( )
		lexSkipToken( )
		function = cGfxScreenRes( )

	end select

end function

'':::::
function cGfxFunct _
	( _
		byval tk as FB_TOKEN _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = NULL

	select case tk
	case FB_TK_POINT
		lexSkipToken( )
		cGfxPoint( expr )

	case FB_TK_IMAGECREATE
		lexSkipToken( )
		cGfxImageCreate( expr )

	end select

	function = expr

end function

