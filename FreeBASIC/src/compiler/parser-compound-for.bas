''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


'' FOR..NEXT compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

enum FOR_FLAGS
    FOR_ISUDT			= &h0001
    FOR_HASCTOR			= &h0002
    FOR_ISLOCAL			= &h0004
end enum

#define CREATEFAKEID( ) _
	astNewVAR( symbAddTempVar( FB_DATATYPE_INTEGER ), 0, FB_DATATYPE_INTEGER )

'':::::
private function hStoreTemp _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = symbAddTempVar( dtype, subtype )
	if( s = NULL ) then
		return NULL
	end if

	expr = astNewASSIGN( astNewVAR( s, 0, dtype, subtype ), expr )
	if( expr = NULL ) then
		select case dtype
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				return NULL
			end if

		case else
			if( errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, _
						   TRUE, _
						   astGetOpId( AST_OP_ASSIGN ) ) = FALSE ) then
				return NULL
			end if
		end select

	else
		astAdd( expr )
	end if

	function = s

end function

''::::
private function hElmToExpr _
	( _
	 	byval v as FB_CMPSTMT_FORELM ptr _
	) as ASTNODE ptr

	if( v->sym <> NULL ) then
		function = astNewVAR( v->sym, 0, v->dtype, symbGetSubType( v->sym ) )
	else
		function = astNewCONST( @v->value, v->dtype )
	end if

end function

'':::::
private sub hFlushBOP _
	( _
		byval op as integer, _
	 	byval v1 as FB_CMPSTMT_FORELM ptr, _
		byval v2 as FB_CMPSTMT_FORELM ptr, _
		byval ex as FBSYMBOL ptr _
	)

	dim as ASTNODE ptr v1_expr = any, v2_expr = any, expr = any

	'' bop
	v1_expr = hElmToExpr( v1 )
	v2_expr = hElmToExpr( v2 )

	expr = astNewBOP( op, v1_expr, v2_expr, ex, AST_OPOPT_NONE )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, TRUE, astGetOpId( op ) )
		exit sub
	end if

	if( v1->dtype = FB_DATATYPE_STRUCT ) then
		expr = astUpdComp2Branch( expr, ex, TRUE )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, TRUE, astGetOpId( op ) )
			exit sub
		end if
	end if

	astAdd( expr )

end sub

''::::: self operation (cnt += step)
private sub hFlushSelfBOP _
	( _
		byval op as integer, _
	 	byval v1 as FB_CMPSTMT_FORELM ptr, _
		byval v2 as FB_CMPSTMT_FORELM ptr _
	)

	dim as ASTNODE ptr v1_expr = any, v2_expr = any, expr = any

	dim as FBSYMBOL ptr v1_subtype = symbGetSubtype( v1->sym )

	v1_expr = astNewVAR( v1->sym, 0, v1->dtype, v1_subtype )

    '' is step a complex expression?
	if( v2->sym <> NULL ) then
		'' pointer?
		if ( v1->dtype >= FB_DATATYPE_POINTER ) then
			'' multiply it by type (or if UDT ptr, subtype) width
			v2_expr = astNewBOP( AST_OP_MUL, _
                               	 astNewVAR( v2->sym, 0, FB_DATATYPE_INTEGER ), _
                               	 astNewCONSTi( symbCalcLen( v1->dtype mod FB_DATATYPE_POINTER, _
                               							  	v1_subtype, _
                               							  	FALSE ), _
                                               FB_DATATYPE_UINT ) )
		else
			v2_expr = astNewVAR( v2->sym, 0, v2->dtype, symbGetSubtype( v2->sym ) )
		end if

	'' constant..
	else
		'' if it's a pointer, we need a regular integer
		'' to do calculations...
		if( v1->dtype >= FB_DATATYPE_POINTER ) then
			v2_expr = astNewCONSTi( v2->value.int * _
										symbCalcLen( v1->dtype mod FB_DATATYPE_POINTER, _
													 v1_subtype, _
													 FALSE ), _
								  	  FB_DATATYPE_INTEGER )
		else
			v2_expr = astNewCONST( @v2->value, v2->dtype )
		end if
	end if

	''
	expr = astNewSelfBOP( op, v1_expr, v2_expr )
	if( expr = NULL ) then
		'' this can only happen with UDT's
		errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, TRUE, astGetOpId( op ) )
		exit sub
	end if

	''
	astAdd( expr )

end sub

'':::::
private function hCallCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr = NULL _
	) as integer

	'' explicit expression?
	if( expr = NULL ) then
		expr = cInitializer( sym, FB_INIOPT_ISINI )
    	if( expr = NULL ) then
    		return FALSE
    	end if

		expr = astTypeIniFlush( expr, sym, AST_INIOPT_ISINI )

	'' implicit..
	else
        dim as integer is_ctorcall = any
        expr = astBuildImplicitCtorCall( symbGetSubtype( sym ), _
        								 expr, _
        								 is_ctorcall )
    	if( expr = NULL ) then
    		return FALSE
    	end if

		'' back-patch the instance pointer
		if( is_ctorcall ) then
			expr = astPatchCtorCall( expr, _
								 	 astNewVAR( sym, _
								 				0, _
								 				symbGettype( sym ), _
								 				symbGetSubtype( sym ) ) )
		end if
	end if

    if( expr = NULL ) then
    	return FALSE
    end if

	astAdd( expr )

	function = TRUE

end function

'':::::
private function hForAssign _
	( _
		byval stk as FB_CMPSTMTSTK ptr, _
		byref isconst as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval flags as FOR_FLAGS, _
		byval idexpr as ASTNODE ptr _
	) as integer

	function = FALSE

	'' =
	if( lexGetToken( ) <> FB_TK_ASSIGN) then
		if( errReport( FB_ERRMSG_EXPECTEDEQ ) = FALSE ) then
			exit function
		end if
	else
		lexSkipToken( )
	end if

	'' get counter type (endc and step must be the same type)

    '' Expression
	if( ((flags and FOR_HASCTOR) = 0) or ((flags and FOR_ISLOCAL) = 0) ) then
    	dim as ASTNODE ptr expr = cExpression( )
    	if( expr = NULL ) then
    		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
    			exit function
    		else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
    	end if

		''
		if( astIsCONST( expr ) and ((flags and FOR_ISUDT) = 0) ) then
			expr = astNewCONV( dtype, NULL, expr )
			if( expr = NULL ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
			end if

			astCONST2FBValue( @stk->for.cnt.value, expr )

			isconst += 1
		end if

		'' save initial condition into counter
		expr = astNewASSIGN( idexpr, expr )
		if( expr = NULL ) then
			if( (flags and FOR_ISUDT) <> 0 ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
					exit function
				end if
			else
				if( errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, TRUE, @"let" ) = FALSE ) then
					exit function
				end if
			end if
		else
			astAdd( expr )
		end if

	'' UDT has a constructor and is local..
	else
    	if( hCallCtor( stk->for.cnt.sym ) = FALSE ) then
    		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
    			exit function
			end if
    	end if
	end if

	function = TRUE

end function

'':::::
private function hForTo _
	( _
		byval stk as FB_CMPSTMTSTK ptr, _
		byref isconst as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval flags as FOR_FLAGS _
	) as integer

	function = FALSE

	'' TO
	if( lexGetToken( ) <> FB_TK_TO ) then
		if( errReport( FB_ERRMSG_EXPECTEDTO ) = FALSE ) then
			exit function
		end if
	else
		lexSkipToken( )
	end if

	'' end condition (Expression)
	if( (flags and FOR_HASCTOR) = 0 ) then
		dim as ASTNODE ptr expr = cExpression( )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		''
		if( astIsCONST( expr ) and ((flags and FOR_ISUDT) = 0) ) then
			expr = astNewCONV( dtype, NULL, expr )
			if( expr = NULL ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
			end if

			stk->for.end.sym = NULL
			stk->for.end.dtype = dtype

			astCONST2FBValue( @stk->for.end.value, expr )
			astDelNode( expr )

			isconst += 1

		'' store end condition into a temp var
		else
			stk->for.end.sym = hStoreTemp( dtype, subtype, expr )
			if( stk->for.end.sym = NULL ) then
				exit function
			end if

			stk->for.end.dtype = symbGetType( stk->for.end.sym )
		end if

	'' UDT has a constructor..
	else
    	stk->for.end.sym = symbAddTempVar( dtype, subtype )
    	stk->for.end.dtype = symbGetType( stk->for.end.sym )

    	if( hCallCtor( stk->for.end.sym ) = FALSE ) then
    		if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    			exit function
			end if
    	end if
	end if

	function = TRUE

end function

'':::::
private function hForStep _
	( _
		byval stk as FB_CMPSTMTSTK ptr, _
		byref isconst as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval flags as FOR_FLAGS _
	) as integer

	function = FALSE

	'' STEP
	dim as integer exp_step = FALSE
	if( lexGetToken( ) = FB_TK_STEP ) then
		lexSkipToken( )
		exp_step = TRUE
	end if

	dim as integer iscomplex = FALSE

	if( (flags and FOR_HASCTOR) = 0 ) then
		dim as ASTNODE ptr expr = any

		if( exp_step ) then
			expr = cExpression( )
			if( expr = NULL ) then
				if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					expr = astNewCONSTi( 1, FB_DATATYPE_INTEGER )
				end if
			end if

		else
			'' the step's type will be coverted bellow
			expr = astNewCONSTi( 1, FB_DATATYPE_INTEGER )
		end if

		'' store step into a temp var
		if( astIsCONST( expr ) and ((flags and FOR_ISUDT) = 0) ) then
			expr = astNewCONV( dtype, NULL, expr )
			if( expr = NULL ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
			end if

			select case as const dtype
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				stk->for.ispos.value.int = (astGetValLong( expr ) >= 0)

			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				stk->for.ispos.value.int = (astGetValFloat( expr ) >= 0)

			case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
				if( FB_LONGSIZE = len( integer ) ) then
					stk->for.ispos.value.int = (astGetValInt( expr ) >= 0)
				else
					stk->for.ispos.value.int = (astGetValLong( expr ) >= 0)
				end if

			case else
				stk->for.ispos.value.int = (astGetValInt( expr ) >= 0)
			end select

			'' get constant step
			stk->for.stp.sym = NULL
			if( dtype >= FB_DATATYPE_POINTER ) then
				stk->for.stp.dtype = FB_DATATYPE_LONG
			else
				stk->for.stp.dtype = dtype
			end if

			astCONST2FBValue( @stk->for.stp.value, expr )
			astDelNode( expr )

			isconst += 1

		else
			iscomplex = TRUE

			dim as integer tmp_dtype = dtype
			dim as FBSYMBOL ptr tmp_subtype = subtype

			'' step can't be a pointer if counter is
			if( dtype >= FB_DATATYPE_POINTER ) then
				tmp_dtype = FB_DATATYPE_LONG
				tmp_subtype = NULL
			end if

			stk->for.stp.sym = hStoreTemp( tmp_dtype, tmp_subtype, expr )
			if( stk->for.stp.sym = NULL ) then
				exit function
			end if
			stk->for.stp.dtype = symbGetType( stk->for.stp.sym )
		end if

	'' UDT has a constructor..
	else
    	iscomplex = TRUE

    	stk->for.stp.sym = symbAddTempVar( dtype, subtype )
    	stk->for.stp.dtype = symbGetType( stk->for.end.sym )

		dim as ASTNODE ptr expr = NULL
		if( exp_step = FALSE ) then
			expr = astNewCONSTi( 1, FB_DATATYPE_INTEGER )
		end if

    	if( hCallCtor( stk->for.stp.sym, expr ) = FALSE ) then
    		if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    			exit function
			end if
    	end if
	end if

    '' if STEP's sign is unknown, we have to check for that
    if( iscomplex ) then
    	dim as FB_CMPSTMT_FORELM cmp = any

    	cmp.dtype = stk->for.stp.dtype

    	if( (flags and FOR_ISUDT) <> 0 ) then
    		'' no ctor?
    		if( (flags and FOR_HASCTOR) = 0 ) then
    			cmp.sym = hStoreTemp( cmp.dtype, _
    								  symbGetSubtype( stk->for.stp.sym ), _
    								  astNewCONSTi( 0 ) )

			'' the UDT has a constructor..
			else
       			cmp.sym = symbAddTempVar( cmp.dtype, _
       									  symbGetSubtype( stk->for.stp.sym ) )
    			if( hCallCtor( cmp.sym, astNewCONSTi( 0 ) ) = FALSE ) then
           			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
           				exit function
           			end if
    			end if
    		end if

		else
			cmp.sym = NULL

			select case as const cmp.dtype
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				cmp.value.long = 0

			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				cmp.value.float = 0.0

			case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
				if( FB_LONGSIZE = len( integer ) ) then
					cmp.value.int = 0
				else
					cmp.value.long = 0
				end if

			case else
				cmp.value.int = 0
			end select
		end if

		stk->for.ispos.sym = symbAddTempVar( FB_DATATYPE_INTEGER )
		stk->for.ispos.dtype = FB_DATATYPE_INTEGER

		'' is_positive = stp >= 0
		astAdd( astNewASSIGN( astNewVAR( stk->for.ispos.sym, 0, FB_DATATYPE_INTEGER ), _
					  		  astNewBOP( AST_OP_GE, _
					  		  			 hElmToExpr( @stk->for.stp ), _
					  		  			 hElmToExpr( @cmp ) ) ) )


		'' destroy the cmp symbol, it's not needed anymore
		if( cmp.sym <> NULL ) then
			if( symbGetHasDtor( symbGetSubtype( cmp.sym ) ) ) then
				astAdd( astBuildVarDtorCall( cmp.sym, TRUE ) )
			end if
		end if

	else
		stk->for.ispos.sym = NULL
	end if

	function = TRUE

end function

'':::::
''ForStmtBegin    =   FOR ID (AS DataType)? '=' Expression TO Expression (STEP Expression)? .
''
function cForStmtBegin _
	( _
		_
	) as integer

	dim as FOR_FLAGS flags = 0

	function = FALSE

	'' FOR
	lexSkipToken( )

	'' ID
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr base_parent = any

	chain_ = cIdentifier( base_parent, FB_IDOPT_ISDECL or FB_IDOPT_DEFAULT )
	if( errGetLast( ) <> FB_ERRMSG_OK ) then
		exit function
	end if

    '' open outer scope
    dim as ASTNODE ptr outerscopenode = NULL
    if( env.clopt.lang <> FB_LANG_QB ) then
		outerscopenode = astScopeBegin( )
		if( outerscopenode = NULL ) then
			if( errReport( FB_ERRMSG_RECLEVELTOODEEP ) = FALSE ) then
				exit function
			end if
		end if
	end if

    dim as ASTNODE ptr idexpr = any, expr = any

    '' new variable?
	if( lexGetLookAhead( 1 ) = FB_TK_AS ) then
		dim as FBSYMBOL ptr sym = hVarDeclEx( FB_SYMBATTRIB_NONE, _
											  FALSE, _
											  lexGetToken( ), _
											  TRUE )
		if( sym = NULL ) then
			'' error recovery: fake a var
			idexpr = CREATEFAKEID( )
		else
			flags or= FOR_ISLOCAL
			idexpr = astNewVAR( sym, _
								0, _
								symbGetType( sym ), _
								symbGetSubtype( sym ) )
		end if

	'' tried array...
	elseif( lexGetLookAhead( 1 ) = CHAR_LPRNT ) then

		if( errReport( FB_ERRMSG_EXPECTEDSCALAR, TRUE ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT )
		end if

	else
		idexpr = cVariable( chain_ )
		if( idexpr = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDVAR ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a var
				idexpr = CREATEFAKEID( )
			end if
		end if

		if( astIsVAR( idexpr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDSCALAR, TRUE ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a var
				astDelTree( idexpr )
				idexpr = CREATEFAKEID( )
			end if
		end if

	end if

	dim as integer dtype = astGetDataType( idexpr )
	dim as FBSYMBOL ptr subtype = astGetSubType( idexpr )

	'' not scalar?
	select case as const dtype
	case FB_DATATYPE_BYTE to FB_DATATYPE_DOUBLE

	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		flags or= FOR_ISUDT
		if( symbGetHasCtor( symbGetSubtype( astGetSymbol( idexpr ) ) ) ) then
			flags or= FOR_HASCTOR
		end if

	case else
		'' not a ptr?
		if( dtype < FB_DATATYPE_POINTER ) then
			if( errReport( FB_ERRMSG_EXPECTEDSCALAR, TRUE ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a var
				astDelTree( idexpr )
				idexpr = CREATEFAKEID( )
				dtype = astGetDataType( idexpr )
			end if
		end if
	end select

	dim as FB_CMPSTMTSTK ptr stk = cCompStmtPush( FB_TK_FOR )
	stk->for.cnt.sym = astGetSymbol( idexpr )
	stk->for.cnt.dtype = dtype

	dim as integer isconst = 0

    '' =
	if( hForAssign( stk, isconst, dtype, subtype, flags, idexpr ) = FALSE ) then
		cCompStmtPop( stk )
		exit function
	end if

    '' TO
	if( hForTo( stk, isconst, dtype, subtype, flags ) = FALSE ) then
		cCompStmtPop( stk )
		exit function
	end if

	'' STEP
	if( hForStep( stk, isconst, dtype, subtype, flags ) = FALSE ) then
		cCompStmtPop( stk )
		exit function
	end if

	'' labels
    dim as FBSYMBOL ptr il = any, tl = any, el = any, cl = any
    tl = symbAddLabel( NULL, FB_SYMBOPT_NONE )
	'' add comp and end label (will be used by any CONTINUE/EXIT FOR)
	cl = symbAddLabel( NULL, FB_SYMBOPT_NONE )
	el = symbAddLabel( NULL, FB_SYMBOPT_NONE )

    '' if inic, endc and stepc are all constants,
    '' check if this branch is needed

    if( isconst = 3 ) then
    	expr = astNewBOP( iif( stk->for.ispos.value.int, AST_OP_LE, AST_OP_GE ), _
    					  astNewCONST( @stk->for.cnt.value, stk->for.cnt.dtype ), _
    					  astNewCONST( @stk->for.end.value, stk->for.end.dtype ) )

    	if( astGetValInt( expr ) = FALSE ) then
    		astAdd( astNewBRANCH( AST_OP_JMP, el ) )
    	end if

    	astDelNode( expr )

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

	parser.stmt.for.cmplabel = cl
	parser.stmt.for.endlabel = el

	function = TRUE

end function

'':::::
private function hForStmtClose _
	( _
		byval stk as FB_CMPSTMTSTK ptr _
	) as integer

#macro hDestroyTemp( s )
	if( s <> NULL ) then
		select case symbGetType( s )
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			if( symbGetHasDtor( symbGetSubtype( s ) ) ) then
				astAdd( astBuildVarDtorCall( s, TRUE ) )
			end if
		end select
	end if
#endmacro

	'' close the scope block
	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

	'' cmp label
	astAdd( astNewLABEL( parser.stmt.for.cmplabel ) )

	'' counter += step
	hFlushSelfBOP( AST_OP_ADD_SELF, @stk->for.cnt, @stk->for.stp )

	'' test label
	astAdd( astNewLABEL( stk->for.testlabel ) )

    '' is STEP known? (ie: an constant expression)
    if( stk->for.ispos.sym = NULL ) then
    	'' counter <= or >= end cond?
		hFlushBOP( iif( stk->for.ispos.value.int, AST_OP_LE, AST_OP_GE ), _
				   @stk->for.cnt, _
				   @stk->for.end, _
				   stk->for.inilabel )

    '' STEP unknown, check sign and branch
    else
		dim as FBSYMBOL ptr cl = symbAddLabel( NULL )

		'' if ispositive = FALSE then
		astAdd( astNewBOP( AST_OP_NE, _
						   hElmToExpr( @stk->for.ispos ), _
						   astNewCONSTi( 0 ), _
						   cl, _
						   AST_OPOPT_NONE ) )

    		'' if cnt >= end then goto for_ini else exit for
			hFlushBOP( AST_OP_GE, @stk->for.cnt, @stk->for.end, stk->for.inilabel )

			astAdd( astNewBRANCH( AST_OP_JMP, parser.stmt.for.endlabel ) )

    	'' else
    	astAdd( astNewLABEL( cl, FALSE ) )

    		'' if cnt <= end then goto for_ini
			hFlushBOP( AST_OP_LE,  @stk->for.cnt, @stk->for.end, stk->for.inilabel )

		'' end if
    end if

    '' end label (loop exit)
    astAdd( astNewLABEL( parser.stmt.for.endlabel ) )

	'' call the destructors of the temp vars created (in inverse order)
	hDestroyTemp( stk->for.stp.sym )
	hDestroyTemp( stk->for.end.sym )

	'' close the outer scope block
	if( stk->for.outerscopenode <> NULL ) then
		astScopeEnd( stk->for.outerscopenode )
	end if

	function = TRUE

end function

'':::::
''ForStmtEnd      =   NEXT (ID (',' ID?))? .
''
function cForStmtEnd _
	( _
	) as integer

	dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	'' NEXT
	lexSkipToken( )

	do
		stk = cCompStmtGetTOS( FB_TK_FOR )
		if( stk = NULL ) then
			exit function
		end if

		hForStmtClose( stk )

		'' pop from stmt stack
		cCompStmtPop( stk )

		'' ID?
		if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
			exit do
		end if

		lexSkipToken( )

		'' ','?
		if( lexGetToken( ) <> CHAR_COMMA ) then
			exit do
		end if

		lexSkipToken( )
	loop

	function = TRUE

end function



