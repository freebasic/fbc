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

''::::: comparison
private sub hFlushBOP _
	( _
		byval op as integer, _
	 	byval v1 as FB_CMPSTMT_FORCNT ptr, _
		byval v2 as FB_CMPSTMT_FORCNT ptr, _
		byval ex as FBSYMBOL ptr _
	)

	dim as ASTNODE ptr v1_expr = any, v2_expr = any, expr = any

	'' bop
	if( v1->sym <> NULL ) then
		v1_expr = astNewVAR( v1->sym, 0, v1->dtype, symbGetSubType( v1->sym ) )
	else
		v1_expr = astNewCONST( @v1->value, v1->dtype )
	end if

	if( v2->sym <> NULL ) then
		v2_expr = astNewVAR( v2->sym, 0, v2->dtype, symbGetSubType( v2->sym ) )
	else
		v2_expr = astNewCONST( @v2->value, v2->dtype )
	end if

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
	 	byval v1 as FB_CMPSTMT_FORCNT ptr, _
		byval v2 as FB_CMPSTMT_FORCNT ptr _
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
		if ( v1->dtype >= FB_DATATYPE_POINTER ) then
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

/'
private function hCheckOps _
	( _
		byval isDeclFor as integer, _
		byval idexpr as ASTNODE ptr, _
		byval varSym as FBSYMBOL ptr, _
		byref neededOps as string _
	) as integer

    #define addMessageComma(__msg) if len( __msg ) > 0 then __msg += ", "

	dim as FBSYMBOL ptr structSym = any
	dim as integer satisfied = 0, dtype = any

	if( isDeclFor = FALSE ) then
		'' from expression (existing var)
		varSym = astGetSymbol( idexpr )
	end if

	structSym = varSym->subtype
	dtype = symbGetType( varSym )

	dim as FB_ERRMSG err_num = any
	dim as ASTNODE ptr lhsTemp = astNewVAR( varSym, 0, dtype, structSym ), _
					   rhsTemp = astNewVAR( varSym, 0, dtype, structSym )

	'' foo.+= overloaded?
	if( symbFindSelfBopOvlProc( AST_OP_ADD_SELF, lhsTemp, rhsTemp, @err_num ) = NULL ) then
		neededOps += "+="
	else
		satisfied += 1
	end if

	'' foo.let overloaded?
	if( symbFindSelfBopOvlProc( AST_OP_ASSIGN, lhsTemp, rhsTemp, @err_num ) = NULL ) then
		addMessageComma( neededOps )
		neededOps += "let"
	else
		satisfied += 1
	end if

	'' operator >= ( foo, numeric ) overloaded?
	if( symbFindBopOvlProc( AST_OP_GE, lhsTemp, rhsTemp, @err_num ) = NULL ) then
		'' nope...
		addMessageComma( neededOps )
		neededOps += ">="
	else
		satisfied += 1
	end if

	'' operator <= ( foo, numeric ) overloaded?
	if( symbFindBopOvlProc( AST_OP_LE, lhsTemp, rhsTemp, @err_num ) = NULL ) then
		'' nope...
		addMessageComma( neededOps )
		neededOps += "<="
	else
		satisfied += 1
	end if

	'' kill temps
	astDelNode( lhsTemp )
	astDelNode( rhsTemp )

	'' if all operators are in place, satisfied = 4
	function = satisfied >= 4

end function
'/

'':::::
''ForStmtBegin    =   FOR ID (AS DataType)? '=' Expression TO Expression (STEP Expression)? .
''
function cForStmtBegin _
	( _
		_
	) as integer

    #define hGetDType(__expr) iif( isStruct <> 0, astGetDataType( __expr ), dtype )

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

	dim as integer isDeclFor = FALSE
	if( lexGetLookAhead( 1 ) = FB_TK_AS ) then
		dim as FBSYMBOL ptr varSym = hVarDeclEx( FB_SYMBATTRIB_NONE, _
												 FALSE, _
												 lexGetToken( ), _
												 TRUE )
		if( varSym = NULL ) then
			'' error recovery: fake a var
			idexpr = CREATEFAKEID( )
		else
			idexpr = astNewVAR( varSym, _
								0, _
								symbGetType( varSym ), _
								symbGetSubtype( varSym ) )
			isDeclFor = TRUE
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
	dim as integer isStruct = FALSE

	select case as const dtype
	case FB_DATATYPE_BYTE to FB_DATATYPE_DOUBLE

	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		isStruct = TRUE

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
	stk->for.inic.sym = astGetSymbol( idexpr )
	stk->for.inic.dtype = dtype

	'' =
	if( lexGetToken( ) <> FB_TK_ASSIGN) then
		if( errReport( FB_ERRMSG_EXPECTEDEQ ) = FALSE ) then
			cCompStmtPop( stk )
			exit function
		end if
	else
		lexSkipToken( )
	end if

	'' get counter type (endc and step must be the same type)
	dim as integer isconst = 0

    '' Expression
    expr = cExpression( )
    if( expr = NULL ) then
    	if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
    		cCompStmtPop( stk )
    		exit function
    	else
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
    end if

	''
	if( astIsCONST( expr ) and (isstruct = FALSE) ) then
		expr = astNewCONV( dtype, NULL, expr )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		astToFbValue( @stk->for.inic.value, expr )

		isconst += 1
	end if

	'' save initial condition into counter
	expr = astNewASSIGN( idexpr, expr )
	if( expr = NULL ) then
		if( isstruct ) then
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

	'' TO
	if( lexGetToken( ) <> FB_TK_TO ) then
		if( errReport( FB_ERRMSG_EXPECTEDTO ) = FALSE ) then
			cCompStmtPop( stk )
			exit function
		end if
	else
		lexSkipToken( )
	end if

	'' end condition (Expression)
	expr = cExpression( )
	if( expr = NULL ) then
		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			cCompStmtPop( stk )
			exit function
		else
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
	end if

	''
	if( astIsCONST( expr ) and (isstruct = FALSE) ) then
		expr = astNewCONV( dtype, NULL, expr )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		stk->for.endc.sym = NULL
		stk->for.endc.dtype = dtype

		astToFbValue( @stk->for.endc.value, expr )
		astDelNode( expr )

		isconst += 1

	'' store end condition into a temp var
	else
		stk->for.endc.sym = hStoreTemp( dtype, subtype, expr )
		if( stk->for.endc.sym = NULL ) then
			exit function
		end if

		stk->for.endc.dtype = symbGetType( stk->for.endc.sym )
	end if

	'' STEP
	stk->for.ispositive	= TRUE
	stk->for.iscomplex = FALSE

	if( lexGetToken( ) = FB_TK_STEP ) then
		lexSkipToken( )

		expr = cExpression( )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				cCompStmtPop( stk )
				exit function
			else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 1, FB_DATATYPE_INTEGER )
			end if
		end if

		'' store step into a temp var
		if( astIsCONST( expr ) and (isstruct = FALSE) ) then
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
				stk->for.ispositive = (astGetValLong( expr ) >= 0)

			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				stk->for.ispositive = (astGetValFloat( expr ) >= 0)

			case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
				if( FB_LONGSIZE = len( integer ) ) then
					stk->for.ispositive = (astGetValInt( expr ) >= 0)
				else
					stk->for.ispositive = (astGetValLong( expr ) >= 0)
				end if

			case else
				stk->for.ispositive = (astGetValInt( expr ) >= 0)
			end select
		else
			stk->for.iscomplex = TRUE
		end if

		if( stk->for.iscomplex ) then
			stk->for.stpc.sym = hStoreTemp( dtype, subtype, expr )
			if( stk->for.stpc.sym = NULL ) then
				exit function
			end if
			stk->for.stpc.dtype = symbGetType( stk->for.stpc.sym )

		else
            '' get constant step
			stk->for.stpc.sym = NULL
			stk->for.stpc.dtype = dtype

			astToFbValue( @stk->for.stpc.value, expr )
			astDelNode( expr )

			isconst += 1
		end if

	else
		stk->for.stpc.sym = NULL
		stk->for.stpc.dtype = dtype

		select case as const dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			stk->for.stpc.value.long = 1

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			stk->for.stpc.value.float = 1.0

		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
			if( FB_LONGSIZE = len( integer ) ) then
				stk->for.stpc.value.int = 1
			else
				stk->for.stpc.value.long = 1
			end if

		case else
			'' ptr...
			stk->for.stpc.value.int = 1
		end select

		isconst += 1
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
    	expr = astNewBOP( iif( stk->for.ispositive, AST_OP_LE, AST_OP_GE ), _
    					  astNewCONST( @stk->for.inic.value, stk->for.inic.dtype ), _
    					  astNewCONST( @stk->for.endc.value, stk->for.endc.dtype ) )

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

	dim as FBSYMBOL ptr cl = any

	'' close the scope blocks
	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

	'' cmp label
	astAdd( astNewLABEL( parser.stmt.for.cmplabel ) )

	'' counter += step
	hFlushSelfBOP( AST_OP_ADD_SELF, @stk->for.inic, @stk->for.stpc )

	'' test label
	astAdd( astNewLABEL( stk->for.testlabel ) )

    if( stk->for.iscomplex = FALSE ) then
    	'' counter <= or >= end cond?
		hFlushBOP( iif( stk->for.ispositive, AST_OP_LE, AST_OP_GE ), _
				   @stk->for.inic, _
				   @stk->for.endc, _
				   stk->for.inilabel )

    else
		cl = symbAddLabel( NULL )

    	dim as FB_CMPSTMT_FORCNT cmpc = any

        cmpc.dtype = stk->for.stpc.dtype

    	select case stk->for.stpc.dtype
    	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    		cmpc.sym = hStoreTemp( cmpc.dtype, _
    							   symbGetSubtype( stk->for.stpc.sym ), _
    							   astNewCONSTi( 0 ) )

    	case else
    		cmpc.sym = NULL

    		'' test step sign and branch
			select case as const cmpc.dtype
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				cmpc.value.long = 0

			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				cmpc.value.float = 0.0

			case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
				if( FB_LONGSIZE = len( integer ) ) then
					cmpc.value.int = 0
				else
					cmpc.value.long = 0
				end if

			case else
				cmpc.value.int = 0
			end select
		end select

		hFlushBOP( AST_OP_GE, @stk->for.stpc, @cmpc, cl )

    	'' negative, loop if >=
		hFlushBOP( AST_OP_GE, @stk->for.inic, @stk->for.endc, stk->for.inilabel )
		'' exit loop
		astAdd( astNewBRANCH( AST_OP_JMP, parser.stmt.for.endlabel ) )
    	'' control label
    	astAdd( astNewLABEL( cl, FALSE ) )
    	'' positive, loop if <=
		hFlushBOP( AST_OP_LE,  @stk->for.inic, @stk->for.endc, stk->for.inilabel )
    end if

    '' end label (loop exit)
    astAdd( astNewLABEL( parser.stmt.for.endlabel ) )

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



