'' symbol type (BYTE, INTEGER, STRING, ...) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "rtl.bi"

function cConstIntExpr _
	( _
		byval expr as ASTNODE ptr, _
		byval dtype as integer _
	) as longint

	'' bad expression? fake a constant value
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		expr = astNewCONSTi( 0, dtype )
	end if

	'' not a CONST? delete the tree and fake a constant value
	if( astIsCONST( expr ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDCONST )
		astDelTree( expr )
		expr = astNewCONSTi( 0, dtype )
	end if

	'' flush the expr to the specified dtype.
	'' default is FB_DATATYPE_INTEGER, if not specified in call to cConstIntExpr()
	function = astConstFlushToInt( expr, dtype )
end function

''
type RANGEVALUES
	as longint smin
	as longint smax
	as ulongint umax
end type

function hIsConstInRange _
	( _
		byval dtype as integer, _
		byval value as longint, _
		byval todtype as integer _
	) as integer

	'' TODO:
	'' - consider moving this table to symb-data.bas
	'' - consider using in astCheckConst(), possibly? with -w pedantic
	'' - consider adding src/compiler/fb-limit.bi or inc/fb-limit.bi.  These
	''   limit values are used in several locations in fbc compiler source.

	static range( FB_SIZETYPE_BOOLEAN to FB_SIZETYPE_UINT64 ) as RANGEVALUES = _
		{ _
			/' FB_SIZETYPE_BOOLEAN '/ (                  -1ull,                  0ll,                  0ull ), _
			/' FB_SIZETYPE_INT8    '/ (               -&h80ull,               &h7fll,               &h7full ), _
			/' FB_SIZETYPE_UINT8   '/ (                   0ll ,               &h7fll,               &hffull ), _
			/' FB_SIZETYPE_INT16   '/ (             -&h8000ull,             &h7fffll,             &h7fffull ), _
			/' FB_SIZETYPE_UINT16  '/ (                   0ll ,             &h7fffll,             &hffffull ), _
			/' FB_SIZETYPE_INT32   '/ (         -&h80000000ull,         &h7fffffffll,         &h7fffffffull ), _
			/' FB_SIZETYPE_UINT32  '/ (                   0ll ,         &h7fffffffll,         &hffffffffull ), _
			/' FB_SIZETYPE_INT64   '/ ( -&h8000000000000000ull, &h7fffffffffffffffll, &h7fffffffffffffffull ), _
			/' FB_SIZETYPE_UINT64  '/ (                   0ll , &h7fffffffffffffffll, &hffffffffffffffffull ) _
		}

	dim as RANGEVALUES ptr r = @range( typeGetSizeType( todtype ) )

	if( typeIsSigned( dtype ) ) then
		if( typeIsSigned( todtype ) ) then
			function = (value >= r->smin) and (value <= r->smax)
		else
			if( typeGetSizeType(dtype) = FB_SIZETYPE_INT64 and typeGetSizeType(todtype) = FB_SIZETYPE_UINT64 ) then
				function = (value >= 0) and (culngint(value) <= culngint(r->smax))
			else
				function = (value >= 0) and (culngint(value) <= r->umax)
			end if
		endif
	else
		if( typeIsSigned( todtype ) ) then
			if( typeGetSizeType(dtype) = FB_SIZETYPE_UINT64 and typeGetSizeType(todtype) = FB_SIZETYPE_INT64 ) then
				function = (culngint(value) <= culngint(r->smax))
			else
				function = (culngint(value) <= r->umax)
			end if
		else
			function = (culngint(value) <= r->umax)
		endif
	end if

end function

''
function cConstIntExprRanged _
	( _
		byval expr as ASTNODE ptr, _
		byval todtype as integer _
	) as longint

	'' - this function is very similar cConstIntExpr() except that
	''   we need to save the dtype of expr before it is flushed, but
	''   if expr was invalid it might be NULL

	dim as longint value = any
	dim as integer dtype = any

	'' bad expression? fake a constant value
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		expr = astNewCONSTi( 0, todtype )
	end if

	'' not a CONST? delete the tree and fake a longint constant value
	if( astIsCONST( expr ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDCONST )
		astDelTree( expr )
		expr = astNewCONSTi( 0, FB_DATATYPE_LONGINT )
	end if

	'' save the dtype of the expression before we flush the ast to longint
	dtype = astGetDataType( expr )

	'' flush the expr to longint, it's the largest signed integer datatype we have
	value = astConstFlushToInt( expr, FB_DATATYPE_LONGINT )

	if( not hIsConstInRange( dtype, value, todtype ) ) then
		errReportWarn( FB_WARNINGMSG_CONVOVERFLOW )
	end if

	function = value

end function

private function cSymbolTypeFuncPtr( byval is_func as integer ) as FBSYMBOL ptr
	dim as integer dtype = any, mode = any, attrib = any, pattrib = any
	dim as FBSYMBOL ptr proc = any, subtype = any

	function = NULL
	attrib = FB_SYMBATTRIB_NONE
	pattrib = FB_PROCATTRIB_NONE
	subtype = NULL

	' no need for naked check here, naked only effects the way a function
	' is emitted, not the way it's called

	'' mode
	mode = cProcCallingConv( )

	proc = symbPreAddProc( NULL )

	'' Parameters?
	cParameters( NULL, proc, mode, TRUE )

	'' BYREF?
	cByrefAttribute( pattrib, is_func )

	'' (AS SymbolType)?
	if( lexGetToken( ) = FB_TK_AS ) then
		'' if it was SUB, don't allow a return type
		if( is_func = FALSE ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
			dtype = FB_DATATYPE_VOID
		else
			cProcRetType( attrib, pattrib, proc, TRUE, dtype, subtype )
		end if
	else
		'' if it's a function and type was not given, it can't be guessed
		if( is_func ) then
			errReport( FB_ERRMSG_EXPECTEDRESTYPE )
			'' error recovery: fake a type
			dtype = FB_DATATYPE_INTEGER
		else
			dtype = FB_DATATYPE_VOID
		end if
	end if

	function = symbAddProcPtr( proc, dtype, subtype, attrib, pattrib, mode )
end function

private function hGetTokenDescription( byval tk as integer ) as string
	select case( tk )
	case FB_TK_TYPEOF : function = "typeof"
	case FB_TK_LEN    : function = "len"
	case else         : function = "sizeof"
	end select
end function

type AmbigiousSizeofInfo
	as FBSYMBOL ptr typ, nontype
	declare sub checkSymChain( byval chain_ as FBSYMCHAIN ptr )
	declare sub maybeWarn( byval tk as integer, byval refers_to_type as integer )
end type

'' Walk the symchain and check whether it contains types and non-type symbols,
'' specifically vars/consts.
'' This is useful to check whether one identifier refers to both a type and
'' another kind of symbol (which is possible in FB because types are in a
'' separate namespace). However, we're only checking for variables/constants
'' and not procedures because an identifier referring to the latter can't appear
'' by itself in a sizeof() anyways (only as part of a function call or
'' address-of operation). Also, for types it looks like we only have to check
'' structs/typedefs/fwdrefs, but not enums, because it's not allowed to declare
'' vars with the same name as enums anyways.
sub AmbigiousSizeofInfo.checkSymChain( byval chain_ as FBSYMCHAIN ptr )
	do
		var sym = chain_->sym

		do
			select case( sym->class )
			case FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF
				if( typ = NULL ) then
					typ = sym
				end if
			case FB_SYMBCLASS_VAR, FB_SYMBCLASS_CONST
				if( nontype = NULL ) then
					nontype = sym
				end if
			end select

			sym = sym->hash.next
		loop while( sym )

		chain_ = symbChainGetNext( chain_ )
	loop while( chain_ )
end sub

sub AmbigiousSizeofInfo.maybeWarn( byval tk as integer, byval refers_to_type as integer )
	if( (typ = NULL) or (nontype = NULL) ) then exit sub

	'' Don't warn if it's a type and a var of that type, because then the
	'' len() or sizeof() would return the same value in either case.
	if( symbIsVar( nontype ) and _
	    (symbGetType( nontype ) = FB_DATATYPE_STRUCT) and _
	    (nontype->subtype = typ) ) then
		exit sub
	end if

	var sym1 = typ
	var sym2 = nontype
	if( refers_to_type = FALSE ) then
		swap sym1, sym2
	end if

	var msg = "Ambigious " + hGetTokenDescription( tk ) + "()"
	msg += ", referring to " + symbDumpPrettyToStr( sym1 )
	msg += ", instead of " + symbDumpPrettyToStr( sym2 )
	errReportWarn( FB_WARNINGMSG_AMBIGIOUSLENSIZEOF, , , msg )
end sub

function cTypeOrExpression _
	( _
		byval tk as integer, _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint, _
		byref is_fixlenstr as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any
	dim as integer maybe_type = any

	'' This is ambiguous because functions/variables may use the same name
	'' as types, for example STRING and STRING(). The same can happen with
	'' user-defined types/aliases.
	'' Disambiguation:
	''  - Types can't be followed by an operator, except for '*', which can
	''    be used in 'STRING * N'. Note: We can't just check for
	''    '{Z|W}STRING *' because '*' also works with {z|w}string typedefs,
	''    e.g. 'myZstringTypedef * N'.
	''  - Types can't be followed by '[' or '(', except for:
	''      TYPEOF|SUB|FUNCTION(...)
	''  - Note: '.' doesn't make it an expression, because it could be a
	''    type in a namespace.

	maybe_type = TRUE

	'' If a simple identifier is given to sizeof/len, then collect
	'' information about the symbols which it could refer to. If it could
	'' refer to both a type and a non-type symbol, we may want to show a
	'' warning later. Allow FB_LANG_OPT_PERIODS to control lexing the first
	'' token but not the look ahead.  Only in the qb dialect could variables
	'' possibly have periods in the name.  In all other cases (like for types)
	'' we need to return each identifier between periods.
	dim ambigioussizeof as AmbigiousSizeofInfo
	if( (lexGetToken( ) = FB_TK_ID) and (lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) = CHAR_RPRNT) ) then
		var chain_ = lexGetSymChain( )
		'' Known symbol(s)?
		if( chain_ ) then
			ambigioussizeof.checkSymChain( chain_ )
		end if
	end if

	'' Token followed by an operator except '*' / '<'?
	if( (lexGetLookAheadClass( 1 ) = FB_TKCLASS_OPERATOR) andalso _
	    (lexGetLookAhead( 1 ) <> CHAR_TIMES) andalso _
	    (lexGetLookAhead( 1 ) <> FB_TK_LT) ) then
		maybe_type = FALSE
	else
		'' Check for some non-operator tokens
		select case( lexGetLookAhead( 1 ) )
		case CHAR_LBRACKET    '' [
			maybe_type = FALSE
		case CHAR_LPRNT       '' (
			'' Not a TYPEOF/SUB/FUNCTION though?
			select case( lexGetToken( ) )
			case FB_TK_TYPEOF, FB_TK_SUB, FB_TK_FUNCTION

			case else
				maybe_type = FALSE
			end select
		end select
	end if

	'' QB quirk: LEN() only takes expressions
	if( maybe_type and (tk = FB_TK_LEN) and fbLangIsSet( FB_LANG_QB ) ) then
		maybe_type = FALSE
	end if

	if( maybe_type ) then
		'' Parse as type
		assert( parser.nsprefix = NULL )
		if( cSymbolType( dtype, subtype, lgt, is_fixlenstr, FB_SYMBTYPEOPT_SAVENSPREFIX ) ) then
			'' Successful -- it's a type, not an expression
			ambigioussizeof.maybeWarn( tk, TRUE )
			parser.nsprefix = NULL
			return NULL
		end if
	end if

	ambigioussizeof.maybeWarn( tk, FALSE )

	'' Parse as expression, allowing NIDXARRAYs
	expr = cExpressionWithNIDXARRAY( TRUE )
	if( expr = NULL ) then
		'' was an error, so make sure to discard the namespace prefix
		parser.nsprefix = NULL
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: fake an expr
		expr = astNewCONSTi( 0 )
	end if

	function = expr
end function

sub cTypeOf _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint, _
		byref is_fixlenstr as integer, _
		byref ret_sym as FBSYMBOL ptr _
	)

	dim as ASTNODE ptr expr = any
	dim as integer dtorlistcookie = any

	ret_sym = NULL

	astDtorListScopeBegin( )

	'' Type or an Expression
	expr = cTypeOrExpression( FB_TK_TYPEOF, dtype, subtype, lgt, is_fixlenstr )

	'' discard all dtors that may have been generated
	dtorlistcookie = astDtorListScopeEnd( )
	astDtorListScopeDelete( dtorlistcookie )

	'' Was it a type?
	if( expr = NULL ) then
		'' check for member field
		cUdtTypeMember( dtype, subtype, lgt, is_fixlenstr, ret_sym )
		exit sub
	end if

	expr = astRemoveNIDXARRAY( expr )

	dtype   = astGetFullType( expr )
	subtype = astGetSubtype( expr )
	lgt     = astSizeOf( expr, is_fixlenstr )
	ret_sym = astGetSymbol( expr )

	astDelTree( expr )
end sub

function hIntegerTypeFromBitSize _
	( _
		byval bitsize as longint, _
		byval is_unsigned as integer _
	) as FB_DATATYPE

	dim as FB_DATATYPE dtype

	select case bitsize
	case 8
		dtype = FB_DATATYPE_BYTE
	case 16
		dtype = FB_DATATYPE_SHORT
	case 32
		dtype = FB_DATATYPE_LONG
	case 64
		dtype = FB_DATATYPE_LONGINT
	case else
		errReport( FB_ERRMSG_INVALIDSIZE, TRUE )
		dtype = FB_DATATYPE_INTEGER
	end select

	if( is_unsigned ) then
		dtype = typeToUnsigned( dtype )
	end if

	return dtype

end function

private function cMangleModifier _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr _
	) as integer

	function = FALSE

	assert( dtype = typeGetDtOnly( dtype ) )

	'' cMangleModifier(dtype, subtype)
	'' returns:
	''   FALSE = modifier given and invalid
	''   TRUE  = modifier is valid for the dtype, or none given
	'' modifies:
	''   dtype = original dtype with mangle modifier applied
	''   subtype = original subtype, or a clone if there
	''             are modifiers applied

	'' we are checking for specific cases and the FB_DATATYPE
	'' stored in the upper bits of the dtype in FB_DT_MANGLEMASK
	'' was selected for convenience.  In future, it might be
	'' better to have a new FB_MANGLE_DATATYPE enum for tracking
	'' the desired mapping stored in the upper bits of the
	'' dtype, especially if there are some mappings that can't
	'' be found in existing FB_DATATYPE.

	'' ALIAS?
	if( lexGetToken( ) = FB_TK_ALIAS ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then

			'' "long"? "char"?
			select case lcase( *lexGetText( ) )
			case "long"
				'' only Win64 is affected by ths modifer
				if( fbIs64bit( ) and ((env.target.options and FB_TARGETOPT_UNIX) = 0) ) then
					select case dtype
					case FB_DATATYPE_LONG
						dtype = typeSetMangleDt( dtype, FB_DATATYPE_INTEGER )
						function = TRUE
					case FB_DATATYPE_ULONG
						dtype = typeSetMangleDt( dtype, FB_DATATYPE_UINT )
						function = TRUE
					case else
						errReport( FB_ERRMSG_SYNTAXERROR )
					end select
				else
					select case dtype
					case FB_DATATYPE_LONG
					case FB_DATATYPE_ULONG
					case else
						errReport( FB_ERRMSG_SYNTAXERROR )
					end select
				end if

			case "char"
				select case dtype
				case FB_DATATYPE_VOID
					dtype = typeSetMangleDt( dtype, FB_DATATYPE_CHAR )
				case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE
					dtype = typeSetMangleDt( dtype, FB_DATATYPE_CHAR )
				case else
					errReport( FB_ERRMSG_SYNTAXERROR )
				end select

			case "__builtin_va_list", "__builtin_va_list[]"
				select case dtype
				case FB_DATATYPE_VOID
					dtype = typeSetMangleDt( dtype, FB_DATATYPE_VA_LIST )
				case FB_DATATYPE_STRUCT
					dtype = typeSetMangleDt( dtype, FB_DATATYPE_VA_LIST )
					'' TODO: we would probably like to clone the
					'' struct here but implementation of PARSER/AST
					'' does not immediately allow for this cleanly, for
					'' now just back patch the original struct and
					'' remember to document this on mangle modifier page.
					'' subtype = symbCloneSymbol( subtype )
					symbSetUdtValistType( subtype, fbGetBackendValistType() )
				case else
					errReport( FB_ERRMSG_SYNTAXERROR )
				end select

			case ""
				errReport( FB_ERRMSG_EMPTYALIASSTRING )

			case else
				errReport( FB_ERRMSG_SYNTAXERROR )
			end select

			'' "literal"
			lexSkipToken( )
		else
			errReport( FB_ERRMSG_SYNTAXERROR )
		end if

	end if

end function

'':::::
''SymbolType      =   CONST? UNSIGNED? (
''                    ANY
''                |   BOOLEAN (BYTE|INTEGER)?
''                |   CHAR|BYTE
''                |   SHORT|WORD
''                |   INTEGER|LONG|DWORD
''                |   SINGLE
''                |   DOUBLE
''                |   STRING ('*' NUM_LIT)?
''                |   USERDEFTYPE
''                |   (FUNCTION|SUB) ('(' args ')') (AS SymbolType)?
''                    (CONST? (PTR|POINTER))* .
''
function cSymbolType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint, _
		byref is_fixlenstr as integer, _
		byval options as FB_SYMBTYPEOPT _
	) as integer

	dim as integer isunsigned = any, isfunction = any

	function = FALSE

	dtype = FB_DATATYPE_INVALID
	subtype = NULL
	lgt = 0
	is_fixlenstr = FALSE

	dim as integer is_const = FALSE
	dim as integer ptr_cnt = 0

	'' TYPEOF?
	if( lexGetToken( ) = FB_TK_TYPEOF ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if

		'' datatype
		cTypeOf( dtype, subtype, lgt, is_fixlenstr )

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if
	else
		'' CONST?
		if( lexGetToken( ) = FB_TK_CONST ) then
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			is_const = TRUE
		end if

		'' UNSIGNED?
		isunsigned = hMatch( FB_TK_UNSIGNED, LEXCHECK_POST_SUFFIX )

		''
		select case as const lexGetToken( )
		case FB_TK_ANY
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_VOID
			cMangleModifier( dtype, subtype )

		case FB_TK_BOOLEAN
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_BOOLEAN

		case FB_TK_BYTE
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_BYTE
			cMangleModifier( dtype, subtype )

		case FB_TK_UBYTE
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_UBYTE
			cMangleModifier( dtype, subtype )

		case FB_TK_SHORT
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_SHORT

		case FB_TK_USHORT
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_USHORT

		case FB_TK_INTEGER
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			'' ['<' lgt '>']
			if( hMatch( FB_TK_LT ) ) then

				'' expr
				lgt = cConstIntExpr( cGtInParensOnlyExpr( ) )

				dtype = hIntegerTypeFromBitSize( lgt, FALSE )

				if( hMatch( FB_TK_GT ) = FALSE ) then
					errReport( FB_ERRMSG_EXPECTEDGT, TRUE )
				end if
			else

				dtype = env.lang.integerkeyworddtype

			end if

		case FB_TK_UINT
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			'' ['<' lgt '>']
			if( hMatch( FB_TK_LT ) ) then

				'' expr
				lgt = cConstIntExpr( cGtInParensOnlyExpr( ) )

				dtype = hIntegerTypeFromBitSize( lgt, TRUE )

				if( hMatch( FB_TK_GT ) = FALSE ) then
					errReport( FB_ERRMSG_EXPECTEDGT, TRUE )
				end if

			else

				dtype = FB_DATATYPE_UINT

			end if

		case FB_TK_LONG
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_LONG
			cMangleModifier( dtype, subtype )

		case FB_TK_ULONG
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_ULONG
			cMangleModifier( dtype, subtype )

		case FB_TK_LONGINT
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_LONGINT

		case FB_TK_ULONGINT
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_ULONGINT

		case FB_TK_SINGLE
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_SINGLE

		case FB_TK_DOUBLE
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			dtype = FB_DATATYPE_DOUBLE

		case FB_TK_STRING
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			'' assume it's a var-len string, see below for fixed-len
			dtype = FB_DATATYPE_STRING

		case FB_TK_ZSTRING
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			dtype = FB_DATATYPE_CHAR

		case FB_TK_WSTRING
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			dtype = FB_DATATYPE_WCHAR

		case FB_TK_FUNCTION, FB_TK_SUB
			isfunction = (lexGetToken( ) = FB_TK_FUNCTION)

			'' FUNCTION | SUB
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			dtype = typeAddrOf( FB_DATATYPE_FUNCTION )
			ptr_cnt += 1

			subtype = cSymbolTypeFuncPtr( isfunction )
			if( subtype = NULL ) then
				exit function
			end if

		end select

		if( dtype <> FB_DATATYPE_INVALID ) then
			select case( typeGetDtAndPtrOnly( dtype ) )
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				'' Use 0 for now; will be set later if no length
				'' given via * N (as in Z/WSTRING * N)
				lgt = 0
			case else
				lgt = typeGetSize( dtype )
			end select
		else
			dim as FBSYMCHAIN ptr chain_ = NULL
			dim as FBSYMBOL ptr base_parent = any
			dim as integer check_id = TRUE

			if( parser.stmt.with ) then
				if( lexGetToken( ) = CHAR_DOT ) then
					'' not a '..'?
					check_id = (lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) = CHAR_DOT)
				end if
			end if

			if( check_id ) then
				chain_ = cIdentifier( base_parent, _
				                      iif( options and FB_SYMBTYPEOPT_SAVENSPREFIX, FB_IDOPT_NONE, FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT ) _
				                    )
			end if

			if( chain_ ) then
				'' cTypeOrExpression() will expect that the namespace prefix
				'' will be preserved if we abort and retry as an expression.
				'' Eventually namespace prefix gets used in cIdentifier()
				if( options and FB_SYMBTYPEOPT_SAVENSPREFIX ) then
					assert( parser.nsprefix = NULL )
					select case symbGetClass( chain_->sym )
					case FB_SYMBCLASS_CONST, FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD
						parser.nsprefix = chain_
					end select
				end if

				do
					dim as FBSYMBOL ptr sym = chain_->sym
					do
						select case symbGetClass( sym )
						case FB_SYMBCLASS_STRUCT
							lexSkipToken( LEXCHECK_POST_SUFFIX )
							dtype = FB_DATATYPE_STRUCT
							subtype = sym
							lgt = symbGetLen( sym )
							cMangleModifier( dtype, subtype )
							exit do, do

						case FB_SYMBCLASS_ENUM
							lexSkipToken( LEXCHECK_POST_SUFFIX )
							dtype = FB_DATATYPE_ENUM
							subtype = sym
							lgt = typeGetSize( FB_DATATYPE_ENUM )
							exit do, do

						case FB_SYMBCLASS_TYPEDEF
							'' check access on the typedef only, the
							'' final type will be checked for access
							'' after it is returned.
							if( symbCheckAccess( sym ) = FALSE ) then
								errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
							end if
							lexSkipToken( LEXCHECK_POST_SUFFIX )
							dtype = symbGetFullType( sym )
							subtype = symbGetSubtype( sym )
							lgt = symbGetLen( sym )
							is_fixlenstr = symbGetIsFixLenStr( sym )
							ptr_cnt += typeGetPtrCnt( dtype )
							exit do, do
						end select

						sym = sym->hash.next
					loop while( sym <> NULL )

					chain_ = symbChainGetNext( chain_ )
				loop while( chain_ <> NULL )

				'' discard the namespace prefix if it won't be needed later
				if( options and FB_SYMBTYPEOPT_SAVENSPREFIX ) then
					if( dtype <> FB_DATATYPE_INVALID ) then
						parser.nsprefix = NULL
					end if
				end if
			end if
		end if

		'' no type?
		if( dtype = FB_DATATYPE_INVALID ) then
			if( isunsigned ) then
				errReport( FB_ERRMSG_SYNTAXERROR )
			end if

			if( is_const ) then
				dtype = typeSetIsConst( FB_DATATYPE_VOID )
			end if

			return FALSE
		end if

		'' unsigned?
		if( isunsigned ) then
			'' remap type, if valid
			select case as const typeGet( dtype )
			case FB_DATATYPE_BYTE
				if( typeHasMangleDt( dtype ) ) then
					dtype = typeSetMangleDt( FB_DATATYPE_UBYTE, FB_DATATYPE_CHAR )
				else
					dtype = FB_DATATYPE_UBYTE
				end if

			case FB_DATATYPE_SHORT
				dtype = FB_DATATYPE_USHORT

			case FB_DATATYPE_INTEGER
				dtype = FB_DATATYPE_UINT

			case FB_DATATYPE_LONG
				if( typeHasMangleDt( dtype ) ) then
					dtype = typeSetMangleDt( FB_DATATYPE_ULONG, FB_DATATYPE_UINT )
				else
					dtype = FB_DATATYPE_ULONG
				end if

			case FB_DATATYPE_LONGINT
				dtype = FB_DATATYPE_ULONGINT

			case else
				errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
			end select
		end if
	end if

	'' fixed-len z|w|string? (must be handled here because the typedefs)
	if( lexGetToken( ) = CHAR_TIMES ) then
		lexSkipToken( )

		'' expr
		lgt = cConstIntExpr( cEqInParensOnlyExpr( ) )
		is_fixlenstr = TRUE

		select case as const typeGet( dtype )
		case FB_DATATYPE_STRING
			'' plus the null-term
			lgt += 1

			'' min 1 char (+ null-term)
			if( lgt <= 1 ) then
				errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
				'' error recovery: fake a len
				lgt = 2
			end if

			'' remap type
			dtype = FB_DATATYPE_FIXSTR

		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			'' min 1 char
			if( lgt < 1 ) then
				errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
				'' error recovery: fake a len
				lgt = 1
			end if

			'' note: len of "wstring * expr" symbols will be actually
			''       the number of chars times sizeof(wstring), so
			''       always use symbGetWstrLen( ) to retrieve the
			''       len in characters, not the bytes
			if( typeGet( dtype ) = FB_DATATYPE_WCHAR ) then
				lgt *= typeGetSize( FB_DATATYPE_WCHAR )
			end if

		case else
			errReport( FB_ERRMSG_SYNTAXERROR, TRUE )

		end select

		'' STRING * N can't be allowed with BYREF or pointers, because
		'' we can't represent the * N on expression data types.
		if( options and FB_SYMBTYPEOPT_ISBYREF ) then
			errReport( FB_ERRMSG_BYREFFIXSTR, TRUE )
		end if

		'' const?
		if( is_const ) then
			dtype = typeSetIsConst( dtype )
		end if
	else
		'' const?
		if( is_const ) then
			dtype = typeSetIsConst( dtype )
		end if

		'' (CONST (PTR|POINTER) | (PTR|POINTER))*
		do
			select case as const lexGetToken( )
			'' CONST PTR?
			case FB_TK_CONST
				lexSkipToken( LEXCHECK_POST_SUFFIX )

				select case lexGetToken( )
				case FB_TK_PTR, FB_TK_POINTER
					if( ptr_cnt >= FB_DT_PTRLEVELS ) then
						errReport( FB_ERRMSG_TOOMANYPTRINDIRECTIONS )
					else
						dtype = typeSetIsConst( typeAddrOf( dtype ) )
						ptr_cnt += 1
					end if

					lexSkipToken( LEXCHECK_POST_SUFFIX )

				case else
					errReport( FB_ERRMSG_EXPECTEDPTRORPOINTER )
					exit do
				end select

			'' PTR|POINTER?
			case FB_TK_PTR, FB_TK_POINTER
				if( ptr_cnt >= FB_DT_PTRLEVELS ) then
					errReport( FB_ERRMSG_TOOMANYPTRINDIRECTIONS )
				else
					dtype = typeAddrOf( dtype )
					ptr_cnt += 1
				end if

				lexSkipToken( LEXCHECK_POST_SUFFIX )

			case else
				exit do
			end select
		loop
	end if

	if( ptr_cnt > 0 ) then
		lgt = typeGetSize( dtype )
	else
		'' can't have forward typedef's if they aren't pointers
		if( typeGet( dtype ) = FB_DATATYPE_FWDREF ) then
			'' forward types are allowed in func prototypes with byref params
			if( (options and FB_SYMBTYPEOPT_ALLOWFORWARD) = 0 ) then
				errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE )
				'' error recovery: fake a type
				dtype = typeAddrOf( FB_DATATYPE_VOID )
				subtype = NULL
			end if

		elseif( lgt <= 0 ) then
			select case( typeGetDtAndPtrOnly( dtype ) )
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				'' Z|WSTRING can only be used without PTR in some places:
				'' LEN()/SIZEOF(), BYREF parameters/results
				if( (options and FB_SYMBTYPEOPT_CHECKSTRPTR) <> 0 ) then
					errReport( FB_ERRMSG_EXPECTEDPOINTER )
					'' error recovery: make pointer
					dtype = typeAddrOf( dtype )
				end if
				lgt = typeGetSize( dtype )
			end select
		end if
	end if

	function = TRUE

end function
