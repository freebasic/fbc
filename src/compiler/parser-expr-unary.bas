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
	is_defined = (cIdentifierOrUDTMember( ) <> NULL)

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
''                |   NOT RelExpression
''                |   HighestPresExpr .
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

		'' '.'?
		case CHAR_DOT
			errReport( FB_ERRMSG_EXPECTEDUDT, TRUE )

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
''                |   ( DerefExpr
''                    | CastingExpr
''                    | PtrTypeCastingExpr
''                    | ParentExpression
''                    ) FuncPtrOrMemberDeref?
''                |   AnonType
''                |   Atom .
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
		'' '@' starts an expression and any `()` seen next is handled
		'' as not optional and the closing ')' should not end the expression
		fbSetPrntOptional( FALSE )

		return cAddrOfExpression( )

	'' DerefExpr
	case FB_TK_DEREFCHAR
		'' '*' starts an expression and any `()` seen next is handled
		'' as not optional and the closing ')' should not end the expression
		fbSetPrntOptional( FALSE )

		return cDerefExpression( )

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

			'' We are at the highest precedence level for expressions so we
			'' must be in an expression, any `()` seen next is handled
			'' as not optional and the closing ')' should not end the expression
			'' Optional parentheses will be enabled again on the next call in
			'' to cProcCall().
			fbSetPrntOptional( FALSE )

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

	expr = astNewCONV( dtype, subtype, expr, options or AST_CONVOPT_EXACT_CAST, @errmsg )
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
''DerefExpression   =   DREF+ HighestPresExpr .
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

private function hProcPtrResolveOverload _
	( _
		byval ovl_head_proc as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval check_exact as boolean = FALSE _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = ovl_head_proc

	if( symbIsOperator( ovl_head_proc ) ) then
		dim as AST_OP op = any
		op = symbGetProcOpOvl( ovl_head_proc )
		sym = symbFindOpOvlProc( op, ovl_head_proc, proc )

	elseif( symbIsProc( proc ) ) then
		dim findopts as FB_SYMBFINDOPT = FB_SYMBFINDOPT_NONE

		'' if it is a property then let the function pointer decide
		'' if we are looking for the set or get procedure where
		'' get is expected to have a return type
		if( symbIsProperty( ovl_head_proc ) ) then
			if( symbGetType( proc ) <> FB_DATATYPE_VOID ) then
				findopts = FB_SYMBFINDOPT_PROPGET
			end if
		end if
		sym = symbFindOverloadProc( ovl_head_proc, proc, findopts )

	end if

	return sym
end function

private sub hCheckEmptyProcParens()
	'' '('')'?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if
	end if
end sub

private function hProcPtrBody _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval check_exact as boolean, _
		byval is_vtable_index as integer _
	) as ASTNODE ptr

	assert( proc <> NULL )
	assert( symbIsProc( proc ) )

	'' resolve overloaded procs
	if( parser.ctxsym <> NULL ) then
		if( symbIsOverloaded( proc ) or check_exact ) then
			dim as FBSYMBOL ptr sym = any
			sym = hProcPtrResolveOverload( proc, parser.ctxsym )

			if( sym ) then
				proc = sym
			elseif( check_exact ) then
				errReport( FB_ERRMSG_NOMATCHINGPROC, TRUE )
				return astNewCONSTi( 0 )
			end if
		end if

	end if

	'' Check visibility of the proc
	if( symbCheckAccess( proc ) = FALSE ) then
		errReportEx( FB_ERRMSG_ILLEGALMEMBERACCESS, symbGetFullProcName( proc ) )
	end if

	'' call any necessary rtl callbacks...
	dim as FBRTLCALLBACK callback = symbGetProcCallback( proc )
	if( callback <> NULL ) then
		callback( proc )
	end if

	if( is_vtable_index ) then
		'' if not virtual or abstract then procedure doesn't exist in
		'' the virtual table.  Don't throw an error, just return an
		'' invalid vtable offset.  vtable offsets are something that
		'' the user will have to deal with anyway
		dim as integer vtableindex = -1

		if( symbIsAbstract( proc ) or symbIsVirtual( proc ) ) then
			vtableindex = ( symbProcGetVtableIndex( proc ) - 2 )
		endif

		var expr = astNewCONSTi( vtableindex )
		return expr
	end if

	if( symbIsAbstract( proc ) )then
		'' member is abstract and is not something we can get the address of
		'' until a virtual lookup at runtime ...
		'' return a null pointer of the function pointer instead

		var expr = astNewCONSTi( 0 )
		expr = astNewCONV( typeAddrOf( FB_DATATYPE_FUNCTION ), symbAddProcPtrFromFunction( proc ), expr )
		return expr
	end if

	return astBuildProcAddrof( proc )
end function

'' PROCPTR '(' Proc ('('')')? ( ',' VIRTUAL? ( ANY|signature )? )? ')'
function cProcPtrBody _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr sym = any, base_parent = any
	dim as ASTNODE ptr expr = any
	dim as integer is_vtable_index = FALSE

	if( dtype = FB_DATATYPE_STRUCT ) then
		base_parent = subtype
		chain_ = NULL

	else
		chain_ = cIdentifier( base_parent, _
		                      FB_IDOPT_CHECKSTATIC or _
		                      FB_IDOPT_ALLOWSTRUCT or _
		                      FB_IDOPT_ALLOWOPERATOR )

	end if

	sym = cIdentifierOrUDTMember( base_parent, chain_ )

	if( sym = NULL ) then
		errReport( FB_ERRMSG_UNDEFINEDSYMBOL )
		'' error recovery: skip until ')' and fake a node
		hSkipUntil( CHAR_RPRNT, TRUE )
		return astNewCONSTi( 0 )
	end if

	if( symbGetClass( sym ) <> FB_SYMBCLASS_PROC ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
		'' error recovery: skip until ')' and fake a node
		hSkipUntil( CHAR_RPRNT, TRUE )
		return astNewCONSTi( 0 )
	end if

	hCheckEmptyProcParens()

	'' ','?
	if( hMatch( CHAR_COMMA ) ) then
		dim as integer dtype = FB_DATATYPE_VOID
		dim as FBSYMBOL ptr subtype = NULL
		dim as integer is_exact = FALSE

		'' VIRTUAL?
		if( lexGetToken( ) = FB_TK_VIRTUAL ) then
			is_vtable_index = TRUE
			lexSkipToken( LEXCHECK_POST_SUFFIX )
		end if

		'' only if anything but ')' follows...
		if( lexGetToken( ) <> CHAR_RPRNT ) then
			if( cSymbolType( dtype, subtype ) = FALSE ) then
				errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
				'' error recovery: skip until ')' and fake a node
				hSkipUntil( CHAR_RPRNT, TRUE )
				return astNewCONSTi( 0 )
			end if

			select case typeGetDtAndPtrOnly( dtype )
			case FB_DATATYPE_VOID
				'' 'ANY' matches first declaration
			case typeAddrOf( FB_DATATYPE_FUNCTION )
				is_exact = TRUE
			case else
				errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
				'' error recovery: skip until ')' and fake a node
				hSkipUntil( CHAR_RPRNT, TRUE )
				return astNewCONSTi( 0 )
			end select
		end if

		dim as FBSYMBOL ptr oldsym = parser.ctxsym
		dim as integer old_dtype = parser.ctx_dtype
		parser.ctxsym = subtype
		parser.ctx_dtype = dtype

		expr = hProcPtrBody( base_parent, sym, is_exact, is_vtable_index )

		parser.ctxsym = oldsym
		parser.ctx_dtype = old_dtype

	else
		expr = hProcPtrBody( base_parent, sym, FALSE, is_vtable_index )
	end if

	return expr
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
''                  |   PROCPTR '(' Proc ('('')')? ')'
''                  |   '@' (Proc ('('')')? | HighPrecExpr)
''                  |   SADD|STRPTR '(' Variable{str}|Const{str}|Literal{str} ')' .
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
			hCheckEmptyProcParens()
			return hProcPtrBody( base_parent, sym, FALSE, FALSE )
		end if

		'' anything else
		return hVarPtrBody( base_parent, chain_ )
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

	'' PROCPTR '(' Proc ('('')')? ( ',' VIRTUAL? ( ANY|signature )? )? ')'
	case FB_TK_PROCPTR
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
			'' error recovery: skip until ')' and fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			return astNewCONSTi( 0 )
		end if

		expr = cProcPtrBody( 0, NULL )

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
