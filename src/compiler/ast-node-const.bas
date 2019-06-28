'' AST constant nodes
'' l = NULL; r = NULL
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

'' const = 0?
function astConstEqZero( byval n as ASTNODE ptr ) as integer
	assert( astIsCONST( n ) )
	if( typeGetClass( n->dtype ) = FB_DATACLASS_FPOINT ) then
		function = (n->val.f = 0.0)
	else
		function = (n->val.i = 0)
	end if
end function

'' const >= 0?
function astConstGeZero( byval n as ASTNODE ptr ) as integer
	assert( astIsCONST( n ) )
	if( typeGetClass( n->dtype ) = FB_DATACLASS_FPOINT ) then
		function = (n->val.f >= 0.0)
	elseif( typeIsSigned( n->dtype ) ) then
		function = (n->val.i >= 0)
	else
		'' Unsigned always is >= 0
		function = TRUE
	end if
end function

function astIsConst0OrMinus1( byval n as ASTNODE ptr ) as integer
	if( astIsCONST( n ) ) then
		dim value as longint = astConstGetAsInt64( n )
		if( (value = 0) or (value = -1) ) then
			return TRUE
		end if
	end if
	return FALSE
end function

function astNewCONSTstr( byval v as zstring ptr ) as ASTNODE ptr
	dim as FBSYMBOL ptr tc = any

	'' assuming no escape sequences are used
	tc = symbAllocStrConst( v, -1 )
	if( tc = NULL ) then
		exit function
	end if

	function = astNewVAR( tc )
end function

function astNewCONSTwstr( byval v as wstring ptr ) as ASTNODE ptr
	dim as FBSYMBOL ptr tc = any

	'' assuming no escape sequences are used
	tc = symbAllocWstrConst( v, -1 )
	if( tc = NULL ) then
		exit function
	end if

	function = astNewVAR( tc )
end function

function astNewCONSTi _
	( _
		byval value as longint, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = astNewNode( AST_NODECLASS_CONST, FB_DATATYPE_LONGINT, NULL )
	n->val.i = value

	n = astNewCONV( dtype, subtype, n, AST_CONVOPT_DONTCHKPTR )
	assert( n )
	assert( n->class = AST_NODECLASS_CONST )

	function = n
end function

function astNewCONSTf _
	( _
		byval value as double, _
		byval dtype as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = astNewNode( AST_NODECLASS_CONST, FB_DATATYPE_DOUBLE )
	n->val.f = value

	function = astNewCONV( dtype, NULL, n )
end function

function astNewCONST _
	( _
		byval v as FBVALUE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	if( typeGetClass( dtype ) = FB_DATACLASS_FPOINT ) then
		function = astNewCONSTf( v->f, dtype )
	else
		function = astNewCONSTi( v->i, dtype, subtype )
	end if

end function

function astNewCONSTz _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr tree = any
	dim as FBSYMBOL ptr fld = any

	select case as const( typeGetDtAndPtrOnly( dtype ) )
	case FB_DATATYPE_VOID
		'' A CONST expression with VOID type doesn't make sense,
		'' but astNewCONSTz() can be called for BYREF AS ANY parameters.
		'' Any expression type should be ok for error recovery.
		function = astNewCONSTi( 0 )

	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		function = astNewCONSTstr( NULL )

	case FB_DATATYPE_WCHAR
		function = astNewCONSTwstr( NULL )

	case FB_DATATYPE_STRUCT
		'' Build a TYPEINI tree for this struct, with a CONST( 0 )
		'' initializer for each member
		tree = astTypeIniBegin( FB_DATATYPE_STRUCT, subtype, TRUE )
		astTypeIniScopeBegin( tree, NULL, FALSE )

		fld = symbUdtGetFirstField( subtype )
		while( fld )
			'' field = CONST( 0 )
			astTypeIniAddAssign( tree, astNewCONSTz( symbGetFullType( fld ), symbGetSubtype( fld ) ), fld )
			fld = symbUdtGetNextInitableField( fld )
		wend

		astTypeIniScopeEnd( tree, NULL )
		astTypeIniEnd( tree, FALSE )

		function = tree

	case else
		if( dtype = FB_DATATYPE_INVALID ) then
			dtype = FB_DATATYPE_INTEGER
		end if

		if( typeGetClass( dtype ) = FB_DATACLASS_FPOINT ) then
			function = astNewCONSTf( 0.0, dtype )
		else
			function = astNewCONSTi( 0, dtype, subtype )
		end if
	end select

end function

function astLoadCONST( byval n as ASTNODE ptr ) as IRVREG ptr
	dim as integer dtype = any

	if( ast.doemit ) then
		dtype = astGetDataType( n )
		if( typeGetClass( dtype ) = FB_DATACLASS_FPOINT ) then
			function = irAllocVrImmF( dtype, n->subtype, n->val.f )
		else
			function = irAllocVrImm( dtype, n->subtype, n->val.i )
		end if
	end if
end function

function astConstFlushToInt _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer _
	) as longint

	n = astNewCONV( dtype, NULL, n )

	assert( astIsCONST( n ) )
	function = n->val.i

	astDelNode( n )
end function

function astConstFlushToStr( byval n as ASTNODE ptr ) as string
	assert( astIsCONST( n ) )

	if( typeGetClass( n->dtype ) = FB_DATACLASS_FPOINT ) then
		if( typeGetDtAndPtrOnly( n->dtype ) = FB_DATATYPE_DOUBLE ) then
			function = str( n->val.f )
		else
			function = str( csng( n->val.f ) )
		end if
	elseif( typeGetDtAndPtrOnly( n->dtype ) = FB_DATATYPE_BOOLEAN ) then
		function = INT_BOOL_TO_STR( cbool(n->val.i) )
	elseif( typeIsSigned( n->dtype ) ) then
		function = str( n->val.i )
	else
		function = str( cunsg( n->val.i ) )
	end if

	astDelNode( n )
end function

function astConstFlushToWstr( byval n as ASTNODE ptr ) as wstring ptr
	static as wstring * 64+1 w

	assert( astIsCONST( n ) )

	if( typeGetClass( n->dtype ) = FB_DATACLASS_FPOINT ) then
		if( typeGetDtAndPtrOnly( n->dtype ) = FB_DATATYPE_DOUBLE ) then
			w = wstr( n->val.f )
		else
			w = wstr( csng( n->val.f ) )
		end if
	elseif( typeGetDtAndPtrOnly( n->dtype ) = FB_DATATYPE_BOOLEAN ) then
		w = INT_BOOL_TO_WSTR( cbool(n->val.i) )
	elseif( typeIsSigned( n->dtype ) ) then
		w = wstr( n->val.i )
	else
		w = wstr( cunsg( n->val.i ) )
	end if

	astDelNode( n )
	function = @w
end function

function astConstGetAsInt64( byval n as ASTNODE ptr ) as longint
	assert( astIsCONST( n ) )
	if( typeGetClass( n->dtype ) = FB_DATACLASS_FPOINT ) then
		function = clngint( n->val.f )
	else
		function = n->val.i
	end if
end function

function astConstGetAsDouble( byval n as ASTNODE ptr ) as double
	assert( astIsCONST( n ) )
	if( typeGetClass( n->dtype ) = FB_DATACLASS_FPOINT ) then
		function = n->val.f
	elseif( typeIsSigned( n->dtype ) ) then
		function = cdbl( n->val.i )
	else
		function = cdbl( cunsg( n->val.i ) )
	end if
end function

function astBuildConst( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	assert( symbIsConst( sym ) )
	dtype = symbGetFullType( sym )
	subtype = symbGetSubType( sym )

	select case( typeGetDtAndPtrOnly( dtype ) )
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		function = astNewVAR( symbGetConstStr( sym ) )
	case else
		function = astNewCONST( symbGetConstVal( sym ), dtype, subtype )
	end select
end function

function astConvertRawCONSTi _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

	assert( typeGetClass( l->dtype ) = FB_DATACLASS_INTEGER )

	'' Pretend the CONST is a 64bit value for a moment, then do a CONV to
	'' the destination type. This is useful for code that stores values into
	'' the 64bit ASTNODE.val.i field directly and wants to convert it to
	'' a certain type, possibly with truncation.
	''
	'' The reason for having this is that the compiler now uses 64bit
	'' LONGINTs for all the internal constant evaluation etc. If someone
	'' was compiling something like "&hFFFFFFFFu + &hFFFFFFFFu", the 64bit
	'' value temporarily stored would be &h1FFFFFFFE which is too big to
	'' fit in 32bit. If compiling that for 32bit, the stored value must be
	'' converted from 64bit LONGINT to some 32bit type (INTEGER/LONG) in
	'' order to be truncated. This is done here with the help of
	'' astNewCONV(). When compiling for 64bit, it would be converted from
	'' 64bit LONGINT to 64bit INTEGER, thus stay the same.

	l->dtype = iif( typeIsSigned( l->dtype ), _
			FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT )
	l->subtype = NULL

	astBeginHideWarnings( )
	l = astNewCONV( dtype, subtype, l, AST_CONVOPT_DONTCHKPTR )
	astEndHideWarnings( )

	function = l
end function
