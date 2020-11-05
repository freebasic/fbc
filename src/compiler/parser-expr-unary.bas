'' unary operators (NOT, @, *, ...) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "pp.bi"

declare function hCast( byval options as AST_CONVOPT ) as ASTNODE ptr

private function hPPDefinedExpr( ) as ASTNODE ptr
	dim as FBSYMBOL ptr base_parent = any
	dim as integer is_defined = any

	'' DEFINED
	lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_POST_SUFFIX )

	'' '('
	if( lexGetToken( ) <> CHAR_LPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDLPRNT )
	else
		lexSkipToken( LEXCHECK_NODEFINE )
	end if

	'' Identifier
	is_defined = (cIdentifier( base_parent, FB_IDOPT_NONE ) <> NULL)
	lexSkipToken( )

	'' ')'
	if( hMatch( CHAR_RPRNT ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDRPRNT )
		'' error recovery: skip until ')'
		hSkipUntil( CHAR_RPRNT, TRUE )
	end if

	function = astNewCONSTi( is_defined )
end function

'':::::
''NegNotExpression=   ('-'|'+'|) ExpExpression
''				  |   NOT RelExpression
''				  |   HighestPresExpr .
''
function cNegNotExpression _
	( _
	 	_
	) as ASTNODE ptr

	dim as ASTNODE ptr negexpr = any

	select case lexGetToken( )
	'' '-'
	case CHAR_MINUS
		lexSkipToken( )

		'' ExpExpression
		negexpr = cExpExpression( )
		if( negexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake a new node
			negexpr = astNewCONSTi( 0 )
		else
			negexpr = astNewUOP( AST_OP_NEG, negexpr )
		end if

    	if( negexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a new node
			negexpr = astNewCONSTi( 0 )
    	end if

		return negexpr

	'' '+'
	case CHAR_PLUS
		lexSkipToken( )

		'' ExpExpression
		negexpr = cExpExpression(  )
		if( negexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake a new node
			negexpr = astNewCONSTi( 0 )
		else
			negexpr = astNewUOP( AST_OP_PLUS, negexpr )
		end if

    	if( negexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a new node
			negexpr = astNewCONSTi( 0 )
    	end if

    	return negexpr

	'' NOT
	case FB_TK_NOT
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' RelExpression
		negexpr = cRelExpression(  )
		if( negexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake a new node
			negexpr = astNewCONSTi( 0 )
		else
			negexpr = astNewUOP( AST_OP_NOT, negexpr )
		end if

    	if( negexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a new node
			negexpr = astNewCONSTi( 0 )
    	end if

		return negexpr
	end select

	function = cHighestPrecExpr( NULL, NULL )

end function

''::::
function cStrIdxOrMemberDeref _
	( _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr subtype = any
	dim as integer dtype = any

	if( expr = NULL ) then exit function

	dtype = astGetFullType( expr )
	subtype = astGetSubType( expr )

	select case as const typeGet( dtype )
	'' zstring indexing?
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR
		'' '['?
		if( lexGetToken( ) = CHAR_LBRACKET ) then
			expr = cMemberDeref( dtype, subtype, expr, TRUE )
		end if

		return expr

	'' udt '.' ?
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		select case( lexGetToken( ) )
		case CHAR_DOT
    		lexSkipToken( LEXCHECK_NOPERIOD )

			expr = cMemberAccess( dtype, subtype, expr )
			if( expr = NULL ) then
				return NULL
			end if

 			dtype = astGetFullType( expr )
 			subtype = astGetSubType( expr )

		'' ('->' | '[')? (possible on non-pointer UDT types due to operator overloading)
		case FB_TK_FIELDDEREF, CHAR_LBRACKET
			expr = cMemberDeref( dtype, subtype, expr, TRUE )
		end select

	end select

	'' FuncPtrOrMemberDeref?
	if( typeIsPtr( dtype ) ) then
		dim as integer isfuncptr = FALSE, isfield = FALSE

		select case lexGetToken( )
		'' function ptr '(' ?
		case CHAR_LPRNT
			isfuncptr = (typeGetDtAndPtrOnly( dtype ) = typeAddrOf( FB_DATATYPE_FUNCTION ))
			isfield = isfuncptr

		'' ptr ('->' | '[') ?
		case FB_TK_FIELDDEREF, CHAR_LBRACKET
			isfield = TRUE
	    end select

		if( isfield ) then
			expr = cFuncPtrOrMemberDeref( dtype, _
										  subtype, _
										  expr, _
										  isfuncptr, _
										  TRUE )
		end if
	end if

	function = expr

end function

''::::
'' HighestPrecExpr=   AddrOfExpression
''				  |	  ( DerefExpr
''				  	  |	CastingExpr
''					  | PtrTypeCastingExpr
''				  	  | ParentExpression
''					  ) FuncPtrOrMemberDeref?
''				  |	  AnonType
''				  |   Atom .
''
function cHighestPrecExpr _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any

	select case lexGetToken( )
	'' AddrOfExpression
	case FB_TK_ADDROFCHAR
		return cAddrOfExpression( )

	'' DerefExpr
	case FB_TK_DEREFCHAR
		expr = cDerefExpression( )

	'' ParentExpression
	case CHAR_LPRNT
		dim as integer is_opt = fbGetPrntOptional( )

		expr = cParentExpression( )

		'' if parsing a SUB, don't call StrIdxOrMemberDeref() twice
		if( is_opt ) then
			return expr
		end if

	case else

		select case as const lexGetToken( )
		'' AddrOfExpression
		case FB_TK_VARPTR, FB_TK_PROCPTR, FB_TK_SADD, FB_TK_STRPTR
			return cAddrOfExpression( )

		'' CAST '(' DataType ',' Expression ')'
		case FB_TK_CAST
			'' CAST
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			expr = hCast( 0 )

		'' CPTR '(' DataType ',' Expression{int|uint|ptr} ')'
		case FB_TK_CPTR
			'' CPTR
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			expr = hCast( AST_CONVOPT_PTRONLY )

		'' OperatorNew
		case FB_TK_NEW
			expr = cOperatorNew( )

		'' Atom
		case else
			'' PP expression?
			if( fbGetIsPP( ) ) then
				select case( lexGetToken( ) )
				'' TYPEOF '(' Expression ')'
				case FB_TK_TYPEOF
					return astNewCONSTstr( ppTypeOf( ) )

				'' DEFINED '(' Identifier ')'
				case FB_TK_DEFINED
					return hPPDefinedExpr( )

				end select
			end if

			return cAtom( base_parent, chain_ )

		end select

	end select

	function = cStrIdxOrMemberDeref( expr )
end function

'' '(' DataType ',' Expression ')'
private function hCast( byval options as AST_CONVOPT ) as ASTNODE ptr
	dim as integer dtype = any, errmsg = any
	dim as FBSYMBOL ptr subtype = any
	dim as ASTNODE ptr expr = any

	'' '('
	if( lexGetToken( ) <> CHAR_LPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDLPRNT )
		'' error recovery: skip until ')', fake a node
		hSkipUntil( CHAR_RPRNT, TRUE )
		return astNewCONSTi( 0 )
	end if
	lexSkipToken( )

	'' DataType
	if( cSymbolType( dtype, subtype ) = FALSE ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip until ',', create a fake type
		hSkipUntil( CHAR_COMMA )

		if( options and AST_CONVOPT_PTRONLY ) then
			dtype = typeAddrOf( FB_DATATYPE_VOID )
		else
			dtype = FB_DATATYPE_INTEGER
		end if
		subtype = NULL
	end if

	'' check for invalid types
	select case as const( typeGet( dtype ) )
	case FB_DATATYPE_VOID, FB_DATATYPE_FIXSTR
		errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
		'' error recovery: create a fake type
		if( options and AST_CONVOPT_PTRONLY ) then
			dtype = typeAddrOf( FB_DATATYPE_VOID )
		else
			dtype = FB_DATATYPE_INTEGER
		end if
		subtype = NULL

	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, _
		 FB_DATATYPE_LONG, FB_DATATYPE_ULONG, _
		 FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT, _
		 FB_DATATYPE_ENUM

		if( options and AST_CONVOPT_PTRONLY ) then
			if( fbPdCheckIsSet( FB_PDCHECK_CASTTONONPTR ) ) then
				errReportWarn( FB_WARNINGMSG_CASTTONONPTR )
			end if
		end if

	case FB_DATATYPE_POINTER
		options or= AST_CONVOPT_PTRONLY

	case else
		if( options and AST_CONVOPT_PTRONLY ) then
			errReportWarn( FB_WARNINGMSG_CASTTONONPTR )
		end if

	end select

	'' ','
	if( lexGetToken( ) <> CHAR_COMMA ) then
		errReport( FB_ERRMSG_EXPECTEDCOMMA )
	else
		lexSkipToken( )
	end if

	'' Expression
	expr = cExpression( )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: create a fake node
		expr = astNewCONSTz( dtype, subtype )
	end if

	options or= AST_CONVOPT_CHECKSTR

	'' -w constness implies -w funcptr
	if( (fbPdCheckIsSet( FB_PDCHECK_CASTFUNCPTR ) = FALSE) _
		and (fbPdCheckIsSet( FB_PDCHECK_CONSTNESS ) = FALSE) ) then
		options or= AST_CONVOPT_DONTWARNFUNCPTR
	end if

	expr = astNewCONV( dtype, subtype, expr, options, @errmsg )
	if( expr = NULL ) then
		if( errmsg = FB_ERRMSG_OK ) then
			if( options and AST_CONVOPT_PTRONLY ) then
				errmsg = FB_ERRMSG_EXPECTEDPOINTER
			else
				errmsg = FB_ERRMSG_TYPEMISMATCH
			end if
		end if
		errReport( errmsg, TRUE )

		'' error recovery: create a fake node
		expr = astNewCONSTz( dtype, subtype )
	end if

	'' ')'
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDRPRNT )
		'' error recovery: skip until next ')'
		hSkipUntil( CHAR_RPRNT, TRUE )
	else
		lexSkipToken( )
	end if

	function = expr
end function

'':::::
''DerefExpression	= 	DREF+ HighestPresExpr .
''
function cDerefExpression( ) as ASTNODE ptr
    dim as integer derefcnt = any
    dim as ASTNODE ptr expr = any

	'' DREF?
	if( lexGetToken( ) <> FB_TK_DEREFCHAR ) then
		return NULL
	end if

	'' DREF+
    derefcnt = 0
	do
		lexSkipToken( )
		derefcnt += 1
	loop while( lexGetToken( ) = FB_TK_DEREFCHAR )

	'' HighestPresExpr
	expr = cHighestPrecExpr( NULL, NULL )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: fake a node
		return astNewCONSTi( 0 )
	end if

	function = astBuildMultiDeref( derefcnt, expr, astGetFullType( expr ), astGetSubType( expr ) )
end function

private function hProcPtrBody _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr sym = any

	'' '('')'?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if
	end if

	'' resolve overloaded procs
	if( symbIsOverloaded( proc ) ) then
        if( parser.ctxsym <> NULL ) then
        	if( symbIsProc( parser.ctxsym ) ) then
        		sym = symbFindOverloadProc( proc, parser.ctxsym )
        		if( sym <> NULL ) then
        			proc = sym
        		end if
        	end if
        end if
	end if

	'' taking the address of an method? pointer to methods not supported yet..
	if( symbIsMethod( proc ) ) then
		errReportEx( FB_ERRMSG_ACCESSTONONSTATICMEMBER, symbGetFullProcName( proc ) )
		return astNewCONSTi( 0 )
	end if

	if( symbCheckAccess( proc ) = FALSE ) then
		errReportEx( FB_ERRMSG_ILLEGALMEMBERACCESS, symbGetFullProcName( proc ) )
	end if

	'' call any necessary rtl callbacks...
	dim as FBRTLCALLBACK callback = symbGetProcCallback( proc )
	if( callback <> NULL ) then
		callback( proc )
	end if

	function = astBuildProcAddrof( proc )
end function

private function hVarPtrBody _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = cHighestPrecExpr( base_parent, chain_ )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake a node
		return astNewCONSTi( 0 )
	end if

	'' skip any casting if they won't do any conversion
	'' TODO: replace astSkipNoConvCast() with astSkipConstCASTs()
	'' where applicable.  Need to verify.  On one hand, we
	'' probably don't care about CONST anymore, on the other
	'' hand, we need to make sure we don't prematurely optimize
	'' the CONST specifier away in the event that it is needed
	'' to be known with AST type checking later.
	dim as ASTNODE ptr t = astSkipConstCASTs( expr )

	select case as const astGetClass( t )
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_DEREF, _
	     AST_NODECLASS_TYPEINI, AST_NODECLASS_CALLCTOR

	case AST_NODECLASS_FIELD
		'' can't take address of bitfields..
		if( symbFieldIsBitfield( t->sym ) ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: fake a node
			astDelTree( expr )
			return astNewCONSTi( 0 )
		end if

	case else
		errReportEx( FB_ERRMSG_INVALIDDATATYPES, "for @ or VARPTR" )
		'' error recovery: fake a node
		astDelTree( expr )
		return astNewCONSTi( 0 )
	end select

	'' check op overloading
	scope
		dim as FBSYMBOL ptr proc = any
		dim as FB_ERRMSG err_num = any

		proc = symbFindSelfUopOvlProc( AST_OP_ADDROF, expr, @err_num )
		if( proc <> NULL ) then
			'' build a proc call
			expr = astBuildCall( proc, expr )
			if( expr = NULL ) then
				expr = astNewCONSTi( 0 )
			end if
			return expr
		else
			if( err_num <> FB_ERRMSG_OK ) then
				return astNewCONSTi( 0 )
			end if
		end if
	end scope

	function = astNewADDROF( expr )
end function

'':::::
''AddrOfExpression  =   VARPTR '(' HighPrecExpr ')'
''					|   PROCPTR '(' Proc ('('')')? ')'
'' 					| 	'@' (Proc ('('')')? | HighPrecExpr)
''					|   SADD|STRPTR '(' Variable{str}|Const{str}|Literal{str} ')' .
''
function cAddrOfExpression( ) as ASTNODE ptr
	dim as ASTNODE ptr expr = NULL

	'' '@' (Proc ('('')')? | Variable)
	if( lexGetToken( ) = FB_TK_ADDROFCHAR ) then
		lexSkipToken( )

  		'' not inside a WITH block?
  		dim as integer check_id = TRUE
		if( parser.stmt.with ) then
  			if( lexGetToken( ) = CHAR_DOT ) then
  				'' not a '..'?
  				check_id = (lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) = CHAR_DOT)
  			end if
		end if

  		'' check if the address of function is being taken
  		dim as FBSYMCHAIN ptr chain_ = NULL
  		dim as FBSYMBOL ptr sym = NULL, base_parent = NULL

		if( check_id ) then
			chain_ = cIdentifier( base_parent, FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT )
			sym = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
		end if

		'' proc?
		if( sym <> NULL ) then
			lexSkipToken( LEXCHECK_POST_LANG_SUFFIX )
			return hProcPtrBody( base_parent, sym )
		'' anything else..
		else
			return hVarPtrBody( base_parent, chain_ )
		end if
	end if

	select case as const lexGetToken( )
	'' VARPTR '(' Variable ')'
	case FB_TK_VARPTR
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0 )
		end if

		expr = hVarPtrBody( NULL, NULL )

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if

	'' PROCPTR '(' Proc ('('')')? ')'
	case FB_TK_PROCPTR
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0 )
		end if

		'' proc?
		dim as FBSYMCHAIN ptr chain_ = any
		dim as FBSYMBOL ptr sym = any, base_parent = any

		chain_ = cIdentifier( base_parent, _
							  FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT )
		sym = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
		if( sym = NULL ) then
			errReport( FB_ERRMSG_UNDEFINEDSYMBOL )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0 )
		else
			lexSkipToken( LEXCHECK_POST_LANG_SUFFIX )
		end if

		expr = hProcPtrBody( base_parent, sym )

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if

	'' SADD|STRPTR '(' Variable{str} ')'
	case FB_TK_SADD, FB_TK_STRPTR
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0 )
		end if

		expr = cHighestPrecExpr( NULL, NULL )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0 )
		end if

		dim as integer dtype = astGetDataType( expr )

		'' UDT? it might be a kind of z|wstring
		if( typeGet( dtype ) = FB_DATATYPE_STRUCT ) then
			var sym = astGetSubType( expr )
			if( symbGetUdtIsZstring( sym ) or symbGetUdtIsWstring( sym ) ) then
				astTryOvlStringCONV( expr )
				dtype = astGetDataType( expr )
			end if
		end if

		if( symbIsString( dtype ) = FALSE ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			astDelTree( expr )
			return astNewCONSTi( 0 )
		end if

		'' check for invalid classes (functions, etc)

		'' skip any casting if they won't do any conversion
		dim as ASTNODE ptr t = astSkipNoConvCAST( expr )

		select case as const astGetClass( t )
		case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
			 AST_NODECLASS_DEREF, AST_NODECLASS_TYPEINI, _
			 AST_NODECLASS_FIELD

		case else
			errReportEx( FB_ERRMSG_INVALIDDATATYPES, "for STRPTR" )
		end select

		'' varlen? do: *cast( [const] zstring const ptr ptr, @expr )
		select case dtype
		case FB_DATATYPE_STRING
			expr = astBuildStrPtr( expr )

		case FB_DATATYPE_WCHAR
			expr = astNewCONV( typeAddrOf( FB_DATATYPE_WCHAR ), _
							   NULL, _
							   astNewADDROF( expr ) )

		'' anything else: do cast( zstring ptr, @expr )
		case else
			expr = astNewCONV( typeAddrOf( FB_DATATYPE_CHAR ), _
							   NULL, _
							   astNewADDROF( expr ) )
		end select

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if

	end select

	'' Allow indexing on VARPTR()/STRPTR()/etc. directly, they look
	'' like functions so this isn't ambigious, while for @ it would
	'' mess up the operator precedence:
	''    @expr[i]  should be  @(expr[i]), not (@expr)[i]
	'' but for
	''    varptr(expr)[i], that problem doesn't exist.
	function = cStrIdxOrMemberDeref( expr )
end function
