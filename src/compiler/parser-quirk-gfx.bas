'' quirk graphic statements and functions (SCREEN, PSET, LINE, ...) parsing
''
'' chng: dec/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

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

'' Check for cast() AS ANY PTR or compatible overloads, and call them, if any.
private function hMaybeUdt2Ptr( byval expr as ASTNODE ptr ) as ASTNODE ptr
	dim as FB_ERRMSG err_num = any
	dim as FBSYMBOL ptr castproc = any

	castproc = symbFindCastOvlProc( typeAddrOf( FB_DATATYPE_VOID ), NULL, expr, @err_num )
	if( castproc ) then
		'' cast() overload found, call it
		expr = astBuildCall( castproc, expr )
	else
		'' No cast() found

		'' An error was shown? (multiple/mismatching overloads)
		if( err_num <> FB_ERRMSG_OK ) then
			astDelTree( expr )
			expr = astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ) )
		end if
	end if

	function = expr
end function

private function hNidxArray2ArrayAccess( byval nidxarray as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr varexpr = any, idxexpr = any, dataOffset = any
	dim as FBSYMBOL ptr sym = any

	varexpr = nidxarray->l
	astDelNode( nidxarray )

	'' field? (assuming field arrays can't be dynamic)
	if( astIsFIELD( varexpr ) ) then
		'' No need to do anything; the tree is already accessing the
		'' array field's 1st element. (would be different if it was
		'' dynamic, because then this would just be the access to the
		'' array descriptor)
		return varexpr
	end if

	sym = varexpr->sym

	''  argument passed by descriptor?
	if( symbIsParamVarByDesc( sym ) ) then
		'' deref descriptor->data
		idxexpr = astNewDEREF( astNewVAR( sym, 0, FB_DATATYPE_INTEGER ), _
				FB_DATATYPE_INTEGER, NULL, symb.fbarray_data )

		'' descriptor->dimTB(0).lBound
		dataOffset = astNewDEREF( astNewVAR( sym, 0, FB_DATATYPE_INTEGER ), _
					FB_DATATYPE_INTEGER, NULL, _
					symb.fbarray_dimtb + symb.fbarraydim_lbound )

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
				symb.fbarray_data, FB_DATATYPE_INTEGER )

		'' descriptor->dimTB(0).lBound
		dataOffset = astNewVAR( symbGetArrayDescriptor( sym ), _
					symb.fbarray_dimtb + symb.fbarraydim_lbound, _
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
		assert( symbGetArrayDimensions( sym ) > 0 )
		idxexpr = astNewBOP( AST_OP_MUL, _
			astNewCONSTi( symbArrayLbound( sym, 0 ) ), _
			astNewCONSTi( symbCalcLen( astGetDataType( varexpr ), astGetSubType( varexpr ) ), _
					FB_DATATYPE_UINT ) )
	end if

	function = astNewIDX( varexpr, idxexpr  )
end function

private function hMaybeArrayAccess2Ptr _
	( _
		byval expr as ASTNODE ptr, _
		byval pdescexpr as ASTNODE ptr ptr _
	) as ASTNODE ptr

	select case( expr->class )
	'' Support array accesses as in QB: The image will be stored into the
	'' array starting at the given array element, not at the address stored
	'' in the given array element.
	case AST_NODECLASS_IDX
		if( pdescexpr ) then
			'' Simply access the array, will be passed BYDESC in rtlGfxGet()
			assert( symbIsArray( expr->sym ) )
			*pdescexpr = astNewVAR( expr->sym )
		end if
		expr = astNewADDROF( expr )

	'' Same for array fields
	case AST_NODECLASS_FIELD
		if( symbIsArray( expr->sym ) ) then
			if( pdescexpr ) then
				'' Need to duplicate the array field access so it can be passed BYDESC in rtlGfxGet().
				'' (a simple VAR on the array field symbol can't be done here, because it's
				'' not a standalone array on stack, but could be anywhere in memory)
				'' If the expression contains CALLs (side-effects) though, we mustn't duplicate it,
				'' and unfortunately astRemSideFx() only works for scalars, not entire arrays,
				'' so must show an error in that case...
				if( astHasSideFx( expr ) ) then
					errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
					astDelTree( expr )
					expr = astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ) )
				else
					*pdescexpr = astCloneTree( expr )
					expr = astNewADDROF( expr )
				end if
			else
				expr = astNewADDROF( expr )
			end if
		end if
	end select

	function = expr
end function

''
'' Various GFX quirk statements accept an "fb.IMAGE" source and/or destination
'' parameter. We accept the following expressions here:
''
''  - pointer or UDT (with matching cast()) expression: use pointer as-is
''
''  - array access (non-pointer type, and UDTs without matching cast()): use
''    array itself as image buffer, starting at given element (QB compatibility)
''
''  - NIDXARRAY: use array itself as image buffer, starting at the front,
''    regardless of array's dtype. (QB compatibility)
''
private function hCheckFbImageExpr _
	( _
		byval expr as ASTNODE ptr, _
		byval allow_const as integer, _
		byval pdescexpr as ASTNODE ptr ptr = NULL _
	) as ASTNODE ptr

	'' remove any casting if they won't do any conversion
	expr = astRemoveNoConvCAST( expr )

	if( astIsNIDXARRAY( expr ) ) then
		'' Support non-indexed arrays as in QB: Build an array access to
		'' the 1st element and turn into pointer, regardless of array's dtype.
		expr = hMaybeArrayAccess2Ptr( hNidxArray2ArrayAccess( expr ), pdescexpr )
	else
		'' UDT expression? Turn into pointer if it has a matching cast()
		'' (cannot check for FB.IMAGE directly because it's not a built-in type)
		if( typeGetDtAndPtrOnly( expr->dtype ) = FB_DATATYPE_STRUCT ) then
			expr = hMaybeUdt2Ptr( expr )
		end if

		'' Special handling for array accesses
		if( typeIsPtr( expr->dtype ) = FALSE ) then
			expr = hMaybeArrayAccess2Ptr( expr, pdescexpr )
		end if
	end if

	'' Ultimately it always has to be a pointer, that will be passed BYVAL
	'' to the BYREF AS ANY parameters
	if( typeIsPtr( expr->dtype ) = FALSE ) then
		'' UDT?
		if( typeGetDtAndPtrOnly( expr->dtype ) = FB_DATATYPE_STRUCT ) then
			'' Show a nicer error than "expected pointer"
			errReport( FB_ERRMSG_NOMATCHINGPROC, TRUE, _
				" """ & *symbGetName( expr->subtype ) & ".cast() as any ptr""" )
		else
			errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
		end if
		expr = astNewADDROF( expr )
	end if

	'' Disallow PUT'ting into a CONST object etc.
	if( allow_const = FALSE ) then
		if( typeIsConst( typeDeref( expr->dtype ) ) ) then
			errReport( FB_ERRMSG_CONSTANTCANTBECHANGED, TRUE )
		end if
	end if

	function = expr
end function

private function hFbImageExpr _
	( _
		byval allow_const as integer, _
		byval pdescexpr as ASTNODE ptr ptr = NULL _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any

	expr = cExpressionWithNIDXARRAY( TRUE )
	if( expr = NULL ) then
		exit function
	end if

	function = hCheckFbImageExpr( expr, allow_const, pdescexpr )
end function

'' [Expr ','] '('
private function hFbImageExprInFrontOfCoord( byval allow_const as integer ) as ASTNODE ptr
	dim as ASTNODE ptr expr = any

	'' '('? Assume it's the (x, y) coordinate syntax, instead of an FB.IMAGE
	'' expression in parentheses.
	if( lexGetToken( ) = CHAR_LPRNT ) then
		exit function
	end if

	expr = hFbImageExpr( allow_const )
	if( expr = NULL ) then
		exit function
	end if

	'' ','
	hMatchCOMMA( )

	function = expr
end function

'':::::WriteConsoleOutputAttribute
private function hGetMode _
	( _
		byref mode as integer, _
		byref alphaexpr as ASTNODE ptr, _
		byref funcexpr as ASTNODE ptr, _
		byref paramexpr as ASTNODE ptr _
	)  as integer

	dim as FBSYMBOL ptr s, arg1, arg2, arg3

	function = FALSE

	select case( lexGetToken( ) )
	case FB_TK_AND
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		mode = FBGFX_PUTMODE_AND
		return TRUE

	case FB_TK_OR
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		mode = FBGFX_PUTMODE_OR
		return TRUE

	case FB_TK_XOR
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		mode = FBGFX_PUTMODE_XOR
		return TRUE
	end select

	select case( lexGetClass( ) )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD, FB_TKCLASS_KEYWORD
		select case ucase( *lexGetText( ) )
		case "PSET"
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			mode = FBGFX_PUTMODE_PSET
			return TRUE

		case "PRESET"
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			mode = FBGFX_PUTMODE_PRESET
			return TRUE

		case "TRANS"
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			mode = FBGFX_PUTMODE_TRANS
			return TRUE

		case "ADD"
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			mode = FBGFX_PUTMODE_ADD
			if( hMatch( CHAR_COMMA ) ) then
				hMatchExpression( alphaexpr )
			else
				alphaexpr = astNewCONSTi( 255, FB_DATATYPE_UINT )
			end if
			return TRUE

		case "ALPHA"
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			mode = FBGFX_PUTMODE_ALPHA
			if( hMatch( CHAR_COMMA ) ) then
				hMatchExpression( alphaexpr )
				mode = FBGFX_PUTMODE_BLEND
			end if
			return TRUE

		case "CUSTOM"
			lexSkipToken( LEXCHECK_POST_SUFFIX )

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
			if( ( symbGetType( s ) <> FB_DATATYPE_ULONG ) or _
				( symbGetProcParams( s ) <> 3 ) ) then
				errReport( FB_ERRMSG_TYPEMISMATCH )
				exit function
			end if

			arg1 = symbGetProcHeadParam( s )

			arg2 = symbGetParamNext( arg1 )

			arg3 = symbGetParamNext( arg2 )

			if( symbGetProcMode( s ) = FB_FUNCMODE_PASCAL ) then
				swap arg1, arg3
			end if

			if( ( symbGetType( arg1 ) <> FB_DATATYPE_ULONG ) or _
				( symbGetType( arg2 ) <> FB_DATATYPE_ULONG ) or _
				( typeIsPtr( symbGetType( arg3 ) ) = FALSE ) or _
				( arg1->param.mode <> FB_PARAMMODE_BYVAL ) or _
				( arg2->param.mode <> FB_PARAMMODE_BYVAL ) or _
				( arg3->param.mode <> FB_PARAMMODE_BYVAL ) ) then
				errReport( FB_ERRMSG_TYPEMISMATCH )
				exit function
			end if

			return TRUE
		end select

	end select

	errReport( FB_ERRMSG_SYNTAXERROR )
	return FALSE
end function

'':::::
'' GfxPset     =   PSET ( Expr ',' )? STEP? '(' Expr ',' Expr ')' (',' Expr )?
''
function cGfxPset( byval ispreset as integer ) as integer
	dim as integer flags
	dim as ASTNODE ptr xexpr, yexpr, cexpr, texpr

	function = FALSE

	'' ( Expr ',' )?
	texpr = hFbImageExprInFrontOfCoord( FALSE )

	'' STEP?
	if( hMatch( FB_TK_STEP, LEXCHECK_POST_SUFFIX ) ) then
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

	function = rtlGfxPset( texpr, xexpr, yexpr, cexpr, flags, ispreset )
end function

'':::::
'' LINE ( Expr ',' )? STEP? ('(' Expr ',' Expr ')')? '-' STEP? '(' Expr ',' Expr ')' (',' Expr? (',' LIT_STRING? (',' Expr )?)?)?
''
function cGfxLine as integer
	dim as integer flags, linetype
	dim as ASTNODE ptr styleexpr, x1expr, y1expr, x2expr, y2expr, cexpr, texpr

	function = FALSE

	'' '-'?
	if( hMatch( CHAR_MINUS ) ) then
		flags = FBGFX_COORDTYPE_R
		x1expr = astNewCONSTf( 0, FB_DATATYPE_SINGLE )
		y1expr = astNewCONSTf( 0, FB_DATATYPE_SINGLE )
	else
		'' ( Expr ',' )?
		texpr = hFbImageExprInFrontOfCoord( FALSE )

		'' STEP?
		if( hMatch( FB_TK_STEP, LEXCHECK_POST_SUFFIX ) ) then
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
	if( hMatch( FB_TK_STEP, LEXCHECK_POST_SUFFIX ) ) then
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
				lexSkipToken( LEXCHECK_POST_SUFFIX )
				linetype = FBGFX_LINETYPE_B
			case "BF"
				lexSkipToken( LEXCHECK_POST_SUFFIX )
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

	function = rtlGfxLine( texpr, x1expr, y1expr, x2expr, y2expr, _
		cexpr, linetype, styleexpr, flags )
end function

'':::::
'' GfxCircle     =   CIRCLE ( Expr ',' )? STEP? '(' Expr ',' Expr ')' ',' Expr ((',' Expr? (',' Expr? (',' Expr? (',' Expr (',' Expr)? )? )?)?)?)?
''
function cGfxCircle as integer
	dim as integer flags, fillflag
	dim as ASTNODE ptr xexpr, yexpr, cexpr, radexpr, iniexpr, endexpr, aspexpr, texpr

	function = FALSE

	'' ( Expr ',' )?
	texpr = hFbImageExprInFrontOfCoord( FALSE )

	'' STEP?
	if( hMatch( FB_TK_STEP, LEXCHECK_POST_SUFFIX ) ) then
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
						lexSkipToken( LEXCHECK_POST_SUFFIX )
						fillflag = TRUE
					end if
				end if
			end if
		end if

	else
		cexpr = astNewCONSTi( 0, FB_DATATYPE_UINT )
		flags or= FBGFX_DEFAULT_COLOR_FLAG
	end if

	function = rtlGfxCircle( texpr, xexpr, yexpr, radexpr, cexpr, _
		aspexpr, iniexpr, endexpr, fillflag, flags )

end function

'':::::
'' GfxPaint   =   PAINT ( Expr ',' )? STEP? '(' expr ',' expr ')' (',' expr? (',' expr? ) )
''
function cGfxPaint as integer
	dim as ASTNODE ptr xexpr, yexpr, pexpr, bexpr, texpr
	dim as integer flags

	function = FALSE

	'' ( Expr ',' )?
	texpr = hFbImageExprInFrontOfCoord( FALSE )

	'' STEP?
	if( hMatch( FB_TK_STEP, LEXCHECK_POST_SUFFIX ) ) then
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

	function = rtlGfxPaint( texpr, xexpr, yexpr, pexpr, bexpr, flags )
end function

'':::::
'' GfxDrawString   =   DRAW STRING ( Expr ',' )? STEP? '(' Expr ',' Expr ')' ',' Expr ( ',' Expr ( ',' Expr ( ',' Expr ( ',' Expr )? )? )? )?
''
function cGfxDrawString as integer
	dim as ASTNODE ptr texpr, xexpr, yexpr, sexpr, cexpr, fexpr, alphaexpr, funcexpr, paramexpr
	dim as integer flags, mode

	function = FALSE

	'' ( Expr ',' )?
	texpr = hFbImageExprInFrontOfCoord( FALSE )

	'' STEP?
	if( hMatch( FB_TK_STEP, LEXCHECK_POST_SUFFIX ) ) then
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
			fexpr = hFbImageExpr( TRUE )

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

	function = rtlGfxDrawString( texpr, xexpr, yexpr, sexpr, cexpr, fexpr, _
		flags, mode, alphaexpr, funcexpr, paramexpr )
end function

''
'' GfxDraw    =    DRAW [Expression1 ','] Expression2
''
'' Expression1 = target FB.IMAGE expression, can be NIDXARRAY
'' Expression2 = string expression (no NIDXARRAYs allowed)
''
'' This is difficult to parse because it's difficult to detect whether we're
'' given two expressions or just one expression. Specifically because the 1st
'' expression has slightly different rules (allows NIDXARRAY) than the 2nd,
'' but only if there are 2 expressions. We'd need infinite look-ahead to check
'' for the ',' separating the 2 expressions...
''
'' Luckily allowing NIDXARRAY is the only difference, and it's a rather tiny
'' difference. We can always parse the 1st expression allowing NIDXARRAY.
'' Then if there's a 2nd one, parse that as normal expression, and all is well.
'' Otherwise if there's no 2nd one, the 1st expression wasn't allowed to have
'' NIDXARRAY, and we can check it with astIsNIDXARRAY().
''
function cGfxDraw as integer
	dim as ASTNODE ptr expr1, expr2

	function = FALSE

	'' DRAW STRING?
	if( hMatch( FB_TK_STRING, LEXCHECK_POST_SUFFIX ) ) then
		return cGfxDrawString( )
	end if

	'' Parse 1st expression, allowing NIDXARRAYs
	expr1 = cExpressionWithNIDXARRAY( TRUE )
	if( expr1 = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	'' ','? (have 2nd expression?)
	if( hMatch( CHAR_COMMA ) ) then
		'' 1st was the target image expression, process it as such
		expr1 = hCheckFbImageExpr( expr1, FALSE )

		'' Parse 2nd expression normally
		hMatchExpression( expr2 )
	else
		'' 1st was the string expression, disallow NIDXARRAYs
		if( astIsNIDXARRAY( expr1 ) ) then
			errReport( FB_ERRMSG_EXPECTEDINDEX, TRUE )
			exit function
		end if
		expr2 = expr1
		expr1 = NULL
	end if

	function = rtlGfxDraw( expr1, expr2 )
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
		lexSkipToken( LEXCHECK_POST_SUFFIX )
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
	dim as integer isget, dptrsize

	function = FALSE

	isget = hMatchIdOrKw( "GET", LEXCHECK_POST_SUFFIX )

	'' this could fail if using was #undef'ed and made a method...
	if( hMatch( FB_TK_USING, LEXCHECK_POST_SUFFIX ) ) then
		arrayexpr = hFbImageExpr( not isget )
		if( arrayexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			exit function
		end if

		'' Choose either the 32 or 64-bit version

		assert( typeIsPtr( astGetDataType( arrayexpr ) ) )

		'' get the size of the data pointed to
		dptrsize = typeGetSize( typeDeref( astGetDataType( arrayexpr ) ) )

		if( dptrsize <> typeGetSize( FB_DATATYPE_LONG ) and dptrsize <> typeGetSize( FB_DATATYPE_LONGINT ) ) then
			dptrsize = typeGetSize( FB_DATATYPE_INTEGER )
		end if

		function = rtlGfxPaletteUsing( arrayexpr, isget, (dptrsize = typeGetSize( FB_DATATYPE_LONGINT )) )
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
	dim as integer coordtype, mode, expectmode
	dim as ASTNODE ptr xexpr, yexpr, arrayexpr, texpr, alphaexpr, _
		funcexpr, paramexpr, x1expr, y1expr, x2expr, y2expr
	dim as FBSYMBOL ptr arg1, arg2

	function = FALSE

	alphaexpr = NULL
	funcexpr = NULL
	paramexpr = NULL
	x1expr = NULL

	'' ( Expr ',' )?
	texpr = hFbImageExprInFrontOfCoord( FALSE )

	'' STEP?
	if( hMatch( FB_TK_STEP, LEXCHECK_POST_SUFFIX ) ) then
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

	arrayexpr = hFbImageExpr( TRUE )
	if( arrayexpr = NULL ) then
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
			if( hMatch( FB_TK_STEP, LEXCHECK_POST_SUFFIX ) ) then
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

	function = rtlGfxPut( texpr, xexpr, yexpr, arrayexpr, _
		x1expr, y1expr, x2expr, y2expr, _
		mode, alphaexpr, funcexpr, paramexpr, coordtype )
end function

'':::::
'' GfxGet   =   GET ( Expr ',' )? STEP? '(' Expr ',' Expr ')' '-' STEP? '(' Expr ',' Expr ')' ',' Variable
''
function cGfxGet as integer
	dim as integer coordtype
	dim as ASTNODE ptr x1expr, y1expr, x2expr, y2expr, arrayexpr, texpr, descexpr

	function = FALSE

	'' ( Expr ',' )?
	texpr = hFbImageExprInFrontOfCoord( TRUE )

	'' STEP?
	if( hMatch( FB_TK_STEP, LEXCHECK_POST_SUFFIX ) ) then
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
	if( hMatch( FB_TK_STEP, LEXCHECK_POST_SUFFIX ) ) then
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

	'' descexpr: If an array was given, we pass the descriptor to
	'' fb_GfxGet() so it can do extra bound checks
	arrayexpr = hFbImageExpr( FALSE, @descexpr )
	if( arrayexpr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

	function = rtlGfxGet( texpr, x1expr, y1expr, x2expr, y2expr, _
		arrayexpr, coordtype, descexpr )
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

		function = rtlGfxScreenSet( mexpr, dexpr, pexpr, fexpr, rexpr )

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
'' GfxPoint    =   POINT '(' Expr ( ',' ( Expr )? ( ',' Expr )? )? ')'
''
function cGfxPoint( byref funcexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr xexpr, yexpr, texpr

	function = FALSE

	hMatchLPRNT( )

	hMatchExpression( xexpr )

	yexpr = NULL
	texpr = NULL

	if( hMatch( CHAR_COMMA ) ) then
		hMatchExpression( yexpr )

		if( hMatch( CHAR_COMMA ) ) then
			texpr = hFbImageExpr( TRUE )
			if( texpr = NULL ) then
				errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
				exit function
			end if
		end if
	end if

	hMatchRPRNT( )

	funcexpr = rtlGfxPoint( texpr, xexpr, yexpr )

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

#macro CHECK_CODEMASK( )
	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
		exit function
	end if
#endmacro

'':::::
function cGfxStmt _
	( _
		byval tk as FB_TOKEN _
	) as integer

	function = FALSE

	select case as const tk
	case FB_TK_PSET
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxPSet( FALSE )

	case FB_TK_PRESET
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxPSet( TRUE )

	case FB_TK_LINE
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxLine( )

	case FB_TK_CIRCLE
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxCircle( )

	case FB_TK_PAINT
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxPaint( )

	case FB_TK_DRAW
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxDraw( )

	case FB_TK_VIEW
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxView( TRUE )

	case FB_TK_WINDOW
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxView( FALSE )

	case FB_TK_PALETTE
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxPalette( )

	case FB_TK_PUT
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxPut( )

	case FB_TK_GET
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxGet( )

	case FB_TK_SCREEN
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxScreen( FALSE )

	case FB_TK_SCREENQB
		CHECK_CODEMASK( )
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		function = cGfxScreen( TRUE )

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
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		cGfxPoint( expr )

	case FB_TK_IMAGECREATE
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		cGfxImageCreate( expr )

	end select

	function = expr

end function

