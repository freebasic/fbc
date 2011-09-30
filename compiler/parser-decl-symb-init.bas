'' symbol initializers
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "ir.bi"
#include once "symb.bi"

type FB_INITCTX
	sym			as FBSYMBOL ptr
	dim_ 		as FBVARDIM ptr
	dimcnt		as integer
	tree		as ASTNODE ptr
	options		as FB_INIOPT
	init_expr   as ASTNODE ptr
end type

declare function hUDTInit _
	( _
		byref ctx as FB_INITCTX _
	) as integer

'':::::
private function hDoAssign _
	( _
		byref ctx as FB_INITCTX, _
		byval expr as ASTNODE ptr, _
		byval no_fake as integer = FALSE _
	) as integer

    dim as ASTNODE lside = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	dtype = symbGetFullType( ctx.sym )
	subtype = symbGetSubtype( ctx.sym )

	if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
		dtype = typeDeref( dtype )
	end if

    astBuildVAR( @lside, NULL, 0, dtype, symbGetSubtype( ctx.sym ) )

    '' don't build a FIELD node if it's an UDTElm symbol,
    '' that doesn't matter with checkASSIGN
    if( astCheckASSIGN( @lside, expr ) = FALSE ) then

    	'' check if it's a cast
    	expr = astNewCONV( dtype, symbGetSubtype( ctx.sym ), expr )
    	if( expr = NULL ) then

			'' hand it back...
			if( no_fake ) then
				exit function
			end if

			if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
	        	return FALSE
	        else
	        	'' error recovery: create a fake expression
	        	astDelTree( expr )
	        	expr = astNewCONSTz( dtype )

	        end if
		end if
	end if

	''
	astTypeIniAddAssign( ctx.tree, expr, ctx.sym )

	function = TRUE

end function

'':::::
private function hElmInit _
	( _
		byref ctx as FB_INITCTX, _
		byval no_fake as integer = FALSE _
	) as integer

    dim as ASTNODE ptr expr = any
    dim as FBSYMBOL ptr oldsym = any
    dim as integer old_dtype = any

    function = FALSE

	'' set the context symbol to allow taking the address of overloaded
	'' procs and also to allow anonymous UDT's
	oldsym    = parser.ctxsym
	old_dtype = parser.ctx_dtype
	parser.ctxsym    = symbGetSubType( ctx.sym )
	parser.ctx_dtype = symbGetType( ctx.sym )

    '' parse expression
	expr = cExpression( )

	'' invalid expression
	if( expr = NULL ) then

		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until ',' and create a fake expression
			hSkipUntil( CHAR_COMMA )

            '' generate an expression matching the symbol's type
			dim as integer dtype = symbGetType( ctx.sym )
			dim as FBSYMBOL ptr subtype = symbGetSubtype( ctx.sym )
			if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
				dtype = typeDeref( dtype )
			end if
			expr = astNewCONSTz( dtype )

		end if
	end if

	'' to hand it back if necessary
	ctx.init_expr = expr

    '' restore context if needed
	parser.ctxsym    = oldsym
	parser.ctx_dtype = old_dtype

	function = hDoAssign( ctx, expr, no_fake )

end function

'':::::
private function hArrayInit _
	( _
		byref ctx as FB_INITCTX, _
		byval no_fake as integer = FALSE _
	) as integer

    dim as integer dimensions = any, elements = any, elm_cnt = any
    dim as integer isarray = any, dtype = any
    dim as FBVARDIM ptr old_dim = any
    dim as FBSYMBOL ptr subtype = any
	static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS - 1)

	function = FALSE

	dimensions = symbGetArrayDimensions( ctx.sym )
	old_dim = ctx.dim_

	'' '{'?
	isarray = FALSE
	if( lexGetToken( ) = CHAR_LBRACE ) then
		lexSkipToken( )

		ctx.dimcnt += 1

		'' open a scope only if it's the first dim -- used by the gcc emitter
		if( ctx.dimcnt = 1 ) then
			astTypeIniScopeBegin( ctx.tree, ctx.sym )
		end if

		'' too many dimensions?
		if( ctx.dimcnt > dimensions ) then
			if( errReport( iif( dimensions > 0, _
								FB_ERRMSG_TOOMANYEXPRESSIONS, _
								FB_ERRMSG_EXPECTEDARRAY ) ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next '}'
				hSkipUntil( CHAR_RBRACE, TRUE )
				ctx.dim_ = NULL
			end if

		else
			'' first dim?
			if( ctx.dim_ = NULL ) then
				ctx.dim_ = symbGetArrayFirstDim( ctx.sym )

			'' next..
			else
				ctx.dim_ = ctx.dim_->next
			end if

			isarray = TRUE
		end if

	else
		'' not the last dimension?
		if( ctx.dimcnt < dimensions ) then
			if( errReport( FB_ERRMSG_EXPECTEDLBRACKET ) = FALSE ) then
				exit function
			else
				ctx.dimcnt += 1
				if( ctx.dim_ = NULL ) then
					ctx.dim_ = symbGetArrayFirstDim( ctx.sym )
				else
					ctx.dim_ = ctx.dim_->next
				end if
			end if
		end if
	end if

	if( ctx.dim_ <> NULL ) then
		dTB(ctx.dimcnt - 1).lower = ctx.dim_->lower
		dTB(ctx.dimcnt - 1).upper = ctx.dim_->upper
		'' Ellipsis?
		if( ctx.dim_->upper = FB_ARRAYDIM_UNKNOWN ) then
			elements = -1
		else
			elements = (ctx.dim_->upper - ctx.dim_->lower) + 1
		end if
	else
		elements = 1
	end if

	''
	dtype = symbGetType( ctx.sym )
	subtype = symbGetSubtype( ctx.sym )
	if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
		dtype = typeDeref( dtype )
	end if

	'' for each array element..
	elm_cnt = 0
	do
		'' not the last dimension?
		if( ctx.dimcnt < dimensions ) then
			if( hArrayInit( ctx ) = FALSE ) then
				exit function
			end if

		else
			select case as const dtype
			case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
				if( hUDTInit( ctx ) = FALSE ) then
					exit function
				end if

			case else
				if( hElmInit( ctx, no_fake ) = FALSE ) then
					exit function
				end if
			end select
		end if

		elm_cnt += 1
		if( elements = -1 ) then
			'' ellipsis elements...
			if( lexGetToken( ) <> CHAR_COMMA ) then
				elements = elm_cnt
				ctx.dim_->upper = ctx.dim_->lower + elm_cnt - 1
				dTB(ctx.dimcnt - 1).upper = ctx.dim_->upper
				symbSetArrayDimTb( ctx.sym, dimensions, dTB() )
				exit do
			end if
		else
			if( elm_cnt >= elements ) then
				exit do
			end if
		end if


		'' ','
		if( hMatch( CHAR_COMMA ) = FALSE ) then
			exit do
		end if

        astTypeIniSeparator( ctx.tree, ctx.sym )
	loop

	'' pad
	elements -= elm_cnt
	if( elements > 0 ) then
		'' not the last dimension?
		if( ctx.dim_->next ) then
			elements *= symbCalcArrayElements( ctx.sym, ctx.dim_->next )
		end if

		dim as FBSYMBOL ptr ctor = NULL
		if( (ctx.options and FB_INIOPT_ISOBJ) <> 0 ) then
			ctor = symbGetCompDefCtor( subtype )
			if( ctor = NULL ) then
				errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )
			else
    			'' check visibility
	    		if( symbCheckAccess( subtype, ctor ) = FALSE ) then
					errReport( FB_ERRMSG_NOACCESSTODEFAULTCTOR )
				end if
			end if
		end if

		if( ctor <> NULL ) then
			astTypeIniAddCtorList( ctx.tree, ctx.sym, elements )
		else
			dim as integer pad_lgt = any
			'' calc len.. handle fixed-len strings
			select case as const dtype
			case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				pad_lgt = symbGetLen( ctx.sym )
			case else
				pad_lgt = symbCalcLen( dtype, subtype )
			end select

			pad_lgt *= elements

			astTypeIniAddPad( ctx.tree, pad_lgt )
			astTypeIniGetOfs( ctx.tree ) += pad_lgt
		end if

	end if

	if( isarray ) then

		'' close the scope only if it's the first dim -- used by the gcc emitter
		if( ctx.dimcnt = 1 ) then
			astTypeIniScopeEnd( ctx.tree, ctx.sym )
		end if

		'' '}'
		if( lexGetToken( ) <> CHAR_RBRACE ) then
			if( errReport( FB_ERRMSG_EXPECTEDRBRACKET ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next '}'
				hSkipUntil( CHAR_RBRACE, TRUE )
			end if

		else
			lexSkipToken( )
		end if

		ctx.dim_ = old_dim
		ctx.dimcnt -= 1
	end if

	function = TRUE

end function

'':::::
private function hUDTInit _
	( _
		byref ctx as FB_INITCTX _
	) as integer

	static as integer rec_cnt

	dim as integer elements = any, elm_cnt = any, elm_ofs = any
	dim as integer lgt = any, baseofs = any, pad_lgt = any, dtype = any
    dim as FBSYMBOL ptr elm = any, subtype = any
    dim as FB_INITCTX old_ctx = any

    function = FALSE

    rec_cnt += 1

    '' ctor?
    if( (ctx.options and FB_INIOPT_ISOBJ) <> 0 ) then
    	dim as ASTNODE ptr expr = any

	    '' Expression
	    expr = cExpression( )
	    if( expr = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				rec_cnt -= 1
				exit function
			else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
	    end if

		'' array passed by descriptor?
		dim as FB_PARAMMODE arg_mode = INVALID
		if( lexGetToken( ) = CHAR_LPRNT ) then
			if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then
				if( astGetSymbol( expr ) <> NULL ) then
					if( symbIsArray( astGetSymbol( expr ) ) ) then
						lexSkipToken( )
						lexSkipToken( )
						arg_mode = FB_PARAMMODE_BYDESC
					end if
				end if
			end if
    	end if

    	dim as integer is_ctorcall = any
    	expr = astBuildImplicitCtorCallEx( ctx.sym, expr, arg_mode, is_ctorcall )
        if( expr = NULL ) then
        	rec_cnt -= 1
        	exit function
        end if

    	if( is_ctorcall ) then
    		rec_cnt -= 1
    		return astTypeIniAddCtorCall( ctx.tree, ctx.sym, expr ) <> NULL
    	else
    		'' try to assign it (do a shallow copy)
    		rec_cnt -= 1
        	return hDoAssign( ctx, expr )
        end if
    end if

	dim as integer parenth = TRUE, comma = FALSE

	'' '('
	if( lexGetToken( ) <> CHAR_LPRNT ) then

		if( rec_cnt > 1 ) then
			'' get lookahead
			dim as integer lookie = lexGetLookAhead( 1 ), is_ok = TRUE

			'' if it's a comma, set to leave one for the parent func
			'' (see below)
			if( lookie = CHAR_COMMA ) then
				comma = TRUE
			end if

			parenth = FALSE
		else
			rec_cnt -= 1
			return hElmInit( ctx )
		end if

	else
		astTypeIniScopeBegin( ctx.tree, ctx.sym )
	end if

	if( parenth ) then
		lexSkipToken( )
	end if

	''
	dtype = symbGetType( ctx.sym )
	subtype = symbGetSubtype( ctx.sym )
	if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
		dtype = typeDeref( dtype )
	end if

	''
	elm = symbGetUDTFirstElm( subtype )
	elements = symbGetUDTElements( subtype )
	elm_cnt = 0

	lgt = 0
	baseofs = astTypeIniGetOfs( ctx.tree )

	'' save parent
	old_ctx = ctx

	''
	ctx.options and= not FB_INIOPT_DODEREF
	ctx.dim_ = NULL
	ctx.dimcnt = 0

	'' for each UDT element..
	elm_cnt = 1
	do
		if( elm_cnt > elements ) then
			if( errReport( FB_ERRMSG_TOOMANYEXPRESSIONS ) = FALSE ) then
				rec_cnt -= 1
				exit function
			else
				'' error recovery: jump out
				exit do
			end if
		end if

		elm_ofs = elm->ofs
		if( lgt > 0 ) then
			pad_lgt = elm_ofs - lgt
			if( pad_lgt > 0 ) then
				astTypeIniAddPad( ctx.tree, pad_lgt )
				lgt += pad_lgt
			end if
		end if

		astTypeIniGetOfs( ctx.tree ) = baseofs + elm_ofs

		if( symbCheckAccess( symbGetSubtype( elm ), _
							 elm ) = FALSE ) then

			errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
		end if
        ctx.sym = elm

		'' has ctor?
		ctx.options and= not FB_INIOPT_ISOBJ
		select case symbGetType( elm )
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			if( symbGetHasCtor( symbGetSubtype( elm ) ) ) then
				ctx.options or= FB_INIOPT_ISOBJ
			end if
		end select

		'' element assignment failed?
        if( hArrayInit( ctx, TRUE ) = FALSE ) then

        	'' must be first...
        	if( elm_cnt > 1 ) then
        		errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
        		rec_cnt -= 1
        		exit function
        	end if

    		'' nothing passed back...
    		if( ctx.init_expr = NULL ) then
    			errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
    			rec_cnt -= 1
    			exit function
    		end if

			'' try to assign the expression to the parent
	    	dim as integer is_ctorcall = any
			dim as FB_PARAMMODE arg_mode = INVALID
			dim as ASTNODE ptr expr = ctx.init_expr

			ctx = old_ctx

	    	expr = astBuildImplicitCtorCallEx( ctx.sym, expr, arg_mode, is_ctorcall )
	        if( expr = NULL ) then
	        	rec_cnt -= 1
	        	exit function
	        end if

			'' ')'
			if( parenth ) then
				if( lexGetToken( ) <> CHAR_RPRNT ) then
					if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
						rec_cnt -= 1
						exit function
					else
						'' error recovery: skip until next ')'
						hSkipUntil( CHAR_RPRNT, TRUE )
					end if
				end if
				lexSkipToken( )
			end if

	    	rec_cnt -= 1

	    	if( is_ctorcall ) then
	    		return astTypeIniAddCtorCall( ctx.tree, ctx.sym, expr ) <> NULL
	    	else
	    		'' try to assign it (do a shallow copy)
	        	return hDoAssign( ctx, expr )
	        end if

        end if

        lgt += symbGetLen( elm ) * symbGetArrayElements( elm )

		'' next
		elm = symbGetUDTNextElm( elm, TRUE, elm_cnt )

		'' if we're not top level,
		if( rec_cnt > 1 ) then

			'' if there's a comma at the end, we have to leave it for
			'' the parent UDT initializer, to signal that we completed
			'' initializing this UDT, and the next field should be assigned.
		    if( comma = TRUE ) then
		    	if( elm_cnt > elements ) then
		    		exit do
		    	end if
		    end if

		end if

		'' ','
		if( hMatch( CHAR_COMMA ) = FALSE ) then
			exit do
		end if

        astTypeIniSeparator( ctx.tree, ctx.sym )
	loop

	'' ')'
	if( parenth ) then
		if( lexGetToken( ) <> CHAR_RPRNT ) then
			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
				rec_cnt -= 1
				ctx = old_ctx
				exit function
			else
				'' error recovery: skip until next ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
			end if
		else
			lexSkipToken( )
			astTypeIniScopeEnd( ctx.tree, ctx.sym )
		end if
	end if

	'' restore parent
	ctx = old_ctx

	''
	dim as integer sym_len = symbCalcLen( dtype, subtype )

	'' pad
	pad_lgt = sym_len - lgt
	if( pad_lgt > 0 ) then
		astTypeIniAddPad( ctx.tree, pad_lgt )
	end if

	astTypeIniGetOfs( ctx.tree ) = baseofs + sym_len

	rec_cnt -= 1

	function = TRUE

end function

'':::::
function cInitializer _
	( _
		byval sym as FBSYMBOL ptr, _
		byval options as FB_INIOPT _
	) as ASTNODE ptr

    dim as integer is_local = any, dtype = any
    dim as FBSYMBOL ptr subtype = any
    dim as FB_INITCTX ctx = any

	function = NULL

	if( symbIsVar( sym ) ) then
		'' cannot initialize dynamic vars
		if( symbGetIsDynamic( sym ) ) then
			errReport( FB_ERRMSG_CANTINITDYNAMICARRAYS, TRUE )
			exit function
		end if

		'' common?? impossible but..
		if( symbIsCommon( sym ) ) then
			errReport( FB_ERRMSG_CANTINITDYNAMICARRAYS, TRUE )
			exit function
		end if

		is_local = symbIsLocal( sym )

	'' param, struct/class field or anon-udt
	else
		is_local = FALSE
	end if

	dtype = symbGetType( sym )
	subtype = symbGetSubtype( sym )
	if( (options and FB_INIOPT_DODEREF) <> 0 ) then
		dtype = typeDeref( dtype )
	end if

	''
	ctx.options = options
	ctx.sym = sym
	ctx.dim_ = NULL
	ctx.dimcnt = 0
	ctx.init_expr = NULL

	ctx.tree = astTypeIniBegin( symbGetFullType( sym ), subtype, is_local, symbGetOfs( sym ) )

	'' has ctor?
	select case as const dtype
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		if( symbGetHasCtor( subtype ) ) then
			ctx.options or= FB_INIOPT_ISOBJ
		end if
	end select

	dim as integer res = hArrayInit( ctx )

	astTypeIniEnd( ctx.tree, (options and FB_INIOPT_ISINI) <> 0 )

	''
	if( symbIsVar( ctx.sym ) ) then
		symbSetIsInitialized( ctx.sym )
	end if

	''
	function = iif( res, ctx.tree, NULL )

end function


