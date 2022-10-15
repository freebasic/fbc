'' quirk casting functions (CBYTE, CSHORT, CINT, ...) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
''TypeConvExpr      =    (C### '(' expression ')') .
''
function cTypeConvExpr _
	( _
		byval tk as FB_TOKEN, _
		byval isASM as integer = FALSE _
	) as ASTNODE ptr

	dim as integer dtype = any, op = any, errmsg = any
	dim as ASTNODE ptr expr = any

	dtype = FB_DATATYPE_INVALID
	op = INVALID

	select case as const tk
	case FB_TK_CBOOL
		dtype = FB_DATATYPE_BOOLEAN

	case FB_TK_CBYTE
		dtype = FB_DATATYPE_BYTE

	case FB_TK_CUBYTE
		dtype = FB_DATATYPE_UBYTE

	case FB_TK_CSHORT
		dtype = FB_DATATYPE_SHORT

	case FB_TK_CUSHORT
		dtype = FB_DATATYPE_USHORT

	case FB_TK_CINT
		dtype = env.lang.integerkeyworddtype

	case FB_TK_CUINT
		dtype = FB_DATATYPE_UINT

	case FB_TK_CLNG
		dtype = FB_DATATYPE_LONG

	case FB_TK_CULNG
		dtype = FB_DATATYPE_ULONG

	case FB_TK_CLNGINT
		dtype = FB_DATATYPE_LONGINT

	case FB_TK_CULNGINT
		dtype = FB_DATATYPE_ULONGINT

	case FB_TK_CSNG
		dtype = FB_DATATYPE_SINGLE

	case FB_TK_CDBL
		dtype = FB_DATATYPE_DOUBLE

	case FB_TK_CSIGN
		op = AST_OP_TOSIGNED

	case FB_TK_CUNSG
		op = AST_OP_TOUNSIGNED

	end select

	if( dtype = FB_DATATYPE_INVALID ) then
		if( op = INVALID ) then
			return NULL
		end if
	end if

	lexSkipToken( LEXCHECK_POST_SUFFIX )

	if( (tk = FB_TK_CINT) or (tk = FB_TK_CUINT) ) then

		'' ['<' lgt '>']
		if( hMatch( FB_TK_LT ) ) then

			'' expr
			var lgt = cConstIntExpr( cGtInParensOnlyExpr( ) )

			dtype = hIntegerTypeFromBitSize( lgt, (tk = FB_TK_CUINT) )

			if( hMatch( FB_TK_GT ) = FALSE ) then
				errReport( FB_ERRMSG_EXPECTEDGT )
			end if

		end if

	end if

	'' '('
	if( hMatch( CHAR_LPRNT ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDLPRNT )
	end if

	expr = cExpression( )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		expr = astNewCONSTi( 0 )
	end if

	select case op
	case AST_OP_TOSIGNED
		dtype = typeToSigned( astGetFullType( expr ) )
	case AST_OP_TOUNSIGNED
		dtype = typeToUnsigned( astGetFullType( expr ) )
	end select

	expr = astNewCONV( dtype, NULL, expr, AST_CONVOPT_CHECKSTR or AST_CONVOPT_EXACT_CAST, @errmsg )
	if( expr = NULL ) then
		if( errmsg = FB_ERRMSG_OK ) then
			errmsg = FB_ERRMSG_TYPEMISMATCH
		end if
		errReport( errmsg, TRUE )

		expr = astNewCONSTi( 0 )
	end if

	'' ')'
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDRPRNT )
		hSkipUntil( CHAR_RPRNT, TRUE )
	else
		if isASM = FALSE then
			lexSkipToken( )
		end if
	end if

	function = expr

end function

'' AnonType  =  TYPE ('<' SymbolType '>')? '(' ... ')'
function cAnonType( ) as ASTNODE ptr
	dim as ASTNODE ptr initree = any
	dim as FBSYMBOL ptr sym = any, subtype = any
	dim as integer dtype = any, is_explicit = any

	'' TYPE
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' '<'?
	is_explicit = hMatch( FB_TK_LT )

	if( is_explicit ) then
		'' SymbolType
		if( cSymbolType( dtype, subtype ) = FALSE ) then
			'' it would be nice to be able to fall back and do
			'' a cExpression(), like typeof(), or len() do,
			'' however the ambiguity with the "greater-than '>' operator"
			'' and the "type<foo'>'(bar)"....
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			'' error recovery: fake a type
			dtype = FB_DATATYPE_INTEGER
			subtype = NULL
		end if
	else
		'' use the type from the left-hand expression,
		'' this allows totally anonymous types.
		subtype = parser.ctxsym
		dtype   = parser.ctx_dtype

		if( dtype = FB_DATATYPE_INVALID ) then
			errReport( FB_ERRMSG_INCOMPLETETYPE )
			dtype = FB_DATATYPE_INTEGER
			subtype = NULL
		end if

		select case( typeGetDtAndPtrOnly( dtype ) )
		case FB_DATATYPE_VOID, FB_DATATYPE_FWDREF
			errReport( FB_ERRMSG_INCOMPLETETYPE )
			dtype = FB_DATATYPE_INTEGER
			subtype = NULL
		end select
	end if

	'' Disallow creating objects of abstract classes
	hComplainIfAbstractClass( dtype, subtype )

	if( is_explicit ) then
		'' '>'
		if( hMatch( FB_TK_GT ) = FALSE ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
			'' error recovery: skip until next '>'
			hSkipUntil( FB_TK_GT, TRUE )
		end if
	end if

	'' UDT?
	if( typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_STRUCT ) then
		'' if it's a UDT and the next token is a
		'' left parenthesis, don't handle parentheses as optional
		if( lexGetToken() = CHAR_LPRNT ) then
			fbSetPrntOptional( FALSE )
		end if

		'' Has a ctor?
		if( symbGetCompCtorHead( subtype ) ) then
			return cCtorCall( subtype )
		end if
	end if

	'' Use temp var so the rest can be parsed as var initializer,
	'' then delete the temp var again, similar to astCALLCTORToCALL()
	sym = symbAddTempVar( dtype, subtype )
	initree = cInitializer( sym, FB_INIOPT_NONE )
	astReplaceSymbolOnTree( initree, sym, NULL )
	symbDelSymbol( sym )

	'' This gives us a clean TYPEINI tree (like a parameter initializer),
	'' allowing astNewASSIGN() to optimize it by initializing the lhs
	'' directly instead of using a temp var, and if that does not happen,
	'' then astTypeIniUpdate() will take care of it.

	function = initree
end function
