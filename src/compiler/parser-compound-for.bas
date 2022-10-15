'' FOR..NEXT compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "symb.bi"

enum FOR_FLAGS
	FOR_ISUDT           = &h0001
	FOR_HASCTOR         = &h0002
	FOR_ISLOCAL         = &h0004
end enum

#define CREATEFAKEID( ) _
	astNewVAR( symbAddTempVar( FB_DATATYPE_INTEGER ) )

declare function hUdtCallOpOvl _
	( _
		byval parent as FBSYMBOL ptr, _
		byval op as AST_OP, _
		byval inst_expr as ASTNODE ptr, _
		byval second_arg as ASTNODE ptr, _
		byval third_arg as ASTNODE ptr = NULL _
	) as ASTNODE ptr

declare sub hFlushBOP _
	( _
		byval op as integer, _
		byval lhs as FB_CMPSTMT_FORELM ptr, _
		byval rhs as FB_CMPSTMT_FORELM ptr, _
		byval ex as FBSYMBOL ptr _
	)

declare sub hFlushSelfBOP _
	( _
		byval op as integer, _
		byval lhs as FB_CMPSTMT_FORELM ptr, _
		byval rhs as FB_CMPSTMT_FORELM ptr _
	)

''::::
private function hElmToExpr _
	( _
		byval v as FB_CMPSTMT_FORELM ptr _
	) as ASTNODE ptr

	'' This function creates an AST node using the value
	'' contained in the FB_CMPSTMT_FORELM. The structure
	'' either contains a symbol, which is used, or if no
	'' symbol is found then the embedded value is used to
	'' create a constant, which is used instead.
	'' The AST node is returned.

	'' if there's an embedded symbol, use it
	if( v->sym <> NULL ) then
		function = astNewVAR( v->sym )

	'' make a constant...
	else
		function = astNewCONST( @v->value, v->dtype )
	end if

end function

'':::::
private sub hUdtFor _
	( _
		byval stk as FB_CMPSTMTSTK ptr _
	)

	dim as ASTNODE ptr proc = any, step_expr = NULL

	'' only pass the step arg if it's an explicit step
	if( stk->for.explicit_step ) then
		step_expr = hElmToExpr( @stk->for.stp )
	end if

	proc = hUdtCallOpOvl( symbGetSubtype( stk->for.cnt.sym ), _
	                      AST_OP_FOR, _
	                      hElmToExpr( @stk->for.cnt ), _
	                      step_expr )

	if( proc <> NULL ) then
		astAdd( proc )
	end if

end sub

'':::::
private sub hUdtStep _
	( _
		byval stk as FB_CMPSTMTSTK ptr _
	)

	dim as ASTNODE ptr proc = any, step_expr = NULL

	'' only pass the step arg if it's an explicit step
	if( stk->for.explicit_step ) then
		step_expr = hElmToExpr( @stk->for.stp )
	end if

	proc = hUdtCallOpOvl( symbGetSubtype( stk->for.cnt.sym ), _
	                      AST_OP_STEP, _
	                      hElmToExpr( @stk->for.cnt ), _
	                      step_expr )

	if( proc <> NULL ) then
		astAdd( proc )
	end if

end sub

'':::::
private sub hUdtNext _
	( _
		byval stk as FB_CMPSTMTSTK ptr _
	)

	dim as ASTNODE ptr proc = any, step_expr = NULL

	'' only pass the step arg if it's an explicit step
	if( stk->for.explicit_step ) then
		step_expr = hElmToExpr( @stk->for.stp )
	end if

	proc = hUdtCallOpOvl( symbGetSubtype( stk->for.cnt.sym ), _
	                      AST_OP_NEXT, _
	                      hElmToExpr( @stk->for.cnt ), _
	                      hElmToExpr( @stk->for.end ), _
	                      step_expr )

	if( proc <> NULL ) then
		'' if proc(...) <> 0 then goto init
		astAdd( astNewBOP( AST_OP_NE, _
		                   proc, _
		                   astNewCONSTi( 0 ), _
		                   stk->for.inilabel, _
		                   AST_OPOPT_NONE ) )
	end if

end sub

'':::::
private sub hScalarStep _
	( _
		byval stk as FB_CMPSTMTSTK ptr _
	)

	'' counter += step
	hFlushSelfBOP( AST_OP_ADD_SELF, @stk->for.cnt, @stk->for.stp )

end sub

'':::::
private sub hScalarNext _
	( _
		byval stk as FB_CMPSTMTSTK ptr _
	)

	'' is STEP known? (ie: an constant expression)
	if( stk->for.ispos.sym = NULL ) then
		'' counter <= or >= end cond?
		hFlushBOP( iif( stk->for.ispos.value.i, AST_OP_LE, AST_OP_GE ), _
		           @stk->for.cnt, @stk->for.end, stk->for.inilabel )

	'' STEP unknown, check sign and branch
	else
		dim as FBSYMBOL ptr cl = symbAddLabel( NULL )

		'' if ispositive = FALSE then
				astAdd( astNewBOP( AST_OP_NE, _
				        hElmToExpr( @stk->for.ispos ), _
				        astNewCONSTi( 0 ), _
				        cl, _
				        AST_OPOPT_NONE ) )

			'' if counter >= end_condition then
				'' goto top_of_FOR
				hFlushBOP( AST_OP_GE, @stk->for.cnt, @stk->for.end, stk->for.inilabel )

			'' else
				'' goto skip_positive_check
				astAdd( astNewBRANCH( AST_OP_JMP, stk->for.endlabel ) )

			'' end if

		'' else
		astAdd( astNewLABEL( cl, FALSE ) )

			'' if cnt <= end then goto for_ini
			hFlushBOP( AST_OP_LE,  @stk->for.cnt, @stk->for.end, stk->for.inilabel )

		'' end if

		'' skip_positive_check:
	end if

end sub

private function hAddImplicitVar _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = any
	dim as integer options = any

	options = 0

	'' Move the implicit var to procedure-level if the lang mode requests it
	'' (to prevent the stack memory from being re-used by other locals,
	'' allowing for "random" GOTOs/GOSUBs in and out of FOR loops)
	if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) then
		options or= FB_SYMBOPT_UNSCOPE
	end if

	'' dim temp as dtype
	s = symbAddImplicitVar( dtype, subtype, options )

	if( options and FB_SYMBOPT_UNSCOPE ) then
		astAddUnscoped( astNewDECL( s, TRUE ) )
	else
		astAdd( astNewDECL( s, FALSE ) )
	end if

	function = s
end function

'' Create an implicit variable for the given dtype and add the code storing the
'' given expression into it.
private function hStoreTemp _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr _
	) as FBSYMBOL ptr

	'' Move the implicit var to procedure-level if the lang mode requests it
	'' (to prevent the stack memory from being re-used by other locals,
	'' allowing for "random" GOTOs/GOSUBs in and out of FOR loops)
	dim as integer options = 0
	if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) then
		options or= FB_SYMBOPT_UNSCOPE
	end if

	'' dim implicitvar as dtype
	dim as FBSYMBOL ptr s = symbAddImplicitVar( dtype, subtype, options )
	dim as ASTNODE ptr declnode = NULL
	if( options and FB_SYMBOPT_UNSCOPE ) then
		astAddUnscoped( astNewDECL( s, TRUE ) )
	else
		declnode = astNewDECL( s, FALSE )
	end if

	'' implicitvar = expr
	expr = astNewASSIGN( astNewVAR( s ), expr )

	'' couldn't assign?
	if( expr = NULL ) then
		select case as const typeGet( dtype )
		'' TYPE or CLASS
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			errReport( FB_ERRMSG_INVALIDDATATYPES )
		case else
			errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, TRUE, _
			           astGetOpId( AST_OP_ASSIGN ) )
		end select
	end if

	astAdd( astNewLINK( declnode, expr, AST_LINK_RETURN_NONE ) )

	function = s
end function

'':::::
private sub hFlushBOP _
	( _
		byval op as integer, _
		byval lhs as FB_CMPSTMT_FORELM ptr, _
		byval rhs as FB_CMPSTMT_FORELM ptr, _
		byval ex as FBSYMBOL ptr _
	)

	'' This sub handles binary expression construction,
	'' and branching based on the result of those expressions.

	dim as ASTNODE ptr lhs_expr = any, rhs_expr = any, expr = any

	'' build expressions from the left and
	'' right-hand-side variables/constants
	lhs_expr = hElmToExpr( lhs )
	rhs_expr = hElmToExpr( rhs )

	'' attempt to build "lhs op rhs"
	expr = astNewBOP( op, lhs_expr, rhs_expr, ex, AST_OPOPT_NONE )

	'' fail?
	if( expr = NULL ) then
		'' this can only happen with UDT's
		errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, TRUE, astGetOpId( op ) )
		exit sub
	end if

	'' UDT?
	if( lhs->dtype = FB_DATATYPE_STRUCT ) then
		'' handle dtors, etc
		expr = astBuildBranch( expr, ex, TRUE )

		'' fail?
		if( expr = NULL ) then
			'' this can only happen with UDT's
			errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, TRUE, astGetOpId( op ) )
			exit sub
		end if
	end if

	'' add to AST
	astAdd( expr )

end sub

'':::::
private function hStepExpression _
	( _
		byval lhs_dtype as integer, _
		byval lhs_subtype as FBSYMBOL ptr, _
		byval rhs as FB_CMPSTMT_FORELM ptr _
	) as ASTNODE ptr

	dim as longint length = any

	'' This function generates the AST node for
	'' the STEP variable, which is used in hFlushSelfBOP
	'' as the right-hand-side to the FOR += operation.

	'' pointer counter?
	if( typeIsPtr( lhs_dtype ) ) then
		length = symbCalcDerefLen( lhs_dtype, lhs_subtype )
		if( length <= 0 ) then
			errReport( FB_ERRMSG_INCOMPLETETYPE )
			length = 1
		end if

		'' is STEP a complex expression?
		if( rhs->sym <> NULL ) then
			'' Creates an AST node with a binary expression.
			'' The left hand side of the expression is the
			'' STEP variable in a FOR block, the right-hand-side
			'' is an unsigned integer constant derived from the
			'' width of the counter variable.
			function = astNewBOP( AST_OP_MUL, _
			                      astNewVAR( rhs->sym, 0, FB_DATATYPE_INTEGER ), _
			                      astNewCONSTi( length ) )
		'' constant STEP
		else

			'' Creates an AST node with a constant integer expression.
			'' The value of the constant is calculated by
			'' taking the STEP value, and multiplying it by
			'' the width of the counter type.
			function = astNewCONSTi( rhs->value.i * length )
		end if
	'' regular variable counter
	else
		'' no calculation needed
		function = hElmToExpr( rhs )
	end if

end function

'':::::
private sub hFlushSelfBOP _
	( _
		byval op as integer, _
		byval lhs as FB_CMPSTMT_FORELM ptr, _
		byval rhs as FB_CMPSTMT_FORELM ptr _
	)

	'' This sub handles the creation of the '+=' expression.

	dim as ASTNODE ptr lhs_expr = any, rhs_expr = any, expr = any

	lhs_expr = astNewVAR( lhs->sym )
	rhs_expr = hStepExpression( lhs->dtype, symbGetSubtype( lhs->sym ), rhs )

	'' attept to create the '+=' expression
	expr = astNewSelfBOP( op, lhs_expr, rhs_expr )

	'' fail?
	if( expr = NULL ) then
		'' this can only happen with UDT's
		errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, TRUE, astGetOpId( op ) )
		exit sub
	end if

	'' add to AST
	astAdd( expr )

end sub

private function hCallCtor( byval sym as FBSYMBOL ptr ) as integer
	dim as ASTNODE ptr expr = cInitializer( sym, FB_INIOPT_ISINI )
	if( expr = NULL ) then
		exit function
	end if

	expr = astTypeIniFlush( sym, expr, FALSE, AST_OPOPT_ISINI )
	if( expr = NULL ) then
		exit function
	end if

	astAdd( expr )
	function = TRUE
end function

private sub hForAssign _
	( _
		byval stk as FB_CMPSTMTSTK ptr, _
		byref isconst as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval flags as FOR_FLAGS, _
		byval idexpr as ASTNODE ptr _
	)

	'' This function handles the '= InitialCondition'
	'' expression of a FOR block.

	'' =
	if( cAssignToken( ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDEQ )
	end if

	'' Not a local UDT with a constructor?
	if( ((flags and FOR_HASCTOR) = 0) or ((flags and FOR_ISLOCAL) = 0) ) then
		dim as ASTNODE ptr expr = cExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0 )
		end if

		'' initial condition is a non-UDT constant?
		if( astIsCONST( expr ) and ((flags and FOR_ISUDT) = 0) ) then
			'' convert the constant to counter's type
			expr = astNewCONV( dtype, subtype, expr )
			if( expr = NULL ) then
				errReport( FB_ERRMSG_INVALIDDATATYPES )
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0 )
			end if

			'' take the constant value
			stk->for.cnt.value = *astConstGetVal( expr )

			isconst += 1
		end if

		'' save initial condition into counter
		expr = astNewASSIGN( idexpr, expr )
		if( expr = NULL ) then
			if( (flags and FOR_ISUDT) <> 0 ) then
				errReport( FB_ERRMSG_INVALIDDATATYPES )
			else
				errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, TRUE, @"let" )
			end if
		else
			astAdd( expr )
		end if

	'' UDT has a constructor and is local..
	else
		if( hCallCtor( stk->for.cnt.sym ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		end if
	end if
end sub

'':::::
private sub hForTo _
	( _
		byval stk as FB_CMPSTMTSTK ptr, _
		byref isconst as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval flags as FOR_FLAGS _
	)

	'' This function handles the 'TO EndCondition'
	'' expression of a FOR block.

	'' TO
	if( lexGetToken( ) <> FB_TK_TO ) then
		errReport( FB_ERRMSG_EXPECTEDTO )
	else
		lexSkipToken( LEXCHECK_POST_SUFFIX )
	end if

	'' EndCondition

	'' UDT has no constructor?
	if( (flags and FOR_HASCTOR) = 0 ) then
		dim as ASTNODE ptr expr = cExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0 )
		end if

		'' EndCondition is a non-UDT constant?
		if( astIsCONST( expr ) and ((flags and FOR_ISUDT) = 0) ) then
			expr = astNewCONV( dtype, subtype, expr )
			if( expr = NULL ) then
				errReport( FB_ERRMSG_INVALIDDATATYPES )
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0 )
			end if

			'' remove any symbol, and
			stk->for.end.sym = NULL
			stk->for.end.dtype = dtype

			'' insert constant value instead, deleting
			'' source expression
			stk->for.end.value = *astConstGetVal( expr )
			astDelNode( expr )

			isconst += 1

		'' store end condition into a temp var
		else
			'' generate a symbol using the expression's type
			stk->for.end.sym = hStoreTemp( dtype, subtype, expr )
			stk->for.end.dtype = symbGetType( stk->for.end.sym )
		end if

	'' UDT has a constructor..
	else

		'' generate a symbol using the expression's type
		stk->for.end.sym = hAddImplicitVar( dtype, subtype )
		stk->for.end.dtype = symbGetType( stk->for.end.sym )

		'' build constructor call
		if( hCallCtor( stk->for.end.sym ) = FALSE ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
		end if
	end if

end sub

'':::::
private sub hForStep _
	( _
		byval stk as FB_CMPSTMTSTK ptr, _
		byref isconst as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval flags as FOR_FLAGS _
	)

	'' STEP
	stk->for.explicit_step = FALSE
	if( lexGetToken( ) = FB_TK_STEP ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		stk->for.explicit_step = TRUE
	end if

	dim as integer iscomplex = FALSE

	if( (flags and FOR_HASCTOR) = 0 ) then
		dim as ASTNODE ptr expr = any

		if( stk->for.explicit_step ) then
			expr = cExpression( )
			if( expr = NULL ) then
				errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
				'' error recovery: fake an expr
				expr = astNewCONSTi( 1 )
			end if
		else
			'' no STEP was specified, so it's 1
			'' (the step's type will be converted below)
			expr = astNewCONSTi( 1 )
		end if

		if( (flags and FOR_ISUDT) = 0) then
			'' keep signed-ness of expr type, so negative steps will work properly
			if( typeIsSigned( astGetFullType( expr ) ) ) then
				dtype = typeToSigned( dtype )
			else
				dtype = typeToUnsigned( dtype )
			end if
		end if

		'' store step into a temp var

		'' non-UDT constant?
		if( astIsCONST( expr ) and ((flags and FOR_ISUDT) = 0) ) then
			expr = astNewCONV( dtype, subtype, expr )
			if( expr = NULL ) then
				errReport( FB_ERRMSG_INVALIDDATATYPES )
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0 )
			end if

			'' get step's positivity: >= 0?
			stk->for.ispos.value.i = astConstGeZero( expr )

			'' get constant step
			stk->for.stp.sym = NULL
			if( typeIsPtr( dtype ) ) then
				stk->for.stp.dtype = FB_DATATYPE_LONG
			else
				stk->for.stp.dtype = dtype
			end if

			'' store expr into value, and del temp expression
			stk->for.stp.value = *astConstGetVal( expr )
			astDelNode( expr )

			isconst += 1
		else
			iscomplex = TRUE

			'' make a copy of type info, so we can hack
			'' the pointer stuff if necessary
			dim as integer tmp_dtype = dtype
			dim as FBSYMBOL ptr tmp_subtype = subtype

			'' step can't be a pointer if counter is
			if( typeIsPtr( dtype ) ) then
				tmp_dtype = FB_DATATYPE_LONG
				tmp_subtype = NULL
			end if

			'' generate a symbol using the expression's type
			stk->for.stp.sym = hStoreTemp( tmp_dtype, tmp_subtype, expr )
			stk->for.stp.dtype = symbGetType( stk->for.stp.sym )
		end if

	'' UDT has a constructor..
	else
		iscomplex = TRUE

		if( stk->for.explicit_step ) then
			'' generate a symbol using the expression's type
			stk->for.stp.sym = hAddImplicitVar( dtype, subtype )
			stk->for.stp.dtype = symbGetType( stk->for.stp.sym )

			'' build constructor call
			if( hCallCtor( stk->for.stp.sym ) = FALSE ) then
				errReport( FB_ERRMSG_INVALIDDATATYPES )
			end if
		end if
	end if

	if( typeIsSigned( dtype ) = FALSE and ((flags and FOR_ISUDT) = 0) ) then

		'' step is unsigned, so non-negative
		stk->for.ispos.sym = NULL
		stk->for.ispos.dtype = FB_DATATYPE_INTEGER
		stk->for.ispos.value.i = -1  '' TRUE

	'' if STEP's sign is unknown, we have to check for that
	elseif( iscomplex and ((flags and FOR_ISUDT) = 0) ) then
		dim as FB_CMPSTMT_FORELM cmp '' zero-init the FBVALUE field, etc.
		cmp.dtype = stk->for.stp.dtype

		stk->for.ispos.sym = hAddImplicitVar( FB_DATATYPE_INTEGER )
		stk->for.ispos.dtype = FB_DATATYPE_INTEGER

		'' rhs = STEP >= 0
		dim as ASTNODE ptr rhs = astNewBOP( AST_OP_GE, _
		                                    hElmToExpr( @stk->for.stp ), _
		                                    hElmToExpr( @cmp ) )

		'' GE failed?
		if( rhs = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' fake it
			rhs = astNewCONSTi( 0 )
		end if

		'' is_positive = rhs
		astAdd( astNewASSIGN( astNewVAR( stk->for.ispos.sym ), rhs ) )

	'' no need for a sign check
	else
		stk->for.ispos.sym = NULL
	end if
end sub

'' ForStmtBegin  =  FOR ID (AS DataType)? '=' Expression TO Expression (STEP Expression)? .
sub cForStmtBegin( )
	dim as FOR_FLAGS flags = 0
	dim as FBSYMBOL ptr sym = any

	'' FOR
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' ID
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr base_parent = any

	chain_ = cIdentifier( base_parent, FB_IDOPT_ISDECL or FB_IDOPT_DEFAULT )

	'' open outer scope
	dim as ASTNODE ptr outerscopenode = astScopeBegin( )
	if( outerscopenode = NULL ) then
		errReport( FB_ERRMSG_RECLEVELTOODEEP )
	end if

	dim as ASTNODE ptr idexpr = any, expr = any

	'' new variable?
	if( lexGetLookAhead( 1 ) = FB_TK_AS ) then
		sym = cVarDecl( FB_SYMBATTRIB_NONE, FALSE, lexGetToken( ), TRUE )
		if( sym = NULL ) then
			'' error recovery: fake a var
			idexpr = CREATEFAKEID( )
		else
			flags or= FOR_ISLOCAL
			idexpr = astNewVAR( sym )
		end if

	'' tried array...
	elseif( lexGetLookAhead( 1 ) = CHAR_LPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDSCALAR, TRUE )
		'' error recovery: skip until next ')' and fake a var
		hSkipUntil( CHAR_RPRNT )
		idexpr = CREATEFAKEID( )

	'' look up the variable
	else
		idexpr = cVariable( chain_ )
		if( idexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDVAR )
			'' error recovery: fake a var
			idexpr = CREATEFAKEID( )
		end if

		if( astIsVAR( idexpr ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDSCALAR, TRUE )
			'' error recovery: fake a var
			astDelTree( idexpr )
			idexpr = CREATEFAKEID( )
		end if
	end if

	dim as integer dtype = astGetDataType( idexpr )
	dim as FBSYMBOL ptr subtype = astGetSubType( idexpr )

	if( typeIsConst( astGetFullType( idexpr ) ) ) then
		errReport( FB_ERRMSG_CONSTANTCANTBECHANGED )
	end if

	select case as const dtype
	case FB_DATATYPE_BOOLEAN
		errReport( FB_ERRMSG_TYPEMISMATCH, TRUE )
		'' error recovery: fake a var
		astDelTree( idexpr )
		idexpr = CREATEFAKEID( )
		dtype = astGetDataType( idexpr )

	'' allow all other scalars ...
	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE
	case FB_DATATYPE_SHORT, FB_DATATYPE_USHORT
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT
	case FB_DATATYPE_ENUM
	case FB_DATATYPE_LONG,FB_DATATYPE_ULONG
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE

	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		flags or= FOR_ISUDT
		if( symbHasCtor( astGetSymbol( idexpr ) ) ) then
			flags or= FOR_HASCTOR
		end if

	case else
		'' not a ptr?
		if( typeIsPtr( dtype ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDSCALAR, TRUE )
			'' error recovery: fake a var
			astDelTree( idexpr )
			idexpr = CREATEFAKEID( )
			dtype = astGetDataType( idexpr )
		end if
	end select

	'' push a FOR context
	dim as FB_CMPSTMTSTK ptr stk = cCompStmtPush( FB_TK_FOR )

	'' extract counter variable from the expression
	stk->for.cnt.sym = astGetSymbol( idexpr )
	stk->for.cnt.dtype = dtype

	dim as integer isconst = 0

	'' =
	hForAssign( stk, isconst, dtype, subtype, flags, idexpr )

	'' TO
	hForTo( stk, isconst, dtype, subtype, flags )

	'' STEP
	hForStep( stk, isconst, dtype, subtype, flags )

	'' labels
	dim as FBSYMBOL ptr il = any, tl = any, el = any, cl = any

	'' test label: jump to the bottom of the for,
	'' before any code within the block is executed
	tl = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	'' comp and end label (will be used by any CONTINUE/EXIT FOR)
	cl = symbAddLabel( NULL, FB_SYMBOPT_NONE )
	el = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	'' we need to "peek" at the end label,
	'' to allow an overloaded FOR operator to jump to it,
	'' if the operator returns FALSE
	stk->for.endlabel = el

	'' UDT? must call the FOR operator..
	if( (flags and FOR_ISUDT) <> 0 ) then
		hUdtFor( stk )
	end if

	if( stk->for.end.sym = NULL and stk->for.ispos.sym = NULL ) then
		dim as integer toobig = FALSE
		if ( stk->for.ispos.value.i ) then
			select case as const typeGetSizeType( stk->for.cnt.dtype )
			case FB_SIZETYPE_INT8
				toobig = (stk->for.end.value.i >= 127)
			case FB_SIZETYPE_UINT8
				toobig = (stk->for.end.value.i >= 255)
			case FB_SIZETYPE_INT16
				toobig = (stk->for.end.value.i >= 32767)
			case FB_SIZETYPE_UINT16
				toobig = (stk->for.end.value.i >= 65535)
			case FB_SIZETYPE_INT32
				toobig = (stk->for.end.value.i >= 2147483647)
			case FB_SIZETYPE_UINT32
				toobig = (stk->for.end.value.i >= 4294967295)
			case FB_SIZETYPE_INT64
				toobig = (culngint(stk->for.end.value.i) >= 9223372036854775807)
			case FB_SIZETYPE_UINT64
				toobig = (culngint(stk->for.end.value.i) >= 18446744073709551615)
			end select
		else
			select case as const typeGetSizeType( stk->for.cnt.dtype )
			case FB_SIZETYPE_UINT8, FB_SIZETYPE_UINT16, FB_SIZETYPE_UINT32, FB_SIZETYPE_UINT64
				toobig = (stk->for.end.value.i <= 0)
			case FB_SIZETYPE_INT8
				toobig = (stk->for.end.value.i <= -128)
			case FB_SIZETYPE_INT16
				toobig = (stk->for.end.value.i <= -32768)
			case FB_SIZETYPE_INT32
				toobig = (stk->for.end.value.i <= -2147483648)
			case FB_SIZETYPE_INT64
				'' can't test with '<=' comparison here otherwise
				'' condition is always true on 64-bit integer counters
				toobig = (stk->for.end.value.i = -9223372036854775808)
			end select
		end if
		if( toobig ) then
			errReportWarn( FB_WARNINGMSG_FORENDTOOBIG )
		end if
	end if

	'' if inic, endc and stepc are all constants,
	'' check if this branch is needed
	if( isconst = 3 ) then
		expr = astNewBOP( iif( stk->for.ispos.value.i, AST_OP_LE, AST_OP_GE ), _
		                  astNewCONST( @stk->for.cnt.value, stk->for.cnt.dtype ), _
		                  astNewCONST( @stk->for.end.value, stk->for.end.dtype ) )

		if( astConstFlushToInt( expr ) = 0 ) then
			astAdd( astNewBRANCH( AST_OP_JMP, el ) )
		end if
	else
		astAdd( astNewBRANCH( AST_OP_JMP, tl ) )
	end if

	'' add start label
	il = symbAddLabel( NULL )
	astAdd( astNewLABEL( il ) )

	'' push to stmt stack
	stk->scopenode = astScopeBegin( )
	stk->for.outerscopenode = outerscopenode
	stk->for.testlabel = tl
	stk->for.inilabel = il
	stk->for.cmplabel = cl
end sub

'':::::
private function hUdtCallOpOvl _
	( _
		byval parent as FBSYMBOL ptr, _
		byval op as AST_OP, _
		byval inst_expr as ASTNODE ptr, _
		byval second_arg as ASTNODE ptr, _
		byval third_arg as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr sym = any

	'' check if op was overloaded
	sym = symbGetCompOpOvlHead( parent, op )

	if( sym = NULL ) then
		errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, _
		           TRUE, _
		           astGetOpId( op ) )
		return NULL
	end if

	'' check for overloaded versions (note: don't pass the instance ptr)
	dim as FB_ERRMSG err_num = any
	if( second_arg = NULL ) then
		sym = symbFindClosestOvlProc( sym, 0, NULL, @err_num )
	else
		dim as FB_CALL_ARG args(0 to 1) = any
		dim as integer params = 1
		with args(0)
			.expr = second_arg
			.mode = INVALID
			.next = NULL
		end with

		'' link in that pesky 3rd arg.
		if( op = AST_OP_NEXT ) then
			if( third_arg <> NULL ) then
				args(0).next = @args(1)
				params += 1
				with args(1)
					.expr = third_arg
					.mode = INVALID
					.next = NULL
				end with
			end if
		end if

		sym = symbFindClosestOvlProc( sym, params, @args(0), @err_num )
	end if

	if( sym = NULL ) then
		'' some other error?
		if( err_num <> FB_ERRMSG_OK ) then
			errReport( err_num, TRUE )

		'' build a message for the user
		else
			dim as string op_version = *astGetOpId( op ) + " (with"
			select case as const op
			case AST_OP_FOR, AST_OP_STEP
				'' supposed to be 1 arg
				if( second_arg = NULL ) then
					op_version += "out"
				end if
			case AST_OP_NEXT
				'' supposed to be 2 args
				if( third_arg = NULL ) then
					op_version += "out"
				end if
			end select
			op_version += " step)"
			errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, TRUE, strptr(op_version) )
		end if
		return NULL
	else
		'' Check visibility of the operator
		if( symbCheckAccess( sym ) = FALSE ) then
			errReportEx( FB_ERRMSG_ILLEGALMEMBERACCESS , *symbGetFullProcName( sym ) )
			return NULL
		end if
	end if

	function = astBuildCall( sym, inst_expr, second_arg, third_arg )
end function

private sub hForStmtClose(byval stk as FB_CMPSTMTSTK ptr)
	'' close the scope block
	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

	'' cmp label
	astAdd( astNewLABEL( stk->for.cmplabel ) )

	'' UDT?
	select case symbGetType( stk->for.cnt.sym )
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		'' update
		hUdtStep( stk )

		'' emit test label
		astAdd( astNewLABEL( stk->for.testlabel ) )

		'' check
		hUdtNext( stk )

	case else
		'' update
		hScalarStep( stk )

		'' emit test label
		astAdd( astNewLABEL( stk->for.testlabel ) )

		'' check
		hScalarNext( stk )
	end select

	'' end label (loop exit)
	astAdd( astNewLABEL( stk->for.endlabel ) )

	'' close the outer scope block
	if( stk->for.outerscopenode <> NULL ) then
		astScopeEnd( stk->for.outerscopenode )
	end if
end sub

'' ForStmtEnd  =  NEXT (ID (',' ID?))? .
sub cForStmtEnd( )
	dim as FB_CMPSTMTSTK ptr stk = any

	'' NEXT
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	do
		'' TOS = top of stack
		stk = cCompStmtGetTOS( FB_TK_FOR )
		if( stk = NULL ) then
			hSkipStmt( )
			exit sub
		end if

		hForStmtClose( stk )

		'' ID?
		if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
			'' pop from stmt stack
			cCompStmtPop( stk )
			exit do
		end if

		'' ID
		dim as FBSYMCHAIN ptr chain_ = any
		dim as FBSYMBOL ptr base_parent = any
		chain_ = cIdentifier( base_parent, FB_IDOPT_ISDECL or FB_IDOPT_DEFAULT )

		'' look up the variable
		dim as ASTNODE ptr idexpr = cVariable( chain_ )

		if( idexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDVAR )
		else
			'' Same symbol?
			if( idexpr->sym <> stk->for.cnt.sym ) then
				errReport( FB_ERRMSG_FORNEXTVARIABLEMISMATCH )
			end if

			if( fbPdCheckIsSet( FB_PDCHECK_NEXTVAR ) ) then
				errReportWarn( FB_WARNINGMSG_NEXTVARMEANINGLESS, symbGetName(idexpr->sym) )
			end if

			'' delete idexpr, we don't need it, for anything
			astDelTree( idexpr )
		end if

		'' pop from stmt stack
		cCompStmtPop( stk )

		'' ','?
		if( lexGetToken( ) <> CHAR_COMMA ) then
			exit do
		end if

		lexSkipToken( )
	loop
end sub
