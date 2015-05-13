'' symbol type (BYTE, INTEGER, STRING, ...) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "rtl.bi"

sub cConstExprValue(byref value as integer)
	dim as ASTNODE ptr expr = any

	expr = cEqInParentsOnlyExpr( )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: fake an value
		value = 0
		return
	end if

	if( astIsCONST( expr ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDCONST )
		'' error recovery: fake an value
		astDelTree( expr )
		value = 0
		return
	end if

	value = astGetValueAsInt( expr )
	astDelNode( expr )
end sub

'':::::
function cSymbolTypeFuncPtr _
	( _
		byval isfunction as integer _
	) as FBSYMBOL ptr

	dim as integer dtype = any, lgt = any, mode = any
	dim as FBSYMBOL ptr proc = any, subtype = any

	function = NULL

	' no need for naked check here, naked only effects the way a function
	' is emitted, not the way it's called

	'' mode
	mode = cProcCallingConv( )

	proc = symbPreAddProc( NULL )

	'' Parameters?
	cParameters( NULL, proc, mode, TRUE )

	'' (AS SymbolType)?
	if( lexGetToken( ) = FB_TK_AS ) then

		'' if it was SUB, don't allow a return type
		if( isfunction = FALSE ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
			dtype = FB_DATATYPE_VOID
			subtype = NULL
		
		'' it's a function
		else

			lexSkipToken( )

			if( cSymbolType( dtype, subtype, lgt ) = FALSE ) then
				errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
				'' error recovery: fake a type
				dtype = FB_DATATYPE_INTEGER
				subtype = NULL
			end if

			'' check for invalid types
			select case as const typeGet( dtype )
			case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				errReport( FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS )
				'' error recovery: fake a type
				dtype = FB_DATATYPE_INTEGER
				subtype = NULL

			case FB_DATATYPE_VOID
				errReport( FB_ERRMSG_INVALIDDATATYPES )
				'' error recovery: fake a type
				dtype = typeAddrOf( dtype )
				subtype = NULL
			end select

			proc->proc.returnMethod = cProcReturnMethod( dtype )
		end if
	else
		'' if it's a function and type was not given, it can't be guessed
		if( isfunction ) then
			errReport( FB_ERRMSG_EXPECTEDRESTYPE )
			'' error recovery: fake a type
			dtype = FB_DATATYPE_INTEGER
			subtype = NULL
		else
			dtype = FB_DATATYPE_VOID
			subtype = NULL
		end if
	end if

	function = symbAddProcPtr( proc, dtype, subtype, mode )

end function

function cTypeOrExpression _
	( _
		byval is_len as integer, _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any
	dim as integer maybe_type = any

	'' This is ambiguous because functions/variables may use the same name
	'' as types, for example STRING and STRING(). The same can happen with
	'' user-defined types/aliases.
	'' Disambiguation:
	''  - Types can't be followed by an operator, except for '*', which can
	''    be used in 'STRING * N'. Note: we cannot check for {Z|W}STRING
	''    followed by '*', because '*' also works with {z|w}string typedefs.
	''  - Types can't be followed by '[' or '(', except for 'TYPEOF(...)'.
	''  - Note: '.' doesn't make it an expression, because it could be a
	''    type in a namespace.

	maybe_type = TRUE

	'' Token followed by an operator except '*'?
	if( (lexGetLookAheadClass( 1 ) = FB_TKCLASS_OPERATOR) and _
	    (lexGetLookAhead( 1 ) <> CHAR_TIMES) ) then
		maybe_type = FALSE
	else
		'' Check for some non-operator tokens
		select case( lexGetLookAhead( 1 ) )
		case CHAR_LBRACKET    '' [
			maybe_type = FALSE
		case CHAR_LPRNT       '' (
			'' Not a TYPEOF though?
			maybe_type = (lexGetToken( ) = FB_TK_TYPEOF)
		end select
	end if

	'' QB quirk: LEN() only takes expressions
	if( maybe_type and is_len and fbLangIsSet( FB_LANG_QB ) ) then
		maybe_type = FALSE
	end if

	if( maybe_type ) then
		'' Parse as type
		if( cSymbolType( dtype, subtype, lgt, FB_SYMBTYPEOPT_NONE ) ) then
			'' Successful -- it's a type, not an expression
			return NULL
		end if
	end if

	'' Parse as expression
	fbSetCheckArray( FALSE )
	expr = cExpression( )
	fbSetCheckArray( TRUE )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: fake an expr
		expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if

	function = expr
end function

sub cTypeOf _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as integer _
	)

	dim as ASTNODE ptr expr = any

	'' Type or an Expression
	expr = cTypeOrExpression( FALSE, dtype, subtype, lgt )

	'' Was it a type?
	if( expr = NULL ) then
		exit sub
	end if

	'' Check the expression
	if( astIsCONST( expr ) ) then
		lgt 	= rtlCalcExprLen( expr, FALSE )
		dtype	= astGetDataType( expr )
		subtype = astGetSubType( expr )
	else
		'' ugly hack to deal with arrays w/o indexes
		if( astIsNIDXARRAY( expr ) ) then
			dim as ASTNODE ptr temp_node = expr
			expr = astGetLeft( expr )
			astDelNode( temp_node )
		end if

		dim as integer derefs = 0
		dim as ASTNODE ptr walk = expr
		dim as FBSYMBOL ptr sym = astGetSymbol( expr )
		if( sym = NULL ) then
			dtype	= astGetFullType( expr )
			subtype = astGetSubtype( expr )
            lgt = symbCalcLen( dtype, subtype )
		else
			while( walk <> NULL )
				select case as const astGetClass( walk )
				case AST_NODECLASS_FIELD, AST_NODECLASS_IDX
					'' if it's a field, get this node's type,
					'' don't "solve" the tree
					sym = astGetSymbol( walk )
					exit while

				case AST_NODECLASS_DEREF
					'' count derefs
					derefs += 1

				end select

				'' update/walk
				sym = astGetSymbol( walk )
				walk = astGetLeft( walk )
			wend
			lgt 	= symbGetLen( sym )
			dtype	= symbGetFullType( sym )
			subtype = symbGetSubtype( sym )
		end if

		'' byref args have a deref,
		'' but they maintain their type
		if( typeIsPtr( dtype ) ) then
			if( derefs > 0 ) then
				'' balance it
				dtype = typeMultDeref( dtype, derefs )
			end if
		end if

	end if

	astDelTree( expr )
end sub

'':::::
''SymbolType      =   CONST? UNSIGNED? (
''				      ANY
''				  |   BOOLEAN (BYTE|INTEGER)?
''				  |   CHAR|BYTE
''				  |	  SHORT|WORD
''				  |	  INTEGER|LONG|DWORD
''				  |   SINGLE
''				  |   DOUBLE
''                |   STRING ('*' NUM_LIT)?
''                |   USERDEFTYPE
''				  |   (FUNCTION|SUB) ('(' args ')') (AS SymbolType)?
''				      (CONST? (PTR|POINTER))* .
''
function cSymbolType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as integer, _
		byval options as FB_SYMBTYPEOPT _
	) as integer

	dim as integer isunsigned = any, isfunction = any

	function = FALSE

	lgt = 0
	dtype = FB_DATATYPE_INVALID
	subtype = NULL

	dim as integer is_const = FALSE
	dim as integer ptr_cnt = 0

	'' TYPEOF?
	if( lexGetToken( ) = FB_TK_TYPEOF ) then
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDLPRNT )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if

		'' datatype
		cTypeOf( dtype, subtype, lgt )

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if
	else
		'' CONST?
		if( lexGetToken( ) = FB_TK_CONST ) then
			lexSkipToken( )
			is_const = TRUE
		end if

		'' UNSIGNED?
		isunsigned = hMatch( FB_TK_UNSIGNED )

		''
		select case as const lexGetToken( )
		case FB_TK_ANY
			lexSkipToken( )
			dtype = FB_DATATYPE_VOID
			lgt = 0

		case FB_TK_BOOLEAN

			'' BOOLEAN
			lexSkipToken( )

			'' BYTE?
			if( hMatch( FB_TK_BYTE ) ) then
				dtype = FB_DATATYPE_BOOL8
				lgt = 1

			'' INTEGER?
			elseif ( hMatch( FB_TK_INTEGER ) ) then
				dtype = FB_DATATYPE_BOOL32
				lgt = 4

			'' not explicit? use arch default or user specified command line option
			else
				'' 4 byte booleans?
				if( 0 <> ( fbGetOption( FB_COMPOPT_EXTRAOPT ) and FB_EXTRAOPT_INTEGER_BOOL ) ) then
					dtype = FB_DATATYPE_BOOL32
					lgt = 4
				
				'' Assume FB_EXTRAOPT_BYTE_BOOL
				else
					dtype = FB_DATATYPE_BOOL8
					lgt = 1
				end if
			end if

		case FB_TK_BYTE
			lexSkipToken( )
			dtype = FB_DATATYPE_BYTE
			lgt = 1
		case FB_TK_UBYTE
			lexSkipToken( )
			dtype = FB_DATATYPE_UBYTE
			lgt = 1

		case FB_TK_SHORT
			lexSkipToken( )
			dtype = FB_DATATYPE_SHORT
			lgt = 2

		case FB_TK_USHORT
			lexSkipToken( )
			dtype = FB_DATATYPE_USHORT
			lgt = 2

		case FB_TK_INTEGER
			lexSkipToken( )
			dtype = fbLangGetType( INTEGER )
			lgt = fbLangGetSize( INTEGER )

		case FB_TK_UINT
			lexSkipToken( )
			dtype = FB_DATATYPE_UINT
			lgt = FB_INTEGERSIZE

		case FB_TK_LONG
			lexSkipToken( )
			dtype = fbLangGetType( LONG )
			lgt = fbLangGetSize( LONG )

		case FB_TK_ULONG
			lexSkipToken( )
			dtype = FB_DATATYPE_ULONG
			lgt = FB_LONGSIZE

		case FB_TK_LONGINT
			lexSkipToken( )
			dtype = FB_DATATYPE_LONGINT
			lgt = FB_INTEGERSIZE*2

		case FB_TK_ULONGINT
			lexSkipToken( )
			dtype = FB_DATATYPE_ULONGINT
			lgt = FB_INTEGERSIZE*2

		case FB_TK_SINGLE
			lexSkipToken( )
			dtype = FB_DATATYPE_SINGLE
			lgt = 4

		case FB_TK_DOUBLE
			lexSkipToken( )
			dtype = FB_DATATYPE_DOUBLE
			lgt = 8

		case FB_TK_STRING
			lexSkipToken( )

			'' assume it's a var-len string, see below for fixed-len
			dtype = FB_DATATYPE_STRING
			lgt = FB_STRDESCLEN

		case FB_TK_ZSTRING
			lexSkipToken( )

			'' assume it's a pointer, see below for fixed-len
			dtype = FB_DATATYPE_CHAR
			lgt = 0

		case FB_TK_WSTRING
			lexSkipToken( )

			'' ditto
			dtype = FB_DATATYPE_WCHAR
			lgt = 0

		case FB_TK_FUNCTION, FB_TK_SUB
			isfunction = (lexGetToken( ) = FB_TK_FUNCTION)
			lexSkipToken( )

			dtype = typeAddrOf( FB_DATATYPE_FUNCTION )
			lgt = FB_POINTERSIZE
			ptr_cnt += 1

			subtype = cSymbolTypeFuncPtr( isfunction )
			if( subtype = NULL ) then
				exit function
			end if

		case else
			dim as FBSYMCHAIN ptr chain_ = NULL
			dim as FBSYMBOL ptr base_parent = any
			dim as integer check_id = TRUE

			if( parser.stmt.with.sym <> NULL ) then
				if( lexGetToken( ) = CHAR_DOT ) then
					'' not a '..'?
					check_id = (lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) = CHAR_DOT)
				end if
			end if

			if( check_id ) then
				chain_ = cIdentifier( base_parent, FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT )
			end if

			if( chain_ ) then
				do
					dim as FBSYMBOL ptr sym = chain_->sym
					do
						select case symbGetClass( sym )
						case FB_SYMBCLASS_STRUCT
							lexSkipToken( )
							dtype = FB_DATATYPE_STRUCT
							subtype = sym
							lgt = symbGetLen( sym )
							exit do, do

						case FB_SYMBCLASS_ENUM
							lexSkipToken( )
							dtype = FB_DATATYPE_ENUM
							subtype = sym
							lgt = FB_INTEGERSIZE
							exit do, do

						case FB_SYMBCLASS_TYPEDEF
							lexSkipToken( )
							dtype = symbGetFullType( sym )
							subtype = symbGetSubtype( sym )
							lgt = symbGetLen( sym )
							ptr_cnt += typeGetPtrCnt( dtype )
							exit do, do
						end select

						sym = sym->hash.next
					loop while( sym <> NULL )

					chain_ = symbChainGetNext( chain_ )
				loop while( chain_ <> NULL )
			end if
		end select

		'' no type?
		if( dtype = FB_DATATYPE_INVALID ) then
			if( isunsigned ) then
				errReport( FB_ERRMSG_SYNTAXERROR )
			end if

			if( is_const ) then
				dtype = typeSetIsConst( NULL )
			end if

			return FALSE
		end if

		'' unsigned?
		if( isunsigned ) then
			'' remap type, if valid
			select case as const typeGet( dtype )
			case FB_DATATYPE_BYTE
				dtype = FB_DATATYPE_UBYTE

			case FB_DATATYPE_SHORT
				dtype = FB_DATATYPE_USHORT

			case FB_DATATYPE_INTEGER
				dtype = FB_DATATYPE_UINT

			case FB_DATATYPE_LONG
				dtype = FB_DATATYPE_ULONG

			case FB_DATATYPE_LONGINT
				dtype = FB_DATATYPE_ULONGINT

			case else
				errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
			end select
		end if
	end if

	'' fixed-len z|w|string? (must be handled here because the typedefs)
	if( lexGetToken( ) = CHAR_STAR ) then
		lexSkipToken( )

		'' expr
		cConstExprValue( lgt )

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
			''		 the number of chars times sizeof(wstring), so
			''		 always use symbGetWstrLen( ) to retrieve the
			''		 len in characters, not the bytes
			if( typeGet( dtype ) = FB_DATATYPE_WCHAR ) then
				lgt *= typeGetSize( FB_DATATYPE_WCHAR )
			end if

		case else
			errReport( FB_ERRMSG_SYNTAXERROR, TRUE )

		end select

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
				lexSkipToken( )

				select case lexGetToken( )
				case FB_TK_PTR, FB_TK_POINTER
					if( ptr_cnt >= FB_DT_PTRLEVELS ) then
						errReport( FB_ERRMSG_TOOMANYPTRINDIRECTIONS )
					else
						dtype = typeSetIsConst( typeAddrOf( dtype ) )
						ptr_cnt += 1
					end if

					lexSkipToken( )

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

				lexSkipToken( )

			case else
				exit do
			end select
		loop
	end if

	if( ptr_cnt > 0 ) then
		lgt = FB_POINTERSIZE
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
			select case as const typeGet( dtype )
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				'' LEN() and SIZEOF() allow Z|WSTRING to be used w/o PTR
				if( (options and FB_SYMBTYPEOPT_CHECKSTRPTR) <> 0 ) then
					errReport( FB_ERRMSG_EXPECTEDPOINTER )
					'' error recovery: make pointer
					dtype = typeAddrOf( dtype )
					lgt = FB_POINTERSIZE
				else
					lgt = typeGetSize( dtype )
				end if
			end select
		end if
	end if

	function = TRUE

end function
