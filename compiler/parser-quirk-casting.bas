'' quirk casting functions (CBYTE, CSHORT, CINT, ...) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
''TypeConvExpr		=    (C### '(' expression ')') .
''
function cTypeConvExpr _
	( _
		byval tk as FB_TOKEN, _
		byval isASM as integer = FALSE _
	) as ASTNODE ptr

    dim as integer dtype = any, op = any
    dim as ASTNODE ptr expr = any

	dtype = FB_DATATYPE_INVALID
	op = INVALID

	select case as const tk
	case FB_TK_CBYTE
		dtype = FB_DATATYPE_BYTE

	case FB_TK_CUBYTE
		dtype = FB_DATATYPE_UBYTE

	case FB_TK_CSHORT
		dtype = FB_DATATYPE_SHORT

	case FB_TK_CUSHORT
		dtype = FB_DATATYPE_USHORT

	case FB_TK_CINT
		dtype = fbLangGetType( integer )

	case FB_TK_CUINT
		dtype = FB_DATATYPE_UINT

	case FB_TK_CLNG
		dtype = fbLangGetType( long )

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

	lexSkipToken( )

	'' '('
	if( hMatch( CHAR_LPRNT ) = FALSE ) then
		if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
			return NULL
		end if
	end if

	expr = cExpression( )
	if( expr = NULL ) then
		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			return NULL
		else
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
	end if

	select case op
	case AST_OP_TOSIGNED
		dtype = symbGetSignedType( astGetFullType( expr ) )
	case AST_OP_TOUNSIGNED
	    dtype = symbGetUnsignedType( astGetFullType( expr ) )
	end select

	expr = astNewCONV( dtype, NULL, expr, INVALID, TRUE )
    if( expr = NULL ) Then
    	if( errReport( FB_ERRMSG_TYPEMISMATCH, TRUE ) = FALSE ) then
    		return NULL
		else
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    	end if
    end if

	'' ')'
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
			return NULL
		else
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if
	else
		if isASM = FALSE then
			lexSkipToken( )
		end if
	end if

	function = expr

end function

'':::::
'' AnonUDT			=	TYPE ('<' SymbolType '>')? '(' ... ')'
function cAnonUDT _
	( _
		_
	) as ASTNODE ptr

    dim as FBSYMBOL ptr subtype = any
    dim as integer dtype = any, lgt = any

    function = NULL

	'' TYPE
	lexSkipToken( )

    '' ('<' SymbolType '>')?
    if( lexGetToken( ) = FB_TK_LT ) then
    	lexSkipToken( )

        '' get UDT or intrinsic type
		if( cSymbolType( dtype, subtype, lgt, FB_SYMBTYPEOPT_NONE ) = FALSE ) then

			'' it would be nice to be able to fall back and do
			'' a cExpression(), like typeof(), or len() do,
			'' however the ambiguity with the "greater-than '>' operator"
			'' and the "type<foo'>'(bar)"....

			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a type
				dtype = FB_DATATYPE_INTEGER
				subtype = NULL
			end if
		end if

    	'' '>'
    	if( lexGetToken( ) <> FB_TK_GT ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next '>'
				hSkipUntil( FB_TK_GT, TRUE )
			end if

    	else
    		lexSkipToken( )
    	end if

    else
    	'' use the type from the left-hand expression,
    	'' this allows totally anonymous types.
    	subtype = parser.ctxsym
    	dtype   = parser.ctx_dtype

		if( subtype <> NULL ) then

			dtype = FB_DATATYPE_STRUCT

			'' typedef? resolve..
			if( symbIsTypedef( subtype ) ) then
				subtype = symbGetSubtype( subtype )
			end if

	    	if( subtype = NULL ) then
				if( errReport( FB_ERRMSG_SYNTAXERROR, TRUE ) = FALSE ) then
					exit function
				else
					'' error recovery: fake a node
					return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
	    	end if

	    	if( symbIsStruct( subtype ) = FALSE ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
					exit function
				else
					'' error recovery: fake a node
					return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				end if
			end if
		end if

    end if

    '' has a ctor?
    if( subtype <> NULL ) then
	    if( symbGetHasCtor( subtype ) ) then
	    	return cCtorCall( subtype )
	    end if
	end if

    '' alloc temp var
    dim as FBSYMBOL ptr sym = symbAddTempVar( dtype, subtype, FALSE, FALSE )

    '' let the initializer do the rest..
    function = cInitializer( sym, FB_INIOPT_NONE )

end function


