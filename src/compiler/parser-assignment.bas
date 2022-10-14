'' assignments (including LET) or function-pointer calls (foo()) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
sub parserLetInit

	listInit( @parser.stmt.let.list, 16, len( FB_LETSTMT_NODE ) )

end sub

'':::::
sub parserLetEnd

	listEnd( @parser.stmt.let.list )

end sub

function hIsAssignToken( byval token as integer ) as integer
	function = (token = FB_TK_ASSIGN) or (token = FB_TK_DBLEQ)
end function

function cAssignToken( ) as integer
	if( hIsAssignToken( lexGetToken( ) ) ) then
		lexSkipToken( )
		function = TRUE
	else
		function = FALSE
	end if
end function

function cOperator( byval is_overload as integer ) as integer
	dim as integer op = any, tk = any

	function = INVALID
	op = INVALID

	tk = lexGetToken( )
	select case as const( tk )
	case FB_TK_AND     : op = AST_OP_AND
	case FB_TK_OR      : op = AST_OP_OR
	case FB_TK_ANDALSO : op = AST_OP_ANDALSO
	case FB_TK_ORELSE  : op = AST_OP_ORELSE
	case FB_TK_XOR     : op = AST_OP_XOR
	case FB_TK_EQV     : op = AST_OP_EQV
	case FB_TK_IMP     : op = AST_OP_IMP
	case FB_TK_SHL     : op = AST_OP_SHL
	case FB_TK_SHR     : op = AST_OP_SHR
	case FB_TK_MOD     : op = AST_OP_MOD
	case CHAR_PLUS     : op = AST_OP_ADD
	case CHAR_MINUS    : op = AST_OP_SUB
	case CHAR_RSLASH   : op = AST_OP_INTDIV
	case CHAR_TIMES    : op = AST_OP_MUL
	case CHAR_SLASH    : op = AST_OP_DIV
	case CHAR_CART     : op = AST_OP_POW
	case CHAR_AMP      : op = AST_OP_CONCAT
	case FB_TK_EQ, FB_TK_GT, FB_TK_LT, FB_TK_NE, FB_TK_LE, FB_TK_GE, _
	     FB_TK_LET, FB_TK_NOT, FB_TK_CAST, _
	     FB_TK_ABS, FB_TK_SGN, FB_TK_FIX, FB_TK_FRAC, _
	     FB_TK_INT, FB_TK_EXP, FB_TK_LOG, FB_TK_SIN, _
	     FB_TK_ASIN, FB_TK_COS, FB_TK_ACOS, FB_TK_TAN, _
	     FB_TK_ATN, FB_TK_SQR, FB_TK_LEN, _
	     FB_TK_ADDROFCHAR, FB_TK_FIELDDEREF, CHAR_LBRACKET, _
	     FB_TK_NEW, FB_TK_DELETE, _
	     FB_TK_FOR, FB_TK_STEP, FB_TK_NEXT

		if( is_overload = FALSE ) then
			exit function
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		select case as const( tk )
		case FB_TK_EQ   : op = AST_OP_EQ
		case FB_TK_GT   : op = AST_OP_GT
		case FB_TK_LT   : op = AST_OP_LT
		case FB_TK_NE   : op = AST_OP_NE
		case FB_TK_LE   : op = AST_OP_LE
		case FB_TK_GE   : op = AST_OP_GE
		case FB_TK_LET  : op = AST_OP_ASSIGN
		case FB_TK_NOT  : op = AST_OP_NOT
		case FB_TK_CAST : op = AST_OP_CAST
		case FB_TK_ABS  : op = AST_OP_ABS
		case FB_TK_SGN  : op = AST_OP_SGN
		case FB_TK_FIX  : op = AST_OP_FIX
		case FB_TK_FRAC : op = AST_OP_FRAC
		case FB_TK_INT  : op = AST_OP_FLOOR
		case FB_TK_EXP  : op = AST_OP_EXP
		case FB_TK_LOG  : op = AST_OP_LOG
		case FB_TK_SIN  : op = AST_OP_SIN
		case FB_TK_ASIN : op = AST_OP_ASIN
		case FB_TK_COS  : op = AST_OP_COS
		case FB_TK_ACOS : op = AST_OP_ACOS
		case FB_TK_TAN  : op = AST_OP_TAN
		case FB_TK_ATN  : op = AST_OP_ATAN
		case FB_TK_SQR  : op = AST_OP_SQRT
		case FB_TK_LEN  : op = AST_OP_LEN
		case FB_TK_ADDROFCHAR : op = AST_OP_ADDROF
		case FB_TK_FIELDDEREF : op = AST_OP_FLDDEREF
		case CHAR_LBRACKET  '' '['
			'' ']'
			if( hMatch( CHAR_RBRACKET ) = FALSE ) then
				errReport( FB_ERRMSG_EXPECTEDRBRACKET )
			end if

			op = AST_OP_PTRINDEX

		case FB_TK_NEW, FB_TK_DELETE
			dim as integer is_new = (tk = FB_TK_NEW)

			'' '['?
			if( hMatch( CHAR_LBRACKET ) ) then
				'' ']'
				if( hMatch( CHAR_RBRACKET ) = FALSE  ) then
					errReport( FB_ERRMSG_EXPECTEDRBRACKET )
				end if

				op = iif( is_new, AST_OP_NEW_VEC_SELF, AST_OP_DEL_VEC_SELF )
			else
				op = iif( is_new, AST_OP_NEW_SELF, AST_OP_DEL_SELF )
			end if

		case FB_TK_FOR  : op = AST_OP_FOR
		case FB_TK_STEP : op = AST_OP_STEP
		case FB_TK_NEXT : op = AST_OP_NEXT
		case else
			assert( FALSE )
		end select

		return op
	case else
		exit function
	end select

	lexSkipToken( LEXCHECK_POST_SUFFIX )

	if( is_overload = FALSE ) then
		return op
	end if

	'' '='?
	if( cAssignToken( ) ) then
		'' get the self version
		op = astGetOpSelfVer( op )
	end if

	function = op
end function

sub cAssignment( byval l as ASTNODE ptr )
	if( astIsConstant( l ) ) then
		errReport( FB_ERRMSG_CONSTANTCANTBECHANGED, TRUE )
	end if

	'' '='?
	dim as integer op = INVALID
	if( hIsAssignToken( lexGetToken( ) ) = FALSE ) then
		'' BOP?
		op = cOperator( FALSE )

		'' '='?
		if( hIsAssignToken( lexGetToken( ) ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDEQ )
			'' error recovery: skip stmt
			hSkipStmt( )
			return
		end if

		'' get the self version
		op = astGetOpSelfVer( op )
	end if

	'' '='
	lexSkipToken( )

	'' set the context symbol to allow taking the address of overloaded
	'' procs and also to allow anonymous UDT's
	parser.ctxsym    = astGetSubType( l )
	parser.ctx_dtype = astGetDataType( l )

	'' Expression
	dim as ASTNODE ptr r = cExpression( )
	if( r = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: skip until next stmt
		hSkipStmt( )
		return
	end if

	parser.ctxsym    = NULL
	parser.ctx_dtype = FB_DATATYPE_INVALID

	'' BOP?
	if( op <> INVALID ) then
		'' l op= r
		l = astNewSelfBOP( op, l, r, NULL, AST_OPOPT_LPTRARITH )
		if (l) then
			astAdd(l)
		else
			errReport( FB_ERRMSG_TYPEMISMATCH, TRUE )
		end if
	else
		'' l = r
		l = astNewASSIGN( l, r )
		if (l) then
			astAdd(l)
		else
			errReport( FB_ERRMSG_ILLEGALASSIGNMENT, TRUE )
		end if
	end if
end sub

function cAssignmentOrPtrCallEx( byval expr as ASTNODE ptr ) as integer
	function = FALSE

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
		exit function
	end if

	'' Not just calling a SUB?
	if( expr ) then
		'' If it's a CALL, ignore the result.
		'' Otherwise it must be an ordinary assignment.
		if( cMaybeIgnoreCallResult( expr ) = FALSE ) then
			cAssignment( expr )
		end if
	end if

	function = TRUE
end function

'':::::
private function hCard2Ord _
	( _
		byval num as integer _
	) as const zstring ptr

	select case num
	case 1
		return @"1st"
	case 2
		return @"2nd"
	case 3
		return @"3rd"
	case else
		static as string tmp
		tmp = str( num ) + "th"
		return strptr( tmp )
	end select

end function

private sub hReportLetError(byval errnum as integer, byval elmnum as integer)
	errReportEx( errnum, "at the " + *hCard2Ord( elmnum ) + " element of LET()" )
end sub

'':::::
private function hAssignFromField _
	( _
		byval fld as FBSYMBOL ptr, _
		byval lhs as ASTNODE ptr, _
		byval rhs as FBSYMBOL ptr, _
		byval num as integer _
	) as ASTNODE ptr

	'' data member?
	if( symbIsField( fld ) = FALSE ) then
		hReportLetError( FB_ERRMSG_NOTADATAMEMBER, num )
		'' error recovery
		astDelTree( lhs )
		return astNewNOP( )
	end if

	'' Check visibility of the field
	if( symbCheckAccess( fld ) = FALSE ) then
		hReportLetError( FB_ERRMSG_ILLEGALMEMBERACCESS, num )
		'' error recovery
		astDelTree( lhs )
		return astNewNOP()
	end if

	if( symbGetArrayDimensions( fld ) <> 0 ) then
		hReportLetError( FB_ERRMSG_ARRAYSNOTALLOWED, num )
		'' error recovery
		astDelTree( lhs )
		return astNewNOP()
	end if

	'' build field access
	dim as ASTNODE ptr expr = any
	expr = astNewVAR( rhs )
	expr = astNewBOP( AST_OP_ADD, expr, astNewCONSTi( symbGetOfs( fld ) ) )
	expr = astNewDEREF( expr, symbGetFullType( fld ), symbGetSubType( fld ) )
	expr = astNewFIELD( expr, fld )

	expr = astNewASSIGN( lhs, expr )
	if( expr = NULL ) then
		hReportLetError( FB_ERRMSG_ILLEGALASSIGNMENT, num )
		'' error recovery
		return astNewNOP()
	end if

	function = expr

end function

'':::::
''Assignment      =   LET? Variable BOP? '=' Expression
''                |   Variable{function ptr} '(' ProcParamList ')' .
''
function cAssignmentOrPtrCall _
	( _
		_
	) as integer

	dim as integer ismult = FALSE
	dim as ASTNODE ptr expr = any
	dim as FBSYMBOL ptr fld = any

	function = FALSE

	'' not LET?
	if( lexGetToken( ) <> FB_TK_LET ) then
		'' Variable
		'' ... or anything else that can appear on the lhs of an assignment.
		'' As a special case, we allow all casts here for now (while normally
		'' only noconv casts are allowed on lhs of assignments), see below...
		expr = cVarOrDeref( FB_VAREXPROPT_ALLOWALLCASTS )
		if( expr = NULL ) then
			exit function
		end if

		'' If it's a function CALL, check whether we're ignoring the result
		if( cMaybeIgnoreCallResult( expr ) ) then
			return TRUE
		end if

		'' Couldn't ignore function result; maybe it's not a CALL at all.
		'' Undo the effects of FB_VAREXPROPT_ALLOWALLCASTS: Complain if there
		'' are not just noconv casts.
		if( astSkipNoConvCAST( expr ) <> astSkipCASTs( expr ) ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if

		return cAssignmentOrPtrCallEx( expr )
	end if

	'' LET..
	if( fbLangOptIsSet( FB_LANG_OPT_LET ) = FALSE ) then
		if( lexGetLookAhead( 1 ) <> CHAR_LPRNT ) then
			errReportNotAllowed( FB_LANG_OPT_LET )
		else
			ismult = TRUE
			'' 'LET'
			lexSkipToken( LEXCHECK_POST_SUFFIX )
		end if
	end if

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
		exit function
	end if

	'' LET | '('
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' single?
	if( ismult = FALSE ) then
		expr = cVarOrDeref( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			'' error recovery: skip stmt
			hSkipStmt( )
		else
			cAssignment( expr )
		end if
		return TRUE
	end if

	'' multiple..
	dim as integer exprcnt = 0

	do
		'' null expressions are allowed ('let(foo, , bar)')
		dim as FB_LETSTMT_NODE ptr node = listNewNode( @parser.stmt.let.list )

		node->expr = cVarOrDeref( )
		if( node->expr <> NULL ) then
			'' const?
			if( astIsConstant( node->expr ) ) then
				errReport( FB_ERRMSG_CONSTANTCANTBECHANGED, TRUE )
			end if

			exprcnt += 1
		end if

		'' ','?
		if( lexGetToken( ) <> CHAR_COMMA ) then
			exit do
		end if

		lexSkipToken( )
	loop

	if( exprcnt = 0 ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
	end if

	'' ')'?
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDRPRNT )
		'' error recovery: skip until next ')'
		hSkipUntil( CHAR_RPRNT )
	else
		lexSkipToken( )
	end if

	'' '='?
	if( cAssignToken( ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDEQ )
		'' error recovery: skip stmt
		hSkipStmt( )
		expr = NULL
	else
		'' Expression?
		expr = cExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: skip until next stmt
			hSkipStmt( )
		end if
	end if

	if( expr <> NULL ) then
		select case astGetDataType( expr )
		case FB_DATATYPE_STRUCT
			if( symbGetUDTIsUnion( astGetSubtype( expr ) ) or _
			    symbGetUDTHasAnonUnion( astGetSubtype( expr ) ) ) then
				errReport( FB_ERRMSG_UNIONSNOTALLOWED )
				'' error recovery:
				astDelTree( expr )
				expr = NULL
			end if

		''case FB_DATATYPE_CLASS

		case else
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery:
			astDelTree( expr )
			expr = NULL
		end select
	end if

	if( expr = NULL ) then
		do
			dim as FB_LETSTMT_NODE ptr node = listGetHead( @parser.stmt.let.list )
			if( node = NULL ) then
				exit do
			end if

			listDelNode( @parser.stmt.let.list, node )
		loop

		exit function
	end if

	'' proc call?
	if( astIsCALL( expr ) ) then
		expr = astBuildCallResultUdt( expr )
	end if

	dim as FBSYMBOL ptr tmp = NULL
	dim as ASTNODE ptr tree = NULL

	if( exprcnt > 0 ) then
		tmp = symbAddTempVar( typeAddrOf( astGetFulltype( expr ) ), astGetSubtype( expr ) )
		'' tmp = @expr
		tree = astBuildVarAssign( tmp, astNewADDROF( expr ), AST_OPOPT_ISINI )
	end if

	fld = symbUdtGetFirstField( astGetSubtype( expr ) )
	exprcnt = 0
	do
		dim as FB_LETSTMT_NODE ptr node = listGetHead( @parser.stmt.let.list )
		if( node = NULL ) then
			exit do
		end if

		'' EOL?
		if( fld = NULL ) then
			errReport( FB_ERRMSG_TOOMANYELEMENTS )
		else
			exprcnt += 1

			if( node->expr <> NULL ) then
				expr = hAssignFromField( fld, node->expr, tmp, exprcnt )
				if( expr = NULL ) then
					exit function
				end if

				tree = astNewLINK( tree, expr, AST_LINK_RETURN_NONE )
			end if

			fld = symbUdtGetNextField( fld )
		end if

		listDelNode( @parser.stmt.let.list, node )
	loop

	'' must add the tree at once because the temporary results
	'' that may need to be destroyed
	astAdd( tree )

	function = TRUE
end function
