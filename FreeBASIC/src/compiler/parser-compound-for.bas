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
		byval expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s
    dim as ASTNODE ptr vexpr

	function = NULL

	s = symbAddTempVar( dtype, subtype )
	if( s = NULL ) then
		exit function
	end if

	vexpr = astNewVAR( s, 0, dtype, subtype )
	astAdd( astNewASSIGN( vexpr, expr ) )

	function = s

end function

''::::: comparison
private sub hFlushBOP _
	( _
		byval op as integer, _
		byval dtype as integer, _
	 	byval v1 as FBSYMBOL ptr, _
	 	byval val1 as FBVALUE ptr, _
	 	byval v1type as integer, _
		byval v2 as FBSYMBOL ptr, _
		byval val2 as FBVALUE ptr, _
	 	byval v2type as integer, _
		byval ex as FBSYMBOL ptr _
	) static

	dim as ASTNODE ptr expr1, expr2, expr

	'' bop
	if( v1 <> NULL ) then
		expr1 = astNewVAR( v1, 0, v1type, v1->subtype )
	else
		select case as const v1type
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			expr1 = astNewCONSTl( val1->long, v1type )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			expr1 = astNewCONSTf( val1->float, v1type )
		case else
			expr1 = astNewCONSTi( val1->int, v1type )
		end select
	end if

	if( v2 <> NULL ) then
		expr2 = astNewVAR( v2, 0, v2type )
	else
		select case as const v2type
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			expr2 = astNewCONSTl( val2->long, v2type )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			expr2 = astNewCONSTf( val2->float, v2type )
		case else
			expr2 = astNewCONSTi( val2->int, v2type )
		end select
	end if
    
	expr = astNewBOP( op, expr1, expr2, ex, AST_OPOPT_NONE )
	if dtype = FB_DATATYPE_STRUCT then
		expr = astUpdComp2Branch( expr, ex, TRUE )
	end if
	''
	astAdd( expr )

end sub

''::::: self operation (cnt += step)
private sub hFlushSelfBOP _
	( _
		byval op as integer, _
		byval dtype as integer, _
	 	byval v1 as FBSYMBOL PTR, _
		byval v2 as FBSYMBOL PTR, _
		byval val2 as FBVALUE ptr, _
		byval stype as integer _
	) static

	dim as ASTNODE ptr expr1, expr2, expr, ptrScale = ANY
    
    '' cnt OP= step
	'' cnt = expr1, step = expr2
	expr1 = astNewVAR( v1, 0, dtype, v1->subtype )
    
    '' is step a complex expression?
	if( v2 <> NULL ) then
		'' pointer?
		If ( dtype >= FB_DATATYPE_POINTER ) Then
			'' multiply it by type (or if UDT ptr, subtype) width
			expr2 = astNewBOP( AST_OP_MUL, _ 
                               astNewVAR( v2, 0, FB_DATATYPE_INTEGER ), _ 
                               astNewCONSTi( symbCalcLen( dtype mod FB_DATATYPE_POINTER, v1->subtype, FALSE ), _ 
                                             FB_DATATYPE_UINT ) )
		Else
			expr2 = astNewVAR( v2, 0, stype )
		end if
	else
		select case as const stype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			expr2 = astNewCONSTl( val2->long, stype )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			expr2 = astNewCONSTf( val2->float, stype )
		case else
			'' if it's a pointer, we need a regular integer
			'' to do calculations...
			If ( dtype >= FB_DATATYPE_POINTER ) Then
				expr2 = astNewCONSTi( val2->int * symbCalcLen( dtype mod FB_DATATYPE_POINTER, v1->subtype, FALSE ), FB_DATATYPE_INTEGER )
			Else
				expr2 = astNewCONSTi( val2->int, stype )
			End If
		end select
	end if

	'' 
	if dtype = FB_DATATYPE_STRUCT then
		expr = astNewSelfBOP( op, expr1, expr2 )
		
	else
		expr = astNewBOP( op, expr1, expr2 )

		'' assign
		expr1 = astNewVAR( v1, 0, dtype, v1->subtype )
		expr = astNewASSIGN( expr1, expr )
	end if

	''
	astAdd( expr )

end sub

private function hCheckOps _
	( _ 
		byval isDeclFor as integer, _
		byval idexpr as ASTNODE ptr, _
		byval varSym as FBSYMBOL ptr, _
		byref neededOps as string _
	) as integer
    
    #define addMessageComma(__msg) if len( __msg ) > 0 then __msg += ", "
    
	dim as FBSYMBOL ptr structSym = ANY
	dim as integer satisfied = 0, dtype = ANY
	
	if isDeclFor = FALSE then
		'' from expression (existing var)
		varSym = astGetSymbol( idexpr )
	end if

	structSym = varSym->subtype
	dtype = symbGetType( varSym )
	
	dim as FB_ERRMSG err_num = any
	dim as ASTNODE ptr lhsTemp = astNewVAR( varSym, 0, dtype, structSym ), rhsTemp = astNewCONSTi( 0, FB_DATATYPE_UINT )

	'' foo.+= overloaded?
	if symbFindSelfBopOvlProc( AST_OP_ADD_SELF, lhsTemp, rhsTemp, @err_num ) = NULL then
		neededOps += "+="
	else
		satisfied += 1
	end if

	'' foo.let overloaded?
	if symbFindSelfBopOvlProc( AST_OP_ASSIGN, lhsTemp, rhsTemp, @err_num ) = NULL then
		addMessageComma( neededOps )
		neededOps += "let"
	else
		satisfied += 1
	end if
	
	'' operator >= ( foo, numeric ) overloaded?
	if symbFindBopOvlProc( AST_OP_GE, lhsTemp, rhsTemp, @err_num ) = NULL then
		'' nope...
		addMessageComma( neededOps )
		neededOps += ">="
	else
		satisfied += 1
	end if
	
	'' operator <= ( foo, numeric ) overloaded?
	if symbFindBopOvlProc( AST_OP_LE, lhsTemp, rhsTemp, @err_num ) = NULL then
		'' nope...
		addMessageComma( neededOps )
		neededOps += "<="
	else
		satisfied += 1
	end if
	
	'' kill temps
	astDelNodE( lhsTemp )
	astDelNode( rhsTemp )
	
	'' if all operators are in place, satisfied = 4
	if satisfied < 4 then
		return FALSE
	end if
	
	return TRUE

end function


'':::::
''ForStmtBegin    =   FOR ID '=' Expression TO Expression (STEP Expression)? .
''
function cForStmtBegin as integer
    dim as FBSYMBOL ptr il = any, tl = any, el = any, cl = any, varSym = NULL
    dim as FBVALUE ival = any
    dim as ASTNODE ptr idexpr = any, expr = any, n = aNY
    dim as integer op = any, dtype = any, isconst = any, isDeclFor = FALSE, isStruct = FALSE
    dim as FBSYMCHAIN ptr chain_ = any
    dim as FB_CMPSTMTSTK ptr stk = any, outerStk = any
    
    #define vdtype(__expr) iif( isStruct <> 0, astGetDataType( __expr ), dtype )

	function = FALSE

	'' FOR
	lexSkipToken( )

	'' ID
	chain_ = cIdentifier( FB_IDOPT_ISDECL or FB_IDOPT_DEFAULT )
	if( errGetLast( ) <> FB_ERRMSG_OK ) then
		exit function
	end if
    
    if( env.clopt.lang <> FB_LANG_QB ) then
    
	    '' open outer scope
		n = astScopeBegin( )
		if( n = NULL ) then
			if( errReport( FB_ERRMSG_RECLEVELTOODEEP ) = FALSE ) then
				exit function
			end if
		end if
	
		outerStk = cCompStmtPush( FB_TK_SCOPE )
		outerStk->scopenode = n
	
	end if
    
    '' new variable?
	if( lexGetLookAhead( 1 ) = FB_TK_AS ) then
        
		if hVarDecl( FB_SYMBATTRIB_NONE, FALSE, lexGetToken( ), TRUE, varSym ) = FALSE then
			exit function
		end if

		if varSym = NULL then
			exit function
		end if
		
		idexpr = astNewVAR( varSym, 0, symbGetType( varSym ), varSym->subtype )
		isDeclFor = TRUE
	'' tried array...	
	elseif( lexGetLookAhead( 1 ) = CHAR_LPRNT ) then
		
		if( errReport( FB_ERRMSG_EXPECTEDSCALAR, TRUE ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT )
		end if
	
	else
		if( cVariable( chain_, idexpr ) = FALSE ) then
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

	dtype = astGetDataType( idexpr )

	'' not a ptr?
	if( dtype < FB_DATATYPE_POINTER ) then
		'' not scalar?
		If( (dtype < FB_DATATYPE_BYTE) Or (dtype > FB_DATATYPE_DOUBLE) ) Then
			
			if dtype = FB_DATATYPE_STRUCT then

				dim as string neededOps
				if hCheckOps( isDeclFor, idexpr, varSym, neededOps ) = FALSE then
					if( errReport( FB_ERRMSG_UDTINFORNEEDSOPERATORS, TRUE, neededOps ) = FALSE ) then
						exit function
					else
						'' error recovery: fake a var
						astDelTree( idexpr )
						idexpr = CREATEFAKEID( )
						dtype = astGetDataType( idexpr )
					end if
				else
					isStruct = TRUE
				end if
			else
				if( errReport( FB_ERRMSG_EXPECTEDSCALAR, TRUE ) = FALSE ) then
					exit function
				else
					'' error recovery: fake a var
					astDelTree( idexpr )
					idexpr = CREATEFAKEID( )
					dtype = astGetDataType( idexpr )
				end if
			end if
		end if
	end if

	stk = cCompStmtPush( FB_TK_FOR )
	if isDeclFor = TRUE then
		stk->for.cnt = varSym
	else
		stk->for.cnt = astGetSymbol( idexpr )
	end if
	
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
	isconst = 0

    '' Expression
    if( cExpression( expr ) = FALSE ) then
    	if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
    		cCompStmtPop( stk )
    		exit function
    	else
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
    end if

	''
	if( astIsCONST( expr ) ) then
		astConvertValue( expr, @ival, vdtype( expr ) )
		isconst += 1
	end if

	'' save initial condition into counter
	expr = astNewASSIGN( idexpr, expr )
	astAdd( expr )

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
	if( cExpression( expr ) = FALSE ) then
		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			cCompStmtPop( stk )
			exit function
		else
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
	end if
    
    stk->for.etype = vdtype( expr )
	''
	if( astIsCONST( expr ) ) then
		astConvertValue( expr, @stk->for.eval, stk->for.etype )
		astDelNode( expr )
		stk->for.endc = NULL
		isconst += 1

	'' store end condition into a temp var
	else
		stk->for.endc = hStoreTemp( expr, stk->for.etype, astGetSubtype( expr ) )
	end if

	'' STEP
	stk->for.ispositive	= TRUE
	stk->for.iscomplex = FALSE

	if( lexGetToken( ) = FB_TK_STEP ) then
		lexSkipToken( )

		if( cExpression( expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				cCompStmtPop( stk )
				exit function
			else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 1, FB_DATATYPE_INTEGER )
			end if
		end if
        
        stk->for.stype = vdtype( expr )

		'' store step into a temp var
		if( astIsCONST( expr ) ) then
			select case as const stk->for.stype
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				stk->for.ispositive = (astGetValLong( expr ) >= 0)
			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				stk->for.ispositive = (astGetValFloat( expr ) >= 0)
			case else
				stk->for.ispositive = (astGetValInt( expr ) >= 0)
			end select
		else
			stk->for.iscomplex = TRUE
		end if

		if( stk->for.iscomplex ) then
			dim as integer s_dtype = stk->for.stype
			if dtype >= FB_DATATYPE_POINTER then
				s_dtype = FB_DATATYPE_INTEGER
			end if

			stk->for.stp = symbAddTempVar( s_dtype )
			astAdd( astNewASSIGN( astNewVAR( stk->for.stp, 0, s_dtype ), expr ) )

		else
            '' get constant step
            astConvertValue( expr, @stk->for.sval, stk->for.stype )

			astDelNode( expr )
			stk->for.stp = NULL
			isconst += 1
		end if

	else
		if dtype = FB_DATATYPE_STRUCT then
			'' default to end condition's type for UDT...
			stk->for.stype = stk->for.etype
		else
			'' mimic the count var
			stk->for.stype = dtype
		end if

		select case as const stk->for.stype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			stk->for.sval.long = 1
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			stk->for.sval.float = 1.0
		case else
			'' also for UDT, ptr...
			stk->for.sval.int = 1
		end select
		stk->for.stp = NULL
		isconst += 1
	end if

	'' labels
    tl = symbAddLabel( NULL, FALSE )
	'' add comp and end label (will be used by any CONTINUE/EXIT FOR)
	cl = symbAddLabel( NULL, FALSE )
	el = symbAddLabel( NULL, FALSE )

    '' if inic, endc and stepc are all constants,
    '' check if this branch is needed
    
    if( isconst = 3 ) then
		if( stk->for.ispositive ) then
			op = AST_OP_LE
    	else
			op = AST_OP_GE
    	end if

    	expr = astNewBOP( op, _
    					  astNewCONST( @ival, vdtype( expr ) ), _
    					  astNewCONST( @stk->for.eval, stk->for.etype ) )

    	if( astGetValInt( expr ) = FALSE ) then
    		astAdd( astNewBRANCH( AST_OP_JMP, el ) )
    	end if

    	astDelNode( expr )

    else
    	astAdd( astNewBRANCH( AST_OP_JMP, tl ) )
    end if

	'' add start label
	il = symbAddLabel( NULL, TRUE )
	astAdd( astNewLABEL( il ) )
    
	'' push to stmt stack
	stk->scopenode = astScopeBegin( )
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
	) as integer static

	dim as FBSYMBOL ptr cl
	dim as integer op, dtype
	dim as FBVALUE ival

	dtype = symbGetType( stk->for.cnt )

	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

	'' cmp label
	astAdd( astNewLABEL( parser.stmt.for.cmplabel ) )
    
    op = AST_OP_ADD
    if dtype = FB_DATATYPE_STRUCT then
    	op = AST_OP_ADD_SELF
	end if

	'' counter += step
	hFlushSelfBOP( op, dtype, _
				   stk->for.cnt, _
				   stk->for.stp, @stk->for.sval, stk->for.stype )

	'' test label
	astAdd( astNewLABEL( stk->for.testlabel ) )

    if( stk->for.iscomplex = FALSE ) then

		if( stk->for.ispositive ) then
			op = AST_OP_LE
    	else
			op = AST_OP_GE
    	end if

    	'' counter <= or >= end cond?
		hFlushBOP( op, dtype, _
				   stk->for.cnt, NULL, symbGetType( stk->for.cnt ), _
				   stk->for.endc, @stk->for.eval, stk->for.etype, _
				   stk->for.inilabel )

    else
		cl = symbAddLabel( NULL, TRUE )

    	'' test step sign and branch
		select case as const stk->for.stype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			ival.long = 0
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			ival.float = 0.0
		case else
			ival.int = 0
		end select

		hFlushBOP( AST_OP_GE, dtype, _
				   stk->for.stp, @stk->for.sval, stk->for.stype, _
				   NULL, @ival, stk->for.stype, _
				   cl )

    	'' negative, loop if >=
		hFlushBOP( AST_OP_GE, dtype, _
				   stk->for.cnt, NULL, symbGetType( stk->for.cnt ), _
				   stk->for.endc, @stk->for.eval, stk->for.etype, _
				   stk->for.inilabel )
		'' exit loop
		astAdd( astNewBRANCH( AST_OP_JMP, parser.stmt.for.endlabel ) )
    	'' control label
    	astAdd( astNewLABEL( cl, FALSE ) )
    	'' positive, loop if <=
		hFlushBOP( AST_OP_LE, dtype, _
				   stk->for.cnt, NULL, symbGetType( stk->for.cnt ), _
				   stk->for.endc, @stk->for.eval, stk->for.etype, _
				   stk->for.inilabel )
    end if

    '' end label (loop exit)
    astAdd( astNewLABEL( parser.stmt.for.endlabel ) )

	function = TRUE

end function

'':::::
''ForStmtEnd      =   NEXT (ID (',' ID?))? .
''
function cForStmtEnd as integer
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
        
        if( env.clopt.lang <> FB_LANG_QB ) then

	        '' close outer scope
			stk = cCompStmtGetTOS( FB_TK_SCOPE )
			if( stk = NULL ) then
				exit function
			end if
		
			''
			if( stk->scopenode <> NULL ) then
				astScopeEnd( stk->scopenode )
			end if
		
			'' pop from stmt stack
			cCompStmtPop( stk )
			
		end if

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



