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
	dtype			as integer
	subtype			as FBSYMBOL ptr
	dimension 		as integer
	tree		as ASTNODE ptr
	options		as FB_INIOPT
	init_expr   as ASTNODE ptr
end type

declare function hUDTInit _
	( _
		byref ctx as FB_INITCTX _
	) as integer

private sub hUpdateContextDtype _
	( _
		byref ctx as FB_INITCTX, _
		byval dtype as integer = FB_DATATYPE_INVALID, _
		byval subtype as FBSYMBOL ptr = NULL _
	)

	if( dtype = FB_DATATYPE_INVALID ) then
		ctx.dtype = symbGetFullType( ctx.sym )
		ctx.subtype = symbGetSubtype( ctx.sym )
	else
		ctx.dtype = dtype
		ctx.subtype = subtype
	end if

end sub

private function hDoAssign _
	( _
		byref ctx as FB_INITCTX, _
		byval expr as ASTNODE ptr, _
		byval no_fake as integer = FALSE _
	) as integer

	if( astCheckASSIGNToType( ctx.dtype, ctx.subtype, expr ) = FALSE ) then
		'' check if it's a cast
		expr = astNewCONV( ctx.dtype, ctx.subtype, expr )
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
			expr = astNewCONSTz( ctx.dtype, ctx.subtype )
		end if
	end if

	astTypeIniAddAssign( ctx.tree, expr, ctx.sym, ctx.dtype, ctx.subtype )

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
		expr = astNewCONSTz( ctx.dtype, ctx.subtype )
	end if

	'' to hand it back if necessary
	ctx.init_expr = expr

    '' restore context if needed
	parser.ctxsym    = oldsym
	parser.ctx_dtype = old_dtype

	function = hDoAssign( ctx, expr, no_fake )

end function

'' Parse variable initializer: may be an array, or not.
private function hArrayInit _
	( _
		byref ctx as FB_INITCTX, _
		byval no_fake as integer = FALSE _
	) as integer

	dim as integer elm_cnt = any
	dim as longint elements = any
	dim as integer isarray = any

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
	'' the array declaration. Thus, the dimension's sizes are filled in
	'' "backwards" - inner-most first, outer-most last.
	''

	'' '{'?
	isarray = FALSE
	if( lexGetToken( ) = CHAR_LBRACE ) then
		lexSkipToken( )

		ctx.dimension += 1
		isarray = TRUE

		'' too many dimensions?
		if( ctx.dimension >= symbGetArrayDimensions( ctx.sym ) ) then
			errReport( iif( symbGetArrayDimensions( ctx.sym ) > 0, _
			                FB_ERRMSG_TOOMANYEXPRESSIONS, _
			                FB_ERRMSG_EXPECTEDARRAY ) )
			'' error recovery: skip until next '}'
			hSkipUntil( CHAR_RBRACE, TRUE )
			ctx.dimension -= 1
			exit function
		end if
	else
		'' not the last dimension?
		'' Initializing a non-array variable is ok even without {}'s,
		'' but for arrays the {}'s are required.
		if( ctx.dimension < (symbGetArrayDimensions( ctx.sym ) - 1) ) then
			errReport( FB_ERRMSG_EXPECTEDLBRACE )
			ctx.dimension += 1
			isarray = TRUE
		end if
	end if

	if( isarray ) then
		astTypeIniScopeBegin( ctx.tree, ctx.sym, TRUE )
	end if

	'' Determine the expected number of initializer elements
	if( ctx.dimension >= 0 ) then
		assert( ctx.dimension < symbGetArrayDimensions( ctx.sym ) )
		'' Ellipsis at this dimension?
		if( symbArrayUbound( ctx.sym, ctx.dimension ) = FB_ARRAYDIM_UNKNOWN ) then
			elements = -1
		else
			elements = symbArrayUbound( ctx.sym, ctx.dimension ) - symbArrayLbound( ctx.sym, ctx.dimension ) + 1
		end if
	else
		elements = 1
	end if

	'' For each initializer element...
	elm_cnt = 0
	do
		'' not the last dimension?
		if( ctx.dimension < (symbGetArrayDimensions( ctx.sym ) - 1) ) then
			if( hArrayInit( ctx ) = FALSE ) then
				exit function
			end if
		else
			if( typeGetDtAndPtrOnly( ctx.dtype ) = FB_DATATYPE_STRUCT ) then
				if( hUDTInit( ctx ) = FALSE ) then
					exit function
				end if
			else
				if( hElmInit( ctx, no_fake ) = FALSE ) then
					exit function
				end if
			end if
		end if

		'' Stop parsing elements if the expected number was reached,
		'' unless it's an ellipsis array dimension, for which we need
		'' to keep parsing all available elements to determine how
		'' big the dimension should be.
		elm_cnt += 1
		if( (elm_cnt >= elements) and (elements <> -1) ) then
			exit do
		end if

		'' ','?
	loop while( hMatch( CHAR_COMMA ) )

	'' Finished parsing initializer for ellipsis array dimension?
	if( elements = -1 ) then
		'' Update the array symbol with the new info about this dimension's upper bound
		elements = elm_cnt
		symbSetFixedSizeArrayDimensionElements( ctx.sym, ctx.dimension, elements )
		symbMaybeAddArrayDesc( ctx.sym )

		'' "array too big" check
		'' Note: If currently parsing an inner dimension, then there can still be
		'' outer dimensions with ellipsis upper bounds because the outer bounds'
		'' initializers haven't been fully parsed yet. But it's ok because
		'' symbCheckArraySize() handles this special case. (The check will be incomplete,
		'' but ultimately
		if( symbCheckArraySize( symbGetArrayDimensions( ctx.sym ), @symbGetArrayDim( ctx.sym, 0 ), ctx.sym->lgt, _
					((ctx.sym->attrib and (FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC)) = 0) ) = FALSE ) then
			errReport( FB_ERRMSG_ARRAYTOOBIG )
			'' error recovery: set this dimension to 1 element
			symbSetFixedSizeArrayDimensionElements( ctx.sym, ctx.dimension, 1 )
		end if
	end if

	'' Not all elements initialized in this dimension?
	'' Then default-initialize/zero them. With multi-dimensional arrays,
	'' this may happen "in the middle" of the array.
	elements -= elm_cnt
	if( elements > 0 ) then
		'' Add elements for remaining uninitialized dimensions, if any
		elements *= symbCalcArrayElements( ctx.sym, ctx.dimension + 1 )

		dim as FBSYMBOL ptr ctor = NULL
		if( (ctx.options and FB_INIOPT_ISOBJ) <> 0 ) then
			ctor = symbGetCompDefCtor( ctx.subtype )
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
			astTypeIniAddCtorList( ctx.tree, ctx.sym, elements, ctx.dtype, ctx.subtype )
		else
			dim as longint pad_lgt = any
			if( symbIsRef( ctx.sym ) ) then
				pad_lgt = env.pointersize
			else
				select case as const( typeGetDtAndPtrOnly( ctx.dtype ) )
				case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
					'' Fixed-length strings
					pad_lgt = symbGetLen( ctx.sym )
				case else
					pad_lgt = symbCalcLen( ctx.dtype, ctx.subtype )
				end select
			end if
			pad_lgt *= elements

			astTypeIniAddPad( ctx.tree, pad_lgt )
			astTypeIniGetOfs( ctx.tree ) += pad_lgt
		end if
	end if

	if( isarray ) then
		astTypeIniScopeEnd( ctx.tree, ctx.sym )

		'' '}'
		if( lexGetToken( ) <> CHAR_RBRACE ) then
			errReport( FB_ERRMSG_EXPECTEDRBRACE )
			'' error recovery: skip until next '}'
			hSkipUntil( CHAR_RBRACE, TRUE )
		else
			lexSkipToken( )
		end if

		ctx.dimension -= 1
	end if

	function = TRUE
end function

private function hUDTInit( byref ctx as FB_INITCTX ) as integer
	static as integer rec_cnt

	dim as integer elm_cnt = any
	dim as longint lgt = any, baseofs = any, pad_lgt = any
	dim as FBSYMBOL ptr fld = any, first = any
	dim as FBSYMBOL ptr oldsubtype = any
	dim as integer olddtype = any
    dim as FB_INITCTX old_ctx = any

    function = FALSE

    rec_cnt += 1

    '' ctor?
    if( (ctx.options and FB_INIOPT_ISOBJ) <> 0 ) then
    	dim as ASTNODE ptr expr = any

		'' Set the context data type, to allow anonymous type()'s to
		'' work for UDTs with constructors here
		oldsubtype = parser.ctxsym
		olddtype   = parser.ctx_dtype
		parser.ctx_dtype = ctx.dtype
		parser.ctxsym    = ctx.subtype

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
				if( (astGetDataType( expr ) = typeGetDtAndPtrOnly( ctx.dtype )) and _
				    (astGetSubtype( expr ) = ctx.subtype) ) then
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
			return astTypeIniAddCtorCall( ctx.tree, ctx.sym, expr, ctx.dtype, ctx.subtype ) <> NULL
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
		astTypeIniScopeBegin( ctx.tree, ctx.sym, FALSE )
		lexSkipToken( )
	end if

	first = symbUdtGetFirstField( ctx.subtype )
	fld = first

	lgt = 0
	baseofs = astTypeIniGetOfs( ctx.tree )

	'' save parent
	old_ctx = ctx

	ctx.dimension = -1

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
		hUpdateContextDtype( ctx )

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

				'' Undo the astTypeIniScopeBegin() done above.
				'' We're assigning to the UDT, not to a field,
				'' so there should be no typeini scope.
				assert( ctx.tree->r->class = AST_NODECLASS_TYPEINI_SCOPEINI )
				astTypeIniRemoveLastNode( ctx.tree )
			end if

			rec_cnt -= 1

			if( is_ctorcall ) then
				return astTypeIniAddCtorCall( ctx.tree, ctx.sym, expr, ctx.dtype, ctx.subtype ) <> NULL
			else
				'' try to assign it (do a shallow copy)
				return hDoAssign( ctx, expr )
			end if
		end if

		lgt += symbGetRealSize( fld )

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
	dim as longint sym_len = symbCalcLen( ctx.dtype, ctx.subtype )
	pad_lgt = sym_len - lgt
	if( pad_lgt > 0 ) then
		astTypeIniAddPad( ctx.tree, pad_lgt )
	end if
	astTypeIniGetOfs( ctx.tree ) = baseofs + sym_len

	rec_cnt -= 1

	function = TRUE
end function

function cInitializer _
	( _
		byval sym as FBSYMBOL ptr, _
		byval options as FB_INIOPT, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as integer is_local = any, ok = any
    dim as FB_INITCTX ctx = any

	function = NULL

	'' cannot initialize dynamic vars/fields
	if( symbGetIsDynamic( sym ) or symbIsCommon( sym ) ) then
		errReport( FB_ERRMSG_CANTINITDYNAMICARRAYS, TRUE )
		exit function
	end if

	if( symbIsVar( sym ) ) then
		is_local = symbIsLocal( sym )
	'' param, struct/class field or anon-udt
	else
		is_local = FALSE
	end if

	ctx.options = options
	ctx.sym = sym
	ctx.dimension = -1
	ctx.init_expr = NULL
	hUpdateContextDtype( ctx, dtype, subtype )

	ctx.tree = astTypeIniBegin( ctx.dtype, ctx.subtype, is_local, symbGetOfs( sym ) )

	'' has ctor?
	if( typeHasCtor( ctx.dtype, ctx.subtype ) ) then
		ctx.options or= FB_INIOPT_ISOBJ
	end if

	'' If it can be an array, start with hArrayInit()
	if( symbIsVar( ctx.sym ) or symbIsField( ctx.sym ) ) then
		ok = hArrayInit( ctx )
	else
		'' Everything else (e.g. params)
		if( typeGetDtAndPtrOnly( ctx.dtype ) = FB_DATATYPE_STRUCT ) then
			ok = hUDTInit( ctx )
		else
			ok = hElmInit( ctx )
		end if
	end if

	astTypeIniEnd( ctx.tree, (options and FB_INIOPT_ISINI) <> 0 )

	function = iif( ok, ctx.tree, NULL )
end function
