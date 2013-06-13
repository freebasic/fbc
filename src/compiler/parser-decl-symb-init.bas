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

	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	dtype = symbGetFullType( ctx.sym )
	subtype = symbGetSubtype( ctx.sym )

	if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
		dtype = typeDeref( dtype )
	end if

	if( astCheckASSIGNToType( dtype, subtype, expr ) = FALSE ) then
		'' check if it's a cast
		expr = astNewCONV( dtype, subtype, expr )
		if( expr = NULL ) then
			'' hand it back...
			'' (used with UDTs; if an UDT var is given in an UDT initializer,
			'' but the assignment to the UDT's first field fails here,
			'' then it will be assigned to the UDT itself instead)
			if( no_fake ) then
				exit function
			end if

			errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			'' error recovery: create a fake expression
			astDelTree( expr )
			expr = astNewCONSTz( dtype, subtype )
		end if
	end if

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
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: skip until ',' and create a fake expression
		hSkipUntil( CHAR_COMMA )

		'' generate an expression matching the symbol's type
		dim as integer dtype = symbGetType( ctx.sym )
		if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
			dtype = typeDeref( dtype )
		end if
		expr = astNewCONSTz( dtype, symbGetSubtype( ctx.sym ) )
	end if

	'' to hand it back if necessary
	ctx.init_expr = expr

    '' restore context if needed
	parser.ctxsym    = oldsym
	parser.ctx_dtype = old_dtype

	function = hDoAssign( ctx, expr, no_fake )

end function

private function hArrayInit _
	( _
		byref ctx as FB_INITCTX, _
		byval no_fake as integer = FALSE _
	) as integer

    dim as integer dimensions = any, elm_cnt = any
	dim as longint elements = any
    dim as integer isarray = any, dtype = any
    dim as FBVARDIM ptr old_dim = any
    dim as FBSYMBOL ptr subtype = any
	static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS - 1)

	function = FALSE

	'' We're accessing FBSYMBOL.var_.* fields below,
	'' so it must be a VAR or FIELD
	assert( symbIsVar( ctx.sym ) or symbIsField( ctx.sym ) )

	''
	'' Nested "{ a, b, c }" array initializer parser
	''
	'' For arrays with well-known boundaries only matching initializers
	'' are allowed:
	''
	''    array(0 to 3)          =  { 1, 1, 1, 1 }
	''    array(0 to 1, 0 to 1)  =  { { 1, 1 }, { 2, 2 } }
	''    array(1 to 3, 0 to 1)  =  { { 1, 1 }, { 2, 2 }, { 3, 3 } }
	''
	'' For arrays declared using "..." ellipsis as the upper bound of
	'' some dimension(s), the array initializer determines the upper bound,
	'' and the array symbol is updated accordingly:
	''
	''    array(0 to ...)  =  { 1, 1 }        = array(0 to 1)
	''    array(5 to ...)  =  { 1, 1, 1, 1 }  = array(5 to 8)
	''
	''    array(0 to ..., 0 to 0)    =  { { 1 }, { 2 }, { 3 } }  =
	''    array(0 to 2, 0 to 0)
	''
	''    array(0 to ..., 0 to ...)  =  { { 1, 1 } ......        =
	''    array(0 to ..., 0 to 1)    =  { { 1, 1 }, { 2, 2 } }   =
	''    array(0 to 1, 0 to 1)
	''
	'' The parsing starts with the first (outer-most) dimension,
	'' and recursively descends into the next (inner) dimension.
	'' The first '}' seen is that of the first group of elements in the
	'' inner-most dimension, corresponding to the last dimension listed in
	'' the array declaration and the dTB(). Thus, the dimension's sizes are
	'' filled in "backwards" - inner-most first, outer-most last.
	''

	dimensions = symbGetArrayDimensions( ctx.sym )
	old_dim = ctx.dim_

	'' '{'?
	isarray = FALSE
	if( lexGetToken( ) = CHAR_LBRACE ) then
		lexSkipToken( )

		ctx.dimcnt += 1

		astTypeIniScopeBegin( ctx.tree, ctx.sym )

		'' too many dimensions?
		if( ctx.dimcnt > dimensions ) then
			errReport( iif( dimensions > 0, _
			                FB_ERRMSG_TOOMANYEXPRESSIONS, _
			                FB_ERRMSG_EXPECTEDARRAY ) )
			'' error recovery: skip until next '}'
			hSkipUntil( CHAR_RBRACE, TRUE )
			ctx.dim_ = NULL
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
			errReport( FB_ERRMSG_EXPECTEDLBRACKET )
			ctx.dimcnt += 1
			if( ctx.dim_ = NULL ) then
				ctx.dim_ = symbGetArrayFirstDim( ctx.sym )
			else
				ctx.dim_ = ctx.dim_->next
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
				'' Fill in this dimension's upper bound
				elements = elm_cnt
				ctx.dim_->upper = ctx.dim_->lower + elm_cnt - 1
				dTB(ctx.dimcnt - 1).upper = ctx.dim_->upper

				'' "array too big" check
				'' Note: the dTB() was initialized by now by the recursive parsing,
				'' but there can still be ellipsis upper bounds if some of the other
				'' dimensions used them, because their respective initializers haven't
				'' been fully parsed yet, unless this is the outer-most dimension.
				if( symbCheckArraySize( dimensions, dTB(), ctx.sym->lgt, _
				                        ((ctx.sym->attrib and (FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC)) = 0), _
				                        (ctx.dimcnt > 1) ) = FALSE ) then
					errReport( FB_ERRMSG_ARRAYTOOBIG )
					'' error recovery: set this dimension to 1 element
					dTB(ctx.dimcnt - 1).lower = 0
					dTB(ctx.dimcnt - 1).upper = 0
				end if

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
	loop

	'' Any array elements not initialized by this '{...}'?
	'' Then default-initialize/zero them. With multi-dimensional arrays,
	'' this may happen "in the middle" of the array.
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
				if( symbCheckAccess( ctor ) = FALSE ) then
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
		astTypeIniScopeEnd( ctx.tree, ctx.sym )

		'' '}'
		if( lexGetToken( ) <> CHAR_RBRACE ) then
			errReport( FB_ERRMSG_EXPECTEDRBRACKET )
			'' error recovery: skip until next '}'
			hSkipUntil( CHAR_RBRACE, TRUE )
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

	dim as integer elm_cnt = any, dtype = any
	dim as longint lgt = any, baseofs = any, pad_lgt = any
	dim as FBSYMBOL ptr fld = any, first = any, subtype = any
	dim as FBSYMBOL ptr oldsubtype = any
	dim as integer olddtype = any
    dim as FB_INITCTX old_ctx = any

    function = FALSE

    rec_cnt += 1

	dtype = symbGetType( ctx.sym )
	subtype = symbGetSubtype( ctx.sym )
	if( (ctx.options and FB_INIOPT_DODEREF) <> 0 ) then
		dtype = typeDeref( dtype )
	end if

    '' ctor?
    if( (ctx.options and FB_INIOPT_ISOBJ) <> 0 ) then
    	dim as ASTNODE ptr expr = any

		'' Set the context data type, to allow anonymous type()'s to
		'' work for UDTs with constructors here
		oldsubtype = parser.ctxsym
		olddtype   = parser.ctx_dtype
		parser.ctx_dtype = dtype
		parser.ctxsym    = subtype

	    '' Expression
	    expr = cExpression( )

		'' Restore context data type
		parser.ctx_dtype = olddtype
		parser.ctxsym    = oldsubtype

	    if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0 )
	    end if

		'' When initializing a BYREF parameter, an expression of the
		'' same type should be used as-is instead of causing a copy
		'' constructor call + temp var to be used, because that would
		'' destroy the BYREF semantics. For any other expression it's
		'' ok to cause implicit constructor calls though, because it
		'' couldn't be passed BYREF anyways.
		if( symbGetClass( ctx.sym ) = FB_SYMBCLASS_PARAM ) then
			if( symbGetParamMode( ctx.sym ) = FB_PARAMMODE_BYREF ) then
				if( (astGetDataType( expr ) = dtype) and _
				    (astGetSubtype( expr ) = subtype) ) then
					rec_cnt -= 1
					return hDoAssign( ctx, expr )
				end if
			end if
		end if

		dim as integer is_ctorcall = any
		expr = astBuildImplicitCtorCallEx( ctx.sym, expr, cBydescArrayArgParens( expr ), is_ctorcall )
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
		if( rec_cnt <= 1 ) then
			rec_cnt -= 1
			return hElmInit( ctx )
		end if

		'' ','? Leave one for the parent func (see below)
		comma = (lexGetLookAhead(1) = CHAR_COMMA)
		parenth = FALSE
	else
		astTypeIniScopeBegin( ctx.tree, ctx.sym )
	end if

	if( parenth ) then
		lexSkipToken( )
	end if

	first = symbUdtGetFirstField( subtype )
	fld = first

	lgt = 0
	baseofs = astTypeIniGetOfs( ctx.tree )

	'' save parent
	old_ctx = ctx

	ctx.options and= not FB_INIOPT_DODEREF
	ctx.dim_ = NULL
	ctx.dimcnt = 0

	'' for each initializable UDT field...
	'' (for unions, only the first field can be initialized)
	do
		if( fld = NULL ) then
			errReport( FB_ERRMSG_TOOMANYEXPRESSIONS )
			'' error recovery: jump out
			exit do
		end if

		if( lgt > 0 ) then
			'' Padding between fields (due to structure layout)
			'' (this also clears uninited parts of unions)
			pad_lgt = fld->ofs - lgt
			if( pad_lgt > 0 ) then
				astTypeIniAddPad( ctx.tree, pad_lgt )
				lgt += pad_lgt
			end if
		end if

		astTypeIniGetOfs( ctx.tree ) = baseofs + fld->ofs

		if( symbCheckAccess( fld ) = FALSE ) then
			errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
		end if
		ctx.sym = fld

		'' has ctor?
		ctx.options and= not FB_INIOPT_ISOBJ
		if( symbHasCtor( fld ) ) then
			ctx.options or= FB_INIOPT_ISOBJ
		end if

		'' element assignment failed?
		if( hArrayInit( ctx, TRUE ) = FALSE ) then
			'' not first or nothing passed back?
			if( (fld <> first) or (ctx.init_expr = NULL) ) then
				errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
				rec_cnt -= 1
				exit function
			end if

			'' try to assign the expression to the parent
			dim as integer is_ctorcall = any
			dim as ASTNODE ptr expr = ctx.init_expr

			ctx = old_ctx

			expr = astBuildImplicitCtorCallEx( ctx.sym, expr, INVALID, is_ctorcall )
			if( expr = NULL ) then
				rec_cnt -= 1
				exit function
			end if

			'' ')'
			if( parenth ) then
				if( lexGetToken( ) <> CHAR_RPRNT ) then
					errReport( FB_ERRMSG_EXPECTEDRPRNT )
					'' error recovery: skip until next ')'
					hSkipUntil( CHAR_RPRNT, TRUE )
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

		lgt += symbGetLen( fld ) * symbGetArrayElements( fld )

		'' next
		fld = symbUdtGetNextInitableField( fld )

		'' if we're not top level,
		if( rec_cnt > 1 ) then
			'' if there's a comma at the end, we have to leave it for
			'' the parent UDT initializer, to signal that we completed
			'' initializing this UDT, and the next field should be assigned.
			if( comma ) then
				if( fld = NULL ) then
					exit do
				end if
			end if
		end if

		'' ','
		if( hMatch( CHAR_COMMA ) = FALSE ) then
			exit do
		end if
	loop

	'' ')'
	if( parenth ) then
		if( lexGetToken( ) <> CHAR_RPRNT ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		else
			lexSkipToken( )
			astTypeIniScopeEnd( ctx.tree, ctx.sym )
		end if
	end if

	'' restore parent
	ctx = old_ctx

	'' Padding at the end of the UDT -- this zeroes tail padding bytes,
	'' and also any uninited fields and/or uninited parts of unions.
	dim as integer sym_len = symbCalcLen( dtype, subtype )
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

	dim as integer is_local = any, dtype = any, ok = any
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
	if( typeHasCtor( dtype, subtype ) ) then
		ctx.options or= FB_INIOPT_ISOBJ
	end if

	'' If it can be an array, start with hArrayInit()
	if( symbIsVar( ctx.sym ) or symbIsField( ctx.sym ) ) then
		ok = hArrayInit( ctx )
	else
		'' Everything else (e.g. params)
		if( dtype = FB_DATATYPE_STRUCT ) then
			ok = hUDTInit( ctx )
		else
			ok = hElmInit( ctx )
		end if
	end if

	astTypeIniEnd( ctx.tree, (options and FB_INIOPT_ISINI) <> 0 )

	if( symbIsVar( ctx.sym ) ) then
		symbSetIsInitialized( ctx.sym )
	end if

	function = iif( ok, ctx.tree, NULL )
end function
