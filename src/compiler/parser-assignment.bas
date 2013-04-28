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

'':::::
function cOperator _
	( _
		byval options as FB_OPEROPTS _
	) as integer

	dim as integer op = any

    function = INVALID

    select case as const lexGetToken( )
    case FB_TK_AND
    	op = AST_OP_AND

	case FB_TK_OR
    	op = AST_OP_OR

	case FB_TK_ANDALSO
	op = AST_OP_ANDALSO

	case FB_TK_ORELSE
	op = AST_OP_ORELSE

	case FB_TK_XOR
    	op = AST_OP_XOR

	case FB_TK_EQV
		op = AST_OP_EQV

	case FB_TK_IMP
		op = AST_OP_IMP

	case FB_TK_SHL
    	op = AST_OP_SHL

	case FB_TK_SHR
    	op = AST_OP_SHR

	case FB_TK_MOD
    	op = AST_OP_MOD

   	case FB_TK_EQ
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_EQ

   	case FB_TK_GT
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_GT

   	case FB_TK_LT
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_LT

   	case FB_TK_NE
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_NE

   	case FB_TK_LE
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_LE

   	case FB_TK_GE
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_GE

	case FB_TK_LET
    	if( (options and FB_OPEROPTS_ASSIGN) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_ASSIGN

    case FB_TK_NOT
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_NOT

    case FB_TK_CAST
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_CAST

	case FB_TK_ABS
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_ABS

	case FB_TK_SGN
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_SGN

	case FB_TK_FIX
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_FIX

	case FB_TK_FRAC
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_FRAC

	case FB_TK_INT
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_FLOOR

	case FB_TK_EXP
		if( (options and FB_OPEROPTS_UNARY) = 0 ) then
			exit function
		end if

		lexSkipToken( )
		return AST_OP_EXP

	case FB_TK_LOG
		if( (options and FB_OPEROPTS_UNARY) = 0 ) then
			exit function
		end if

		lexSkipToken( )
		return AST_OP_LOG

	case FB_TK_SIN
		if( (options and FB_OPEROPTS_UNARY) = 0 ) then
			exit function
		end if

		lexSkipToken( )
		return AST_OP_SIN

	case FB_TK_ASIN
		if( (options and FB_OPEROPTS_UNARY) = 0 ) then
			exit function
		end if

		lexSkipToken( )
		return AST_OP_ASIN

	case FB_TK_COS
		if( (options and FB_OPEROPTS_UNARY) = 0 ) then
			exit function
		end if

		lexSkipToken( )
		return AST_OP_COS

	case FB_TK_ACOS
		if( (options and FB_OPEROPTS_UNARY) = 0 ) then
			exit function
		end if

		lexSkipToken( )
		return AST_OP_ACOS

	case FB_TK_TAN
		if( (options and FB_OPEROPTS_UNARY) = 0 ) then
			exit function
		end if

		lexSkipToken( )
		return AST_OP_TAN

	case FB_TK_ATN
		if( (options and FB_OPEROPTS_UNARY) = 0 ) then
			exit function
		end if

		lexSkipToken( )
		return AST_OP_ATAN

	case FB_TK_FIELDDEREF
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_FLDDEREF

	case FB_TK_NEW, FB_TK_DELETE

		if( (options and FB_OPEROPTS_SELF) = 0 ) then
			exit function
		end if

		dim as integer is_new = (lexGetToken( ) = FB_TK_NEW)

		lexSkipToken( )

		'' '['?
		if( lexGetToken( ) = CHAR_LBRACKET ) then
			lexSkipToken( )

			'' ']'
			if( lexGetToken( ) <> CHAR_RBRACKET ) then
				errReport( FB_ERRMSG_EXPECTEDRBRACKET )
			else
				lexSkipToken( )
			end if

			return iif( is_new, AST_OP_NEW_VEC_SELF, AST_OP_DEL_VEC_SELF )
		else
			return iif( is_new, AST_OP_NEW_SELF, AST_OP_DEL_SELF )
		end if

	case FB_TK_FOR
		if( (options and FB_OPEROPTS_SELF) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_FOR

	case FB_TK_STEP
    	if( (options and FB_OPEROPTS_SELF) = 0 ) then
        	exit function
        end if

		lexSkipToken( )
		return AST_OP_STEP

	case FB_TK_NEXT
		if( (options and FB_OPEROPTS_SELF) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_NEXT

	case CHAR_PLUS
		op = AST_OP_ADD

	case CHAR_MINUS
		op = AST_OP_SUB

	case CHAR_RSLASH
		op = AST_OP_INTDIV

	case CHAR_TIMES
		op = AST_OP_MUL

	case CHAR_SLASH
		op = AST_OP_DIV

	case CHAR_CART
		op = AST_OP_POW

	case CHAR_AMP
		op = AST_OP_CONCAT

	case FB_TK_ADDROFCHAR
		if( (options and FB_OPEROPTS_UNARY) = 0 ) then
			exit function
		end if

		lexSkipToken( )
		return AST_OP_ADDROF

	case else
		exit function
	end select

    lexSkipToken( )

    if( (options and FB_OPEROPTS_SELF) = 0 ) then
    	return op
    end if

    '' '='?
    if( lexGetToken( ) = FB_TK_ASSIGN ) then
    	lexSkipToken( )
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
	if( lexGetToken( ) <> FB_TK_ASSIGN ) then
		'' BOP?
		op = cOperator( FB_OPEROPTS_NONE )

		'' '='?
		if( lexGetToken( ) <> FB_TK_ASSIGN ) then
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

'':::::
function cAssignmentOrPtrCallEx _
	( _
		byval expr as ASTNODE ptr _
	) as integer

    function = FALSE

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
    	exit function
    end if

    '' calling a SUB ptr?
    if( expr = NULL ) then
    	return TRUE
    end if

	'' skip any casting if they won't do any conversion
	dim as ASTNODE ptr t = expr
	if( astIsCAST( expr ) ) then
		if( astGetCASTDoConv( expr ) = FALSE ) then
			t = astGetLeft( expr )
		end if
	end if

    '' ordinary assignment?
    if( astIsCALL( t ) = FALSE ) then
		cAssignment( expr )
		return TRUE
    end if

	'' calling a function ptr..

	'' can the result be skipped?
	if( typeGetClass( astGetDataType( t ) ) <> FB_DATACLASS_INTEGER ) then
		errReport( FB_ERRMSG_VARIABLEREQUIRED )
		'' error recovery: skip call
		astDelTree( expr )
		return TRUE

    '' CHAR and WCHAR literals are also from the INTEGER class
    else
    	select case astGetDataType( t )
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			errReport( FB_ERRMSG_VARIABLEREQUIRED )
			'' error recovery: skip call
			astDelTree( expr )
			return TRUE
		end select
	end if

    '' flush the call
    if( expr <> NULL ) then
    	astAdd( expr )
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

	'' check visibility
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
''				  |	  Variable{function ptr} '(' ProcParamList ')' .
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
		expr = cVarOrDeref( )
		if( expr = NULL ) then
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
    		lexSkipToken( )
    	end if
    end if

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
    	exit function
    end if

	lexSkipToken( )

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
	if( lexGetToken( ) <> FB_TK_ASSIGN ) then
		errReport( FB_ERRMSG_EXPECTEDEQ )
		'' error recovery: skip stmt
		hSkipStmt( )
		expr = NULL
	else
		lexSkipToken( )

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
		tree = astBuildVarAssign( tmp, astNewADDROF( expr ) )
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

        		tree = astNewLINK( tree, expr )
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
