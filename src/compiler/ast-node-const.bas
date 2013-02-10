'' AST constant nodes
'' l = NULL; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

function astConstIsZero( byval n as ASTNODE ptr ) as integer
	assert( astIsCONST( n ) )

	select case as const( astGetDataType( n ) )
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = (n->con.val.long = 0ll)

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = (n->con.val.float = 0.0)

	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = (n->con.val.int = 0)
		else
			function = (n->con.val.long = 0ll)
		end if

	case else
		function = (n->con.val.int = 0)
	end select
end function

'':::::
function astNewCONSTstr _
	( _
		byval v as zstring ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr tc = any

	'' assuming no escape sequences are used
	tc = symbAllocStrConst( v, -1 )
    if( tc = NULL ) then
    	exit function
    end if

	function = astNewVAR( tc )

end function

'':::::
function astNewCONSTwstr _
	( _
		byval v as wstring ptr _
	) as ASTNODE ptr

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
		byval value as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, FB_DATATYPE_INTEGER, NULL )
	function = n

	n->con.val.int = value

	function = astNewCONV( dtype, subtype, n )
end function

'':::::
function astNewCONSTf _
	( _
		byval value as double, _
		byval dtype as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, dtype )
	function = n

	n->con.val.float = value

end function

'':::::
function astNewCONSTl _
	( _
		byval value as longint, _
		byval dtype as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, dtype )
	function = n

	n->con.val.long  = value

end function

'':::::
function astNewCONST _
	( _
		byval v as FBVALUE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, dtype, subtype )
	function = n

	select case as const typeGet( dtype )
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		if( v <> NULL ) then
			n->con.val.long = v->long
		else
			n->con.val.long = 0
		end if

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		if( v <> NULL ) then
			n->con.val.float = v->float
	    else
	    	n->con.val.float = 0.0
	    end if

	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			if( v <> NULL ) then
				n->con.val.int = v->int
			else
				n->con.val.int = 0
			end if
		else
			if( v <> NULL ) then
				n->con.val.long = v->long
			else
				n->con.val.long = 0
			end if
		end if

	case else
		if( v <> NULL ) then
			n->con.val.int = v->int
		else
			n->con.val.int = 0
		end if
	end select

end function

function astNewCONSTz _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr tree = any
	dim as FBSYMBOL ptr fld = any

	select case as const( typeGetDtAndPtrOnly( dtype ) )
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		function = astNewCONSTstr( NULL )

	case FB_DATATYPE_WCHAR
		function = astNewCONSTwstr( NULL )

	case FB_DATATYPE_STRUCT
		'' Build a TYPEINI tree for this struct, with a CONST( 0 )
		'' initializer for each member
		tree = astTypeIniBegin( FB_DATATYPE_STRUCT, subtype, TRUE )
		astTypeIniScopeBegin( tree, NULL )

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

		function = astNewCONST( NULL, dtype, subtype )

	end select

end function

'':::::
function astLoadCONST _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	dim as integer dtype = any

	if( ast.doemit ) then
		dtype = astGetDataType( n )

		select case as const typeGet( dtype )
		'' longint?
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			return irAllocVrImm64( dtype, NULL, n->con.val.long )

		'' floating-point?
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			return irAllocVrImmF( dtype, NULL, n->con.val.float )

		'' long?
		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
			if( FB_LONGSIZE = len( integer ) ) then
				return irAllocVrImm( dtype, NULL, n->con.val.int )
			else
				'' !!!FIXME!!! cross-compilation 32-bit -> 64-bit
				errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
			end if

		case else
			'' bytes/shorts/integers/enums
			return irAllocVRIMM( dtype, astGetSubtype( n ), n->con.val.int )
		end select
	end if

end function

function astConstFlushToInt( byval n as ASTNODE ptr ) as integer
	n = astNewCONV( FB_DATATYPE_INTEGER, NULL, n )

	assert( astIsCONST( n ) )
	function = n->con.val.int

	astDelNode( n )
end function

function astConstFlushToStr( byval n as ASTNODE ptr ) as string
	assert( astIsCONST( n ) )

	select case as const( astGetDataType( n ) )
	case FB_DATATYPE_SINGLE
		function = str( csng( n->con.val.float ) )

	case FB_DATATYPE_DOUBLE
		function = str( n->con.val.float )

	case FB_DATATYPE_LONGINT
		function = str( n->con.val.long )

	case FB_DATATYPE_ULONGINT
		function = str( cunsg( n->con.val.long ) )

	case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
		function = str( n->con.val.int )

	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = str( n->con.val.int )
		else
			function = str( n->con.val.long )
		end if

	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = str( cunsg( n->con.val.int ) )
		else
			function = str( cunsg( n->con.val.long ) )
		end if

	case else
		function = str( cunsg( n->con.val.int ) )
	end select

	astDelNode( n )
end function

function astConstFlushToWstr( byval n as ASTNODE ptr ) as wstring ptr
	static as wstring * 64+1 w

	assert( astIsCONST( n ) )

	select case as const( astGetDataType( n ) )
	case FB_DATATYPE_SINGLE
		w = wstr( csng( n->con.val.float ) )

	case FB_DATATYPE_DOUBLE
		w = wstr( n->con.val.float )

	case FB_DATATYPE_LONGINT
		w = wstr( n->con.val.long )

	case FB_DATATYPE_ULONGINT
		w = wstr( cunsg( n->con.val.long ) )

	case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
		w = wstr( n->con.val.int )

	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			w = wstr( n->con.val.int )
		else
			w = wstr( n->con.val.long )
		end if

	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			w = wstr( cunsg( n->con.val.int ) )
		else
			w = wstr( cunsg( n->con.val.long ) )
		end if

	case else
		w = wstr( cunsg( n->con.val.int ) )
	end select

	astDelNode( n )
	function = @w
end function
