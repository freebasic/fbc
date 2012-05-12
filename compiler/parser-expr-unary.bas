'' unary operators (NOT, @, *, ...) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

declare function cCastingExpr _
	( _
	) as ASTNODE ptr

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
			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		else
			negexpr = astNewUOP( AST_OP_NEG, negexpr )
		end if

    	if( negexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a new node
			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
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
			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		else
			negexpr = astNewUOP( AST_OP_PLUS, negexpr )
		end if

    	if( negexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a new node
			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    	end if

    	return negexpr

	'' NOT
	case FB_TK_NOT
		lexSkipToken( )

		'' RelExpression
		negexpr = cRelExpression(  )
		if( negexpr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake a new node
			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		else
			negexpr = astNewUOP( AST_OP_NOT, negexpr )
		end if

    	if( negexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a new node
			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
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
		if( lexGetToken( ) = CHAR_DOT ) then
    		lexSkipToken( LEXCHECK_NOPERIOD )

			expr = cMemberAccess( dtype, subtype, expr )
			if( expr = NULL ) then
				return NULL
			end if

 			dtype = astGetFullType( expr )
 			subtype = astGetSubType( expr )
		end if

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
''				  |	  AnonUDT
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
		if( expr = NULL ) then
			return NULL
		end if

	'' ParentExpression
	case CHAR_LPRNT
		dim as integer is_opt = fbGetPrntOptional( )

		expr = cParentExpression( )
		if( expr = NULL ) then
			return NULL
		end if

		'' if parsing a SUB, don't call StrIdxOrMemberDeref() twice
		if( is_opt ) then
			return expr
		end if

	case else

		select case as const lexGetToken( )
		'' AddrOfExpression
		case FB_TK_VARPTR, FB_TK_PROCPTR, FB_TK_SADD, FB_TK_STRPTR
			return cAddrOfExpression( )

		'' CastingExpr
		case FB_TK_CAST
			expr = cCastingExpr( )
			if( expr = NULL ) then
				return NULL
			end if

		'' PtrTypeCastingExpr
		case FB_TK_CPTR
			expr = cPtrTypeCastingExpr( )
			if( expr = NULL ) then
				return NULL
			end if

		'' OperatorNew
		case FB_TK_NEW
			expr = cOperatorNew( )
			if( expr = NULL ) then
				return NULL
			end if

		'' Atom
		case else
			return cAtom( base_parent, chain_ )

		end select

	end select

	''
	function = cStrIdxOrMemberDeref( expr )

end function

'':::::
private function hCast _
	( _
		byval ptronly as integer _
	) as ASTNODE ptr

    dim as integer dtype = any, lgt = any
    dim as FBSYMBOL ptr subtype = any
    dim as ASTNODE ptr expr = any

	'' '('
	if( lexGetToken( ) <> CHAR_LPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDLPRNT )
		'' error recovery: skip until ')', fake a node
		hSkipUntil( CHAR_RPRNT, TRUE )
		return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	else
		lexSkipToken( )
	end if

    '' DataType
    if( cSymbolType( dtype, subtype, lgt ) = FALSE ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip until ',', create a fake type
		hSkipUntil( CHAR_COMMA )

		if( ptronly ) then
			dtype = typeAddrOf( FB_DATATYPE_VOID )
		else
			dtype = FB_DATATYPE_INTEGER
		end if
		subtype = NULL
    end if

	'' check for invalid types
	select case typeGet( dtype )
	case FB_DATATYPE_VOID, FB_DATATYPE_FIXSTR
		errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
		'' error recovery: create a fake type
		if( ptronly ) then
			dtype = typeAddrOf( FB_DATATYPE_VOID )
		else
			dtype = FB_DATATYPE_INTEGER
		end if
		subtype = NULL

	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, _
		 FB_DATATYPE_LONG, FB_DATATYPE_ULONG, _
		 FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT, _
		 FB_DATATYPE_ENUM

		if( ptronly) then
			if( fbPdCheckIsSet( FB_PDCHECK_CASTTONONPTR ) ) then
				errReportWarn( FB_WARNINGMSG_CASTTONONPTR )
			end if
		end if

	case FB_DATATYPE_POINTER

	case else
		if( ptronly) then
			errReportWarn( FB_WARNINGMSG_CASTTONONPTR )
		end if

	end select


	if( typeIsPtr( dtype ) ) then
		ptronly = TRUE
	end if

	'' ','
	if( lexGetToken( ) <> CHAR_COMMA ) then
		errReport( FB_ERRMSG_EXPECTEDCOMMA )
	else
		lexSkipToken( )
	end if

	'' expression
	expr = cExpression( )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: create a fake node
		expr = astNewCONSTz( dtype, subtype )
	end if

	expr = astNewCONV( dtype, subtype, expr, INVALID, TRUE )

    if( expr = NULL ) Then
		errReport( iif( ptronly, _
		                FB_ERRMSG_EXPECTEDPOINTER, _
		                FB_ERRMSG_TYPEMISMATCH ), TRUE )
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
'' CastingExpr	=	CAST '(' DataType ',' Expression ')'
''
function cCastingExpr _
	( _
		_
	) as ASTNODE ptr

	'' CAST
	lexSkipToken( )

	function = hCast( FALSE )

end function

'':::::
'' PtrTypeCastingExpr	=   CPTR '(' DataType ',' Expression{int|uint|ptr} ')'
''
function cPtrTypeCastingExpr _
	( _
		_
	) as ASTNODE ptr

	'' CPTR
	lexSkipToken( )

	function = hCast( TRUE )

end function

'':::::
''DerefExpression	= 	DREF+ HighestPresExpr .
''
function cDerefExpression _
	( _
		_
	) as ASTNODE ptr

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
		return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if

	function = astBuildMultiDeref( derefcnt, _
								   expr, _
								   astGetFullType( expr ), _
								   astGetSubType( expr ) )

end function

'':::::
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
		return NULL
	end if

	if( symbCheckAccess( proc ) = FALSE ) then
		errReportEx( FB_ERRMSG_ILLEGALMEMBERACCESS, symbGetFullProcName( proc ) )
	end if

	'' call any necessary rtl callbacks...
	dim as FBRTLCALLBACK callback = symbGetProcCallback( proc )
	if( callback <> NULL ) then
		callback( proc )
	end if

	function = astBuildProcAddrof(proc)

end function

'':::::
private function hVarPtrBody _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = cHighestPrecExpr( base_parent, chain_ )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake a node
		return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if

	'' skip any casting if they won't do any conversion
	dim as ASTNODE ptr t = expr
	if( astIsCAST( expr ) ) then
		if( astGetCASTDoConv( expr ) = FALSE ) then
			t = astGetLeft( expr )
		end if
	end if

	select case as const astGetClass( t )
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_DEREF, AST_NODECLASS_TYPEINI

	case AST_NODECLASS_FIELD
		'' can't take address of bitfields..
		if( astGetDataType( astGetLeft( t ) ) = FB_DATATYPE_BITFIELD ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: fake a node
			astDelTree( expr )
			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

	case else
		errReportEx( FB_ERRMSG_INVALIDDATATYPES, "for @ or VARPTR" )
		'' error recovery: fake a node
		astDelTree( expr )
		return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end select

	'' check op overloading
	scope
    	dim as FBSYMBOL ptr proc = any
    	dim as FB_ERRMSG err_num = any

		proc = symbFindSelfUopOvlProc( AST_OP_ADDROF, expr, @err_num )
		if( proc <> NULL ) then
			'' build a proc call
			return astBuildCall( proc, expr, NULL )
		else
			if( err_num <> FB_ERRMSG_OK ) then
				return NULL
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
function cAddrOfExpression _
	( _
		_
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = NULL

	'' '@' (Proc ('('')')? | Variable)
	if( lexGetToken( ) = FB_TK_ADDROFCHAR ) then
		lexSkipToken( )

  		'' not inside a WITH block?
  		dim as integer check_id = TRUE
  		if( parser.stmt.with.sym <> NULL ) then
  			if( lexGetToken( ) = CHAR_DOT ) then
  				'' not a '..'?
  				check_id = (lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) = CHAR_DOT)
  			end if
		end if

  		'' check if the address of function is being taken
  		dim as FBSYMCHAIN ptr chain_ = NULL
  		dim as FBSYMBOL ptr sym = NULL, base_parent = NULL

		if( check_id ) then
			chain_ = cIdentifier( base_parent, _
							  	  FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT )
			sym = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
		end if

		'' proc?
		if( sym <> NULL ) then
			lexSkipToken( )
			return hProcPtrBody( base_parent, sym )

		'' anything else..
		else
			return hVarPtrBody( base_parent, chain_ )
		end if

	end if

	select case as const lexGetToken( )
	'' VARPTR '(' Variable ')'
	case FB_TK_VARPTR
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

    	expr = hVarPtrBody( NULL, NULL )
		if( expr = FALSE ) then
			return NULL
		end if

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if

	'' PROCPTR '(' Proc ('('')')? ')'
	case FB_TK_PROCPTR
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
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
			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		else
			lexSkipToken( )
		end if

		expr = hProcPtrBody( base_parent, sym )
		if( expr = NULL ) then
			return NULL
		end if

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if

	'' SADD|STRPTR '(' Variable{str} ')'
	case FB_TK_SADD, FB_TK_STRPTR
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		expr = cHighestPrecExpr( NULL, NULL )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		dim as integer dtype = astGetDataType( expr )

		if( symbIsString( dtype ) = FALSE ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			astDelTree( expr )
			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if

		'' check for invalid classes (functions, etc)

		'' skip any casting if they won't do any conversion
		dim as ASTNODE ptr t = expr
		if( astIsCAST( expr ) ) then
			if( astGetCASTDoConv( expr ) = FALSE ) then
				t = astGetLeft( expr )
			end if
		end if

		select case as const astGetClass( t )
		case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
			 AST_NODECLASS_DEREF, AST_NODECLASS_TYPEINI, _
			 AST_NODECLASS_FIELD

		case else
			errReportEx( FB_ERRMSG_INVALIDDATATYPES, "for STRPTR" )
		end select

		'' varlen? do: *cast( zstring ptr ptr, @expr )
		if( dtype = FB_DATATYPE_STRING ) then
			expr = astBuildStrPtr( expr )

		'' anything else: do cast( zstring ptr, @expr )
		else
			expr = astNewCONV( typeAddrOf( FB_DATATYPE_CHAR ), _
							   NULL, _
							   astNewADDROF( expr ) )
		end if

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if

	end select

	function = expr

end function
