'' binary operators (+, \, MOD, ...) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "rtl.bi"

declare function cLogOrExpression _
	( _
		_
	) as ASTNODE ptr

declare function cLogAndExpression _
	( _
		_
	) as ASTNODE ptr

declare function cIsExpression _
	( _
		_
	) as ASTNODE ptr

'':::::
''Expression      =   LogExpression .
''
function cExpression _
	( _
		_
	) as ASTNODE ptr

	dim as integer last_isexpr = fbGetIsExpression( )
	fbSetIsExpression( TRUE )

	'' LogExpression
	function = cBoolExpression( )

	fbSetIsExpression( last_isexpr )

end function

function cExpressionWithNIDXARRAY( byval allow_nidxarray as integer ) as ASTNODE ptr
	dim as integer oldcheckarray = any
	oldcheckarray = fbGetCheckArray( )
	fbSetCheckArray( not allow_nidxarray )
	function = cExpression( )
	fbSetCheckArray( oldcheckarray )
end function

'':::::
''BoolExpression      =   LogExpression ( (ANDALSO | ORELSE ) LogExpression )* .
''
function cBoolExpression( ) as ASTNODE ptr
	dim as integer op = any, dtorlistcookie = any
	dim as ASTNODE ptr expr = any, logexpr = any

	'' LogExpression
	'' The first operand expression will always be executed
	logexpr = cLogExpression( )
	if( logexpr = NULL ) then
		return NULL
	end if

	'' ( ... )*
	do
		'' Logical operator
		select case as const lexGetToken( )
		case FB_TK_ANDALSO
			op = AST_OP_ANDALSO
		case FB_TK_ORELSE
			op = AST_OP_ORELSE
		case else
			exit do
		end select

		'' Self-assignment? Then don't parse a BOP
		if( hIsAssignToken( lexGetLookAhead( 1 ) ) ) then
			exit do
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' LogExpression
		'' The second operand expression however only conditionally
		astDtorListScopeBegin( )
		expr = cLogExpression( )
		dtorlistcookie = astDtorListScopeEnd( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		logexpr = astNewBOP( op, logexpr, expr, cptr( any ptr, dtorlistcookie ) )
		if( logexpr = NULL ) then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a node
			logexpr = astNewCONSTi( 0 )
		end if
	loop

	function = logexpr
end function

'':::::
''LogExpression      =   LogOrExpression ( (XOR | EQV | IMP) LogOrExpression )* .
''
function cLogExpression _
	( _
		_
	) as ASTNODE ptr

	dim as integer op = any
	dim as ASTNODE ptr expr = any, logexpr = any

	'' LogOrExpression
	logexpr = cLogOrExpression( )
	if( logexpr = NULL ) then
		return NULL
	end if

	'' ( ... )*
	do
		'' Logical operator
		select case as const lexGetToken( )
		case FB_TK_XOR
			op = AST_OP_XOR
		case FB_TK_EQV
			op = AST_OP_EQV
		case FB_TK_IMP
			op = AST_OP_IMP
		case else
			exit do
		end select

		'' Self-assignment? Then don't parse a BOP
		if( hIsAssignToken( lexGetLookAhead( 1 ) ) ) then
			exit do
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' LogOrExpression
		expr = cLogOrExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		'' do operation
		logexpr = astNewBOP( op, logexpr, expr )

		if( logexpr = NULL ) then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a node
			logexpr = astNewCONSTi( 0 )
		end if

	loop

	function = logexpr

end function

'':::::
''LogOrExpression    =   LogAndExpression ( OR LogAndExpression )* .
''
function cLogOrExpression _
	( _
		_
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any, logexpr = any

	'' LogAndExpression
	logexpr = cLogAndExpression( )
	if( logexpr = NULL ) then
		return NULL
	end if

	'' ( ... )*
	do
		'' OR?
		if( lexGetToken( ) <> FB_TK_OR ) then
			exit do
		end if

		'' Self-assignment? Then don't parse a BOP
		if( hIsAssignToken( lexGetLookAhead( 1 ) ) ) then
			exit do
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' LogAndExpression
		expr = cLogAndExpression(  )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		'' do operation
		logexpr = astNewBOP( AST_OP_OR, logexpr, expr )

		if( logexpr = NULL ) then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a node
			logexpr = astNewCONSTi( 0 )
		end if

	loop

	function = logexpr

end function

'':::::
''LogAndExpression   =   RelExpression ( AND RelExpression )* .
''
function cLogAndExpression _
	( _
		_
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any, logexpr = any

	'' RelExpression
	logexpr = cRelExpression( )
	if( logexpr = NULL ) then
		return NULL
	end if

	'' ( ... )*
	do
		'' AND?
		if( lexGetToken( ) <> FB_TK_AND ) then
			exit do
		end if

		'' Self-assignment? Then don't parse a BOP
		if( hIsAssignToken( lexGetLookAhead( 1 ) ) ) then
			exit do
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' RelExpression
		expr = cRelExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		'' do operation
		logexpr = astNewBOP( AST_OP_AND, logexpr, expr )

		if( logexpr = NULL ) then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a node
			logexpr = astNewCONSTi( 0 )
		end if

	loop

	function = logexpr

end function

'':::::
''RelExpression   =   IsExpression ( (EQ | GT | LT | NE | LE | GE) IsExpression )* .
''
function cRelExpression _
	( _
		_
	) as ASTNODE ptr

	dim as integer op = any
	dim as ASTNODE ptr expr = any, relexpr = any

	'' IsExpression
	relexpr = cIsExpression(  )
	if( relexpr = NULL ) then
		return NULL
	end if

	'' ( ... )*
	do
		'' Relational operator
		select case as const lexGetToken( )
		case FB_TK_EQ
			parser.have_eq_outside_parens = (parser.prntcnt = 0)

			'' outside parentheses? (cParentExpression() would have
			'' unset this flag otherwise)
			if( fbGetEqInParensOnly( ) ) then
				exit do
			end if
			op = AST_OP_EQ
		case FB_TK_GT
			if( fbGetGtInParensOnly( ) ) then
				exit do
			end if
			op = AST_OP_GT
		case FB_TK_LT
			op = AST_OP_LT
		case FB_TK_NE
			op = AST_OP_NE
		case FB_TK_LE
			op = AST_OP_LE
		case FB_TK_GE
			op = AST_OP_GE
			assert( fbGetGtInParensOnly( ) = FALSE )
		case else
			exit do
		end select

		lexSkipToken( )

		'' IsExpression
		expr = cIsExpression(  )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		'' do operation
		relexpr = astNewBOP( op, relexpr, expr )

		if( relexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a node
			relexpr = astNewCONSTi( 0 )
		end if
	loop

	function = relexpr

end function

'':::::
''IsExpression   =   CatExpression IS SymbolType .
''
function cIsExpression _
	( _
		_
	) as ASTNODE ptr

	'' CatExpression
	dim as ASTNODE ptr isexpr = cCatExpression(  )
	if( isexpr = NULL ) then
		return NULL
	end if

	'' IS?
	if( lexGetToken( ) <> FB_TK_IS ) then
		return isexpr
	end if

	'' must be a struct with RTTI info
	if( astGetDataType( isexpr ) = FB_DATATYPE_STRUCT ) then
		if( symbGetHasRTTI( astGetSubtype( isexpr ) ) = FALSE ) then
			errReport( FB_ERRMSG_TYPEHASNORTTI )
			'' error recovery: fake a node
			isexpr = astNewCONSTi( 0 )
		end if
	else
		errReport( FB_ERRMSG_TYPEMUSTBEAUDT )
		'' error recovery: fake a node
		isexpr = astNewCONSTi( 0 )
	end if

	'' IS
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' SymbolType
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any
	if( cSymbolType( dtype, subtype ) = FALSE ) then
		return NULL
	end if

	'' must be a struct type with RTTI info
	if( typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_STRUCT ) then
		if( symbGetHasRTTI( subtype ) = FALSE ) then
			errReport( FB_ERRMSG_TYPEHASNORTTI )
			'' error recovery: fake a node
			return astNewCONSTi( 0 )

		elseif( symbGetUDTBaseLevel( subtype, astGetSubtype( isexpr ) ) = 0 ) then
			errReport( FB_ERRMSG_TYPESARENOTRELATED )
			'' error recovery: fake a node
			return astNewCONSTi( 0 )
		end if
	else
		errReport( FB_ERRMSG_TYPEMUSTBEAUDT )
		'' error recovery: fake a node
		return astNewCONSTi( 0 )
	end if

	'' point to the RTTI table
	var expr = astNewVAR( subtype->udt.ext->rtti )

	'' do operation
	isexpr = astNewBOP( AST_OP_IS, isexpr, expr )

	if( isexpr = NULL ) Then
		errReport( FB_ERRMSG_TYPEMISMATCH )
		'' error recovery: fake a node
		isexpr = astNewCONSTi( 0 )
	end if

	function = isexpr

end function

'':::::
''CatExpression   =   AddExpression ( & AddExpression )* .
''
function cCatExpression _
	( _
		_
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any, catexpr = any

	'' AddExpression
	catexpr = cAddExpression(  )
	if( catexpr = NULL ) then
		return NULL
	end if

	'' ( ... )*
	do
		'' &
		if( lexGetToken( ) <> CHAR_AMP ) then
			exit do
		end if

		'' Self-assignment? Then don't parse a BOP
		if( hIsAssignToken( lexGetLookAhead( 1 ) ) ) then
			exit do
		end if

		lexSkipToken( )

		'' AddExpression
		expr = cAddExpression(  )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		'' concatenate
		catexpr = astNewBOP( AST_OP_CONCAT, catexpr, expr )

		if( catexpr = NULL ) then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a new node
			catexpr = astNewCONSTstr( NULL )
		end if

	loop

	function = catexpr

end function

'':::::
''AddExpression   =   ShiftExpression ( ('+' | '-') ShiftExpression )* .
''
function cAddExpression _
	( _
		_
	) as ASTNODE ptr

	dim as integer op = any
	dim as ASTNODE ptr expr = any, addexpr = any

	'' ShiftExpression
	addexpr = cShiftExpression(  )
	if( addexpr = NULL ) then
		return NULL
	end if

	'' ( ... )*
	do
		'' Add operator
		select case lexGetToken( )
		case CHAR_PLUS
			op = AST_OP_ADD
		case CHAR_MINUS
			op = AST_OP_SUB
		case else
			exit do
		end select

		'' Self-assignment? Then don't parse a BOP
		if( hIsAssignToken( lexGetLookAhead( 1 ) ) ) then
			exit do
		end if

		lexSkipToken( )

		'' ShiftExpression
		expr = cShiftExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		addexpr = astNewBOP( op, _
		                     addexpr, _
		                     expr, _
		                     NULL, _
		                     AST_OPOPT_DEFAULT or AST_OPOPT_DOPTRARITH )

		if( addexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a node
			addexpr = astNewCONSTi( 0 )
		end if
	loop

	function = addexpr

end function

'':::::
''ShiftExpression  =   ModExpression ( (SHL | SHR) ModExpression )* .
''
function cShiftExpression _
	( _
		_
	) as ASTNODE ptr

	dim as integer op = any
	dim as ASTNODE ptr expr = any, shiftexpr = any

	'' ModExpression
	shiftexpr = cModExpression(  )
	if( shiftexpr = NULL ) then
		return NULL
	end if

	'' ( ... )*
	do
		'' Shift operator
		select case lexGetToken( )
		case FB_TK_SHL
			op = AST_OP_SHL
		case FB_TK_SHR
			op = AST_OP_SHR
		case else
			exit do
		end select

		'' Self-assignment? Then don't parse a BOP
		if( hIsAssignToken( lexGetLookAhead( 1 ) ) ) then
			exit do
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' ModExpression
		expr = cModExpression(  )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		'' do operation
		shiftexpr = astNewBOP( op, shiftexpr, expr )

		if( shiftexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a node
			shiftexpr = astNewCONSTi( 0 )
		end if
	loop

	function = shiftexpr

end function

'':::::
''ModExpression   =   IntDivExpression ( MOD IntDivExpression )* .
''
function cModExpression _
	( _
		_
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any, modexpr = any

	'' IntDivExpression
	modexpr = cIntDivExpression( )
	if( modexpr = NULL ) then
		return NULL
	end if

	'' ( ... )*
	do
		'' MOD
		if( lexGetToken( ) <> FB_TK_MOD ) then
			exit do
		end if

		'' Self-assignment? Then don't parse a BOP
		if( hIsAssignToken( lexGetLookAhead( 1 ) ) ) then
			exit do
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' IntDivExpression
		expr = cIntDivExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		'' do operation
		modexpr = astNewBOP( AST_OP_MOD, modexpr, expr )

		if( modexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a node
			modexpr = astNewCONSTi( 0 )
		end if
	loop

	function = modexpr

end function

'':::::
''IntDivExpression=   MultExpression ( '\' MultExpression )* .
''
function cIntDivExpression _
	( _
		_
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any, idivexpr = any

	'' MultExpression
	idivexpr = cMultExpression( )
	if( idivexpr = NULL ) then
		return NULL
	end if

	'' ( ... )*
	do
		'' '\'
		if( lexGetToken( ) <> CHAR_RSLASH ) then
			exit do
		end if

		'' Self-assignment? Then don't parse a BOP
		if( hIsAssignToken( lexGetLookAhead( 1 ) ) ) then
			exit do
		end if

		lexSkipToken( )

		'' MultExpression
		expr = cMultExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		'' do operation
		idivexpr = astNewBOP( AST_OP_INTDIV, idivexpr, expr )

		if( idivexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a node
			idivexpr = astNewCONSTi( 0 )
		end if
	loop

	function = idivexpr

end function

'':::::
''MultExpression  =   ExpExpression ( ('*' | '/') ExpExpression )* .
''
function cMultExpression _
	( _
		_
	) as ASTNODE ptr

	dim as integer op = any
	dim as ASTNODE ptr expr = any, mulexpr = any

	'' ExpExpression
	mulexpr = cExpExpression( )
	if( mulexpr = NULL ) then
		return NULL
	end if

	'' ( ... )*
	do
		'' Mult operator
		select case lexGetToken( )
		case CHAR_TIMES
			op = AST_OP_MUL
		case CHAR_SLASH
			op = AST_OP_DIV
		case else
			exit do
		end select

		'' Self-assignment? Then don't parse a BOP
		if( hIsAssignToken( lexGetLookAhead( 1 ) ) ) then
			exit do
		end if

		lexSkipToken( )

		'' ExpExpression
		expr = cExpExpression(  )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		'' do operation
		mulexpr = astNewBOP( op, mulexpr, expr )

		if( mulexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a node
			mulexpr = astNewCONSTi( 0 )
		end if
	loop

	function = mulexpr

end function

'':::::
''ExpExpression   =   NegNotExpression ( '^' NegNotExpression )* .
''
function cExpExpression _
	( _
		_
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any, expexpr = any

	'' NegNotExpression
	expexpr = cNegNotExpression( )
	if( expexpr = NULL ) then
		return NULL
	end if

	'' ( '^' NegNotExpression )*
	do
		if( lexGetToken( ) <> CHAR_CART ) then
			exit do
		end if

		'' Self-assignment? Then don't parse a BOP
		if( hIsAssignToken( lexGetLookAhead( 1 ) ) ) then
			exit do
		end if

		lexSkipToken( )

		'' NegNotExpression
		expr = cNegNotExpression(  )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit do
		end if

		'' do operation
		expexpr = astNewBOP( AST_OP_POW, expexpr, expr )

		if( expexpr = NULL ) Then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a node
			expexpr = astNewCONSTf( 0, FB_DATATYPE_DOUBLE )
		end if
	loop

	function = expexpr

end function
