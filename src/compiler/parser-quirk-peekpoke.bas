'' quirk pointer statements (PEEK and POKE) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

''
'' (SymbolType ',')? Expression
''
private function hOptionalTypeAndFirstExpr _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	var expr = cTypeOrExpression( FB_TK_SIZEOF, dtype, subtype )
	if( expr = NULL ) then
		'' SymbolType

		'' check for types invalid for PEEK/POKE
		select case( dtype )
		case FB_DATATYPE_VOID, FB_DATATYPE_FIXSTR
			errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			'' error recovery: fake a type
			dtype = FB_DATATYPE_UBYTE
			subtype = NULL
		end select

		'' ','
		hMatchCOMMA( )

		'' Expression
		expr = cExpression( )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0 )
		end if
	else
		'' Expression (without a SymbolType in front of it)
		dtype = FB_DATATYPE_UBYTE
		subtype  = NULL
	end if

	function = expr
end function

''
'' PokeStmt  =  POKE (SymbolType ',')? Expression ',' Expression .
''
function cPokeStmt( ) as integer
	dim as ASTNODE ptr expr1 = any, expr2 = any
	dim as integer poketype = any
	dim as FBSYMBOL ptr subtype = any

	function = FALSE

	'' POKE
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' (SymbolType ',')? Expression
	expr1 = hOptionalTypeAndFirstExpr( poketype, subtype )

	'' ','
	hMatchCOMMA( )

	hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )

	select case astGetDataClass( expr1 )
	case FB_DATACLASS_STRING
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		'' no error recovery: stmt was already parsed
		astDelTree( expr1 )
		exit function

	case FB_DATACLASS_FPOINT
		expr1 = astNewCONV( FB_DATATYPE_UINT, NULL, expr1 )

	case else
		if( typeGetSize( astGetDataType( expr1 ) ) <> env.pointersize ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' no error recovery: ditto
			astDelTree( expr1 )
			exit function
		end if
	end select

	'' try to convert address to poketype pointer to check constness
	if( fbPdCheckIsSet( FB_PDCHECK_CONSTNESS ) ) then
		expr1 = astNewCONV( typeAddrOf(poketype), subtype, expr1 )
	end if

	expr1 = astNewDEREF( expr1, poketype, subtype )

	expr1 = astNewASSIGN( expr1, expr2 )
	if( expr1 = NULL ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
	else
		astAdd( expr1 )
	end if

	function = TRUE

end function

''
'' PeekFunct  =  PEEK '(' (SymbolType ',')? Expression ')' .
''
function cPeekFunct( ) as ASTNODE ptr
	dim as ASTNODE ptr expr = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	function = NULL

	'' PEEK
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' '('
	hMatchLPRNT( )

	'' (SymbolType ',')? Expression
	expr = hOptionalTypeAndFirstExpr( dtype, subtype )

	' ')'
	hMatchRPRNT( )

	select case astGetDataClass( expr )
	case FB_DATACLASS_STRING
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		'' error recovery: fake an expr
		astDelTree( expr )
		expr = NULL

	case FB_DATACLASS_FPOINT
		expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )

	case else
		if( typeGetSize( astGetDataType( expr ) ) <> env.pointersize ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			'' error recovery: fake an expr
			astDelTree( expr )
			expr = NULL
		end if
	end select

	if( expr = NULL ) then
		expr = astNewCONSTi( 0 )
	end if

	'' ('.' UdtMember)?
	if( lexGetToken( ) = CHAR_DOT ) then
		select case dtype
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS

		case else
			errReport( FB_ERRMSG_EXPECTEDUDT, TRUE )
			hSkipStmt( )
			exit function
		end select

		'' '.'
		lexSkipToken( LEXCHECK_NOPERIOD )
		function = cUdtMember( dtype, subtype, expr, TRUE )
	else
		function = astNewDEREF( expr, dtype, subtype )
	end if
end function
