'' misc AST function
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"
#include once "hlp.bi"

declare sub astReplaceSymbolOnCALL _
	( _
		byval n as ASTNODE ptr, _
		byval old_sym as FBSYMBOL ptr, _
		byval new_sym as FBSYMBOL ptr _
	)

'' globals
	dim shared as longint ast_minlimitTB( FB_DATATYPE_BYTE to FB_DATATYPE_ULONGINT ) = _
	{ _
		-128LL, _								'' byte
		0LL, _                                  '' ubyte
		0LL, _                                  '' char
		-32768LL, _                             '' short
		0LL, _                                  '' ushort
		0LL, _                                  '' wchar
		-2147483648LL, _                        '' int
		0LL, _                                  '' uint
		-2147483648LL, _                        '' enum
		0LL, _                                  '' bitfield
		-2147483648LL, _                        '' long
		0LL, _                                  '' ulong
		-9223372036854775808LL, _               '' longint
		0LL _                                   '' ulongint
	}

	dim shared as ulongint ast_maxlimitTB( FB_DATATYPE_BYTE to FB_DATATYPE_ULONGINT ) = _
	{ _
		127ULL, _                               '' ubyte
		255ULL, _                               '' byte
		255ULL, _                               '' char
		32767ULL, _                             '' short
		65535ULL, _                             '' ushort
		65535ULL, _                             '' wchar
		2147483647ULL, _                        '' int
		4294967295ULL, _                        '' uint
		2147483647ULL, _                        '' enum
		4294967295ULL, _                        '' bitfield
		2147483647ULL, _                        '' long
		4294967295ULL, _                        '' ulong
		9223372036854775807ULL, _               '' longint
		18446744073709551615ULL _               '' ulongint
	}

sub astMiscInit( )
	listInit( @ast.dtorlist, 64, len( AST_DTORLIST_ITEM ), LIST_FLAGS_NOCLEAR )
	with( ast.dtorlistscopes )
		.cookies = NULL
		.count = 0
		.room = 0
	end with
	ast.dtorlistcookies = 0
	ast.flushdtorlist = TRUE

	'' Remap wchar to target-specific type
	ast_minlimitTB(FB_DATATYPE_WCHAR) = ast_minlimitTB(env.target.wchar)
	ast_maxlimitTB(FB_DATATYPE_WCHAR) = ast_maxlimitTB(env.target.wchar)

    '' !!!FIXME!!! remap [u]long to [u]longint if target = 64-bit
end sub

sub astMiscEnd( )
	with( ast.dtorlistscopes )
		assert( .count = 0 )
		deallocate( .cookies )
	end with
	listEnd( @ast.dtorlist )
end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' tree scanning
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

''::::
function astIsTreeEqual _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as integer

    function = FALSE

    if( (l = NULL) or (r = NULL) ) then
    	if( l = r ) then
    		function = TRUE
    	end if
    	exit function
    end if

	if( l->class <> r->class ) then
		exit function
	end if

	if( astGetFullType( l ) <> astGetFullType( r ) ) then
		exit function
	end if

	if( l->subtype <> r->subtype ) then
		exit function
	end if

	select case as const l->class
	case AST_NODECLASS_VAR
		if( l->sym <> r->sym ) then
			exit function
		end if

		if( l->var_.ofs <> r->var_.ofs ) then
			exit function
		end if

	case AST_NODECLASS_FIELD
		if( l->sym <> r->sym ) then
			exit function
		end if

	case AST_NODECLASS_CONST

		select case as const astGetDataType( l )
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			if( l->con.val.long <> r->con.val.long ) then
				exit function
			end if

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			if( l->con.val.float <> r->con.val.float ) then
				exit function
			end if

  		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	    	if( FB_LONGSIZE = len( integer ) ) then
				if( l->con.val.int <> r->con.val.int ) then
					exit function
				end if
  	    	else
				if( l->con.val.long <> r->con.val.long ) then
					exit function
				end if
  	    	end if

		case else
			'' bytes/shorts/integers/enums
			if( l->con.val.int <> r->con.val.int ) then
				exit function
			end if
		end select

	case AST_NODECLASS_DEREF
		if( l->ptr.ofs <> r->ptr.ofs ) then
			exit function
		end if

	case AST_NODECLASS_IDX
		if( l->idx.ofs <> r->idx.ofs ) then
			exit function
		end if

		if( l->idx.mult <> r->idx.mult ) then
			exit function
		end if

	case AST_NODECLASS_BOP
		if( l->op.op <> r->op.op ) then
			exit function
		end if

		if( l->op.options <> r->op.options ) then
			exit function
		end if

		if( l->op.ex <> r->op.ex ) then
			exit function
		end if

	case AST_NODECLASS_UOP
		if( l->op.op <> r->op.op ) then
			exit function
		end if

		if( l->op.options <> r->op.options ) then
			exit function
		end if

	case AST_NODECLASS_ADDROF
		if( l->sym <> r->sym ) then
			exit function
		end if

		if( l->op.op <> r->op.op ) then
			exit function
		end if

	case AST_NODECLASS_OFFSET
		if( l->sym <> r->sym ) then
			exit function
		end if

		if( l->ofs.ofs <> r->ofs.ofs ) then
			exit function
		end if

	case AST_NODECLASS_CONV
		'' do nothing, the l child will be checked below

	case AST_NODECLASS_CALL, AST_NODECLASS_BRANCH, _
		 AST_NODECLASS_LOAD, AST_NODECLASS_ASSIGN, _
		 AST_NODECLASS_LINK
		'' unpredictable nodes
		exit function

	end select

    '' check childs
	if( astIsTreeEqual( l->l, r->l ) = FALSE ) then
		exit function
	end if

	if( astIsTreeEqual( l->r, r->r ) = FALSE ) then
		exit function
	end if

    ''
	function = TRUE

end function

'':::::
function astIsClassOnTree _
	( _
		byval class_ as integer, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr m = any

	''
	if( n = NULL ) then
		return NULL
	end if

	if( n->class = class_ ) then
		return n
	end if

	'' walk
	m = astIsClassOnTree( class_, n->l )
	if( m <> NULL ) then
		return m
	end if

	m = astIsClassOnTree( class_, n->r )
	if( m <> NULL ) then
		return m
	end if

	function = NULL

end function

''::::
function astIsSymbolOnTree _
	( _
		byval sym as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

	dim as FBSYMBOL ptr s = any

	if( n = NULL ) then
		return FALSE
	end if

	select case as const n->class
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_FIELD, _
		 AST_NODECLASS_ADDROF, AST_NODECLASS_OFFSET

		s = astGetSymbol( n )
		'' same symbol?
		if( s = sym ) then
			return TRUE
		end if

		'' passed by ref or by desc? can't do any assumption..
		if( s <> NULL ) then
			if (symbIsParamBydescOrByref(s)) then
				return TRUE
			end if
		end if

	'' pointer? could be pointing to source symbol too..
	case AST_NODECLASS_DEREF
		return TRUE
	end select

	'' walk
	if( n->l <> NULL ) then
		if( astIsSymbolOnTree( sym, n->l ) ) then
			return TRUE
		end if
	end if

	if( n->r <> NULL ) then
		if( astIsSymbolOnTree( sym, n->r ) ) then
			return TRUE
		end if
	end if

	function = FALSE

end function

'':::::
sub astReplaceSymbolOnTree _
	( _
		byval n as ASTNODE ptr, _
		byval old_sym as FBSYMBOL ptr, _
		byval new_sym as FBSYMBOL ptr _
	)

	if( n = NULL ) then
		return
	end if

	if( n->sym = old_sym ) then
		n->sym = new_sym
	end if

	'' assuming no other complex node will be on the
	'' tree (TypeIniTree's won't have blocks, breaks, etc)

	select case as const n->class
	case AST_NODECLASS_BOP, AST_NODECLASS_UOP, _
	     AST_NODECLASS_BRANCH, AST_NODECLASS_LOOP
		if( n->op.ex = old_sym ) then
			n->op.ex = new_sym
		end if

	case AST_NODECLASS_IIF
		if( n->iif.falselabel = old_sym ) then
			n->iif.falselabel = new_sym
		end if

	case AST_NODECLASS_CALL
		'' too complex, let a helper function replace the symbols
		astReplaceSymbolOnCALL( n, old_sym, new_sym )

	end select

	'' walk
	if( n->l <> NULL ) then
		astReplaceSymbolOnTree( n->l, old_sym, new_sym )
	end if

	if( n->r <> NULL ) then
		astReplaceSymbolOnTree( n->r, old_sym, new_sym )
	end if

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' const helpers
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function astIsConstant( byval expr as ASTNODE ptr ) as integer
	'' Checks whether an expression is a CONST node (number literals,
	'' numeric constants), an access to a constant symbol (string literals
	'' and string constants are accessed through VAR nodes), or whether it
	'' has CONST on its data type.

	if( expr->sym ) then
		if( symbIsConstant( expr->sym ) ) then
			return TRUE
		end if
	end if

	return (astIsCONST( expr ) or typeIsConst( astGetFullType( expr ) ))
end function

'':::::
function astGetValueAsInt _
	( _
		byval n as ASTNODE ptr _
	) as integer

	assert( astIsCONST( n ) )

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = cint( astGetValLong( n ) )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = cint( astGetValFloat( n ) )

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	    if( FB_LONGSIZE = len( integer ) ) then
  	    	function = astGetValInt( n )
  	    else
  	    	function = cint( astGetValLong( n ) )
  	    end if

  	case else
  		function = astGetValInt( n )
  	end select

end function

'':::::
function astGetValueAsStr _
	( _
		byval n as ASTNODE ptr _
	) as string

	assert( astIsCONST( n ) )

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT
  		function = str( astGetValLong( n ) )

  	case FB_DATATYPE_ULONGINT
  		function = str( cast( ulongint, astGetValLong( n ) ) )

	case FB_DATATYPE_SINGLE
		function = str( csng( astGetValFloat( n ) ) )

	case FB_DATATYPE_DOUBLE
		function = str( astGetValFloat( n ) )

  	case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
  		function = str( astGetValInt( n ) )

  	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = str( cast( uinteger, astGetValInt( n ) ) )
		else
			function = str( astGetValLong( n ) )
		end if

  	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = str( cast( uinteger, astGetValInt( n ) ) )
		else
			function = str( cast( ulongint, astGetValLong( n ) ) )
		end if

  	case else
  		function = str( cast( uinteger, astGetValInt( n ) ) )
  	end select

end function

'':::::
function astGetValueAsWstr _
	( _
		byval n as ASTNODE ptr _
	) as wstring ptr

    static as wstring * 64+1 res

	assert( astIsCONST( n ) )

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT
		res = wstr( astGetValLong( n ) )

	case FB_DATATYPE_ULONGINT
		res = wstr( cast( ulongint, astGetValLong( n ) ) )

	case FB_DATATYPE_SINGLE
		res = wstr( csng( astGetValFloat( n ) ) )

	case FB_DATATYPE_DOUBLE
		res = wstr( astGetValFloat( n ) )

  	case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
  		res = wstr( astGetValInt( n ) )

  	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			res = wstr( cast( uinteger, astGetValInt( n ) ) )
		else
			res = wstr( astGetValLong( n ) )
		end if

	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			res = wstr( cast( uinteger, astGetValInt( n ) ) )
		else
			res = wstr( cast( ulongint, astGetValLong( n ) ) )
		end if

  	case else
		res = wstr( cast( uinteger, astGetValInt( n ) ) )
  	end select

  	function = @res

end function

'':::::
function astGetValueAsLongInt _
	( _
		byval n as ASTNODE ptr _
	) as longint

	assert( astIsCONST( n ) )

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = astGetValLong( n )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = clngint( astGetValFloat( n ) )

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	    if( FB_LONGSIZE = len( integer ) ) then
  			if( astGetDataType( n ) = FB_DATATYPE_LONG ) then
  				function = clngint( astGetValInt( n ) )
  			else
  				function = clngint( cuint( astGetValInt( n ) ) )
  			end if
  	   	else
  	    	function = astGetValLong( n )
  	    end if

  	case else
  		if( typeIsSigned( astGetDataType( n ) ) ) then
  			function = clngint( astGetValInt( n ) )
  		else
  			function = clngint( cuint( astGetValInt( n ) ) )
  		end if
  	end select

end function

'':::::
function astGetValueAsULongInt _
	( _
		byval n as ASTNODE ptr _
	) as ulongint

	assert( astIsCONST( n ) )

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = astGetValLong( n )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = hCastFloatToULongint( astGetValFloat( n ) )

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	    if( FB_LONGSIZE = len( integer ) ) then
  	    	function = culngint( cuint( astGetValInt( n ) ) )
  	    else
  	    	function = astGetValLong( n )
  	    end if

  	case else
  		function = culngint( cuint( astGetValInt( n ) ) )
  	end select

end function

function astGetValueAsDouble( byval n as ASTNODE ptr ) as double
	assert( astIsCONST( n ) )

	select case as const( astGetDataType( n ) )
	case FB_DATATYPE_ULONGINT
		'' without cunsg(), &hFFFFFFFFFFFFFFFFull would be seen as -1,
		'' causing the double to be -1 instead of the huge value...
		function = cdbl( cunsg( astGetValLong( n ) ) )

	case FB_DATATYPE_LONGINT
		function = cdbl( astGetValLong( n ) )

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = astGetValFloat( n )

	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = cdbl( cunsg( astGetValLong( n ) ) )
		else
			function = cdbl( cunsg( astGetValInt( n ) ) )
		end if

	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = cdbl( astGetValLong( n ) )
		else
			function = cdbl( astGetValInt( n ) )
		end if

	case FB_DATATYPE_UINT
		function = cdbl( cunsg( astGetValInt( n ) ) )

	case else
		function = cdbl( astGetValInt( n ) )
	end select
end function

'':::::
function astGetStrLitSymbol _
	( _
		byval n as ASTNODE ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = any

    function = NULL

   	if( astIsVAR( n ) ) then
		s = astGetSymbol( n )
		if( s <> NULL ) then
			if( symbGetIsLiteral( s ) ) then
				function = s
			end if
		end if
	end if

end function

'':::::
sub astCONST2FBValue _
	( _
		byval dst as FBVALUE ptr, _
		byval expr as ASTNODE ptr _
	)

	select case as const astGetDataType( expr )
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		dst->long = astGetValLong( expr )

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		dst->float = astGetValFloat( expr )

	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			dst->int = astGetValInt( expr )
		else
			dst->long = astGetValLong( expr )
		end if

	case else
		dst->int = astGetValInt( expr )
	end select

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' checks
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function astCheckConst _
	( _
		byval dtype as integer, _
		byval n as ASTNODE ptr, _
		byval show_warn as integer _
	) as integer

	dim as integer result = any
	dim as double dval = any
	dim as single sval = any
	dim as longint lval = any

	result = TRUE

	''
	'' x86/32-bit assumptions
	'' assuming dtype has been stripped of const info
	''
	'' We don't want to show overflow warnings for conversions where only
	'' the sign differs, such as integer <-> uinteger, because in that case
	'' there is no data/precision loss. Technically speaking there can be
	'' overflows in such a conversion, but it's trivial to convert back
	'' and nothing is lost. It would probably be rather annoying to have
	'' warnings about it in many cases, such as:
	''    dim a as uinteger = -1
	''    dim b as uinteger = 1 shl 31
	''

	select case as const( dtype )
	''case FB_DATATYPE_DOUBLE
		'' DOUBLE can hold all the other dtype's values;
		'' perhaps not with 100% precision (e.g. huge ULONGINTs will
		'' lose some least-significant digits), but the DOUBLE doesn't
		'' overflow to INF (the same can be seen with SINGLEs, but at
		'' least those can be overflown with really huge DOUBLEs).
		'' Thus, no checks are needed for DOUBLE.

	case FB_DATATYPE_SINGLE
		'' anything to SINGLE: show warning when out of SINGLE limits
		'' min = 1.401298e-45
		'' max = 3.402823e+38

		dval = astGetValueAsDouble( n )

		select case abs( dval )
		case 0.0, 2e-45 to 3e+38 '' definitely no overflow: comfortably within SINGLE bounds
			result = TRUE
		case else '' might overflow - slower/more thorough test
			
			sval = csng( dval )

		  	#define IS_INFINITY_OR_ZERO(x) ( (x) + (x) = (x) )
			'' if sval is infinity or 0, then dval must also have been otherwise there was an overflow/underflow
			if IS_INFINITY_OR_ZERO( sval ) then
				result = IS_INFINITY_OR_ZERO( dval )
			else
				result = TRUE
			end if
		end select

	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT, _
	     FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, FB_DATATYPE_ENUM, _
	     FB_DATATYPE_LONG, FB_DATATYPE_ULONG, _
	     FB_DATATYPE_SHORT, FB_DATATYPE_USHORT, FB_DATATYPE_WCHAR, _
	     FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE, FB_DATATYPE_CHAR

		select case as const( typeGetSize( dtype ) )
		case 1
			lval = astGetValueAsLongInt( n )
			result = ((lval >= -128) and (lval <= 255))
		case 2
			lval = astGetValueAsLongInt( n )
			result = ((lval >= -32768) and (lval <= 65535))
		case 4
			lval = astGetValueAsLongInt( n )
			result = ((lval >= -2147483648u) and (lval <= 4294967295u))
		case 8
			'' longints can hold most other type's values, except floats
			'' float?
			if( typeGetClass( astGetDataType( n ) ) = FB_DATACLASS_FPOINT ) then
				dval = astGetValueAsDouble( n )
				result = ((dval >= -9223372036854775808ull) and _
					  (dval <= 18446744073709551615ull))
			end if
		end select

	case FB_DATATYPE_BITFIELD
		'' !!!WRITEME!!! use ->subtype's
	end select

	if( show_warn and (result = FALSE) ) then
		errReportWarn( FB_WARNINGMSG_CONVOVERFLOW )
	end if

	function = result
end function

'':::::
function astPtrCheck _
	( _
		byval pdtype as integer, _
		byval psubtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval strictcheck as integer _
	) as integer

	dim as integer edtype = any

	function = FALSE

	edtype = astGetFullType( expr )

	'' expr not a pointer?
	if (typeIsPtr(edtype) = FALSE) then
		'' Only ok if it's a 0 constant
		if (astIsCONST(expr) = FALSE) then
			exit function
		end if
		if( typeGetClass( edtype ) = FB_DATACLASS_INTEGER ) then
			return (astGetValueAsLongint( expr ) = 0)
		end if
		return FALSE
	end if

	'' different constant masks?
	if( strictcheck ) then
		if( typeGetPtrConstMask( edtype ) <> _
			typeGetPtrConstMask( pdtype ) ) then
			exit function
		end if
	end if

	'' different types?
	if( typeGetDtAndPtrOnly( pdtype ) <> typeGetDtAndPtrOnly( edtype ) ) then

    	'' remove the pointers
    	dim as integer pdtype_np = any, edtype_np = any
    	pdtype_np = typeGetDtOnly( pdtype )
    	edtype_np = typeGetDtOnly( edtype )

    	'' 1st) is one of them an ANY PTR?
    	if( pdtype_np = FB_DATATYPE_VOID ) then
    		return TRUE
    	elseif( edtype_np = FB_DATATYPE_VOID ) then
    		return TRUE
    	end if

    	'' 2nd) same level of indirection?
    	if( typeGetPtrCnt( pdtype ) <> typeGetPtrCnt( edtype ) ) then
    		exit function
    	end if

    	'' 4th) same size and class?
    	if( (pdtype_np <= FB_DATATYPE_DOUBLE) and _
    		(edtype_np <= FB_DATATYPE_DOUBLE) ) then
    		if( typeGetSize( pdtype_np ) = typeGetSize( edtype_np ) ) then
    			if( typeGetClass( pdtype_np ) = typeGetClass( edtype_np ) ) then
    				return TRUE
    			end if
    		end if
    	end if

    	exit function
    end if

	'' check sub types
	function = symbIsEqual( astGetSubType( expr ), psubtype )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' node type update
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function astUpdStrConcat( byval n as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr l = any, r = any

	function = n

	if( n = NULL ) then
		exit function
	end if

	select case as const astGetDataType( n )
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_WCHAR

	case else
		exit function
	end select

	'' walk
	l = n->l
	if( l <> NULL ) then
		n->l = astUpdStrConcat( l )
	end if

	r = n->r
	if( r <> NULL ) then
		n->r = astUpdStrConcat( r )
	end if

	'' convert "string + string" to "StrConcat( string, string )"
	if( n->class = AST_NODECLASS_BOP ) then
		if( n->op.op = AST_OP_ADD ) then
			l = n->l
			r = n->r
			dim as integer ldtype = astGetDataType( l ), rdtype = astGetDataType( r )
			if( astGetDataType( n ) <> FB_DATATYPE_WCHAR ) then
				function = rtlStrConcat( l, ldtype, r, rdtype )
			else
				function = rtlWstrConcat( l, ldtype, r, rdtype )
			end if
			astDelNode( n )
		end if
	end if

end function

'' Turn a comparison expression (or anything that can be compared = 0)
'' into a (conditional) branch
function astBuildBranch _
	( _
		byval n as ASTNODE ptr, _
		byval label as FBSYMBOL ptr, _
		byval is_inverse as integer, _
		byval is_iif as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any
	dim as integer dtype = any, call_dtors = any
	dim as FBSYMBOL ptr temp = any

	if( n = NULL ) then
		return NULL
	end if

	'' Optimize here already to ensure the toplevel BOP is final and can be
	'' relied upon for x86 flag assumptions below
	n = astOptimizeTree( n )

	dtype = astGetDataType( n )

	'' string? invalid..
	if( typeGetClass( dtype ) = FB_DATACLASS_STRING ) then
		return NULL
	end if

    '' CHAR and WCHAR literals are also from the INTEGER class
    select case as const dtype
    case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    	'' don't allow, unless it's a deref pointer
    	if( astIsDEREF( n ) = FALSE ) then
    		return NULL
    	end if

	'' UDT or CLASS?
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		dim as FB_ERRMSG err_num = any
		dim as FBSYMBOL ptr ovlProc = any

		'' check for a scalar overload..
		ovlProc = symbFindCastOvlProc( FB_DATATYPE_VOID, NULL, n, @err_num )
		if( ovlProc = NULL ) then
			'' no? try pointers...
			ovlProc = symbFindCastOvlProc( typeAddrOf( FB_DATATYPE_VOID ), NULL, _
										   n, _
										   @err_num )
			if( ovlProc = NULL ) then
				dim as FBSYMBOL ptr subtype = astGetSubtype( n )

				ovlProc = symbGetCompOpOvlHead( subtype, AST_OP_CAST )
				if( ovlProc = NULL ) then
					if( subtype <> NULL ) then
						errReport( FB_ERRMSG_NOMATCHINGPROC, _
								   TRUE, _
								   " """ & *symbGetName( subtype ) & ".cast()""" )
						return NULL
					end if
				end if

				errReport( FB_ERRMSG_NOMATCHINGPROC, TRUE )
				return NULL
			end if
		end if

		'' build cast call
		n = astBuildCall( ovlProc, n, NULL )
		dtype = astGetDataType( n )

	end select

	'' If the condition expression uses temp vars, we may have to call their
	'' dtors before branching (or instead insert the dtor calls at the two
	'' possible code blocks reached after the conditional branch).
	''
	'' For iif(), it's better to call the temp var dtors later, because
	'' we're still in the middle of an expression. A manual call to
	'' astDtorListFlush() may accidentally emit dtor calls for temp vars
	'' outside the iif(), e.g. in a statement like:
	''    foo = returnUdt( ).field + iif( returnUdt.field = 0, 1, 2 )
	''
	'' If it's a statement though (IF blocks, WHILE/UNTIL loops), we must
	'' call the temp var dtors manually (instead of letting astAdd() do it)
	'' in front of the branch, or else astAdd() would insert them behind
	'' the branch, where they would be unreachable dead code.
	''
	'' This only affects astBuildBranch() calls that may use a condition
	'' expression with temp vars, and are not immediately astAdd()'ed,
	'' but LINKed together with something instead.
	call_dtors = not (is_iif or astDTorListIsEmpty( ))

	select case( n->class )
	case AST_NODECLASS_CONST
		'' Note: a CONST expression will never use temp vars.
		'' Although the AST may have dtors registered from other parts
		'' of the expression if it's an iif(), iif() will (currently)
		'' optimize out itself when the condition is CONST, so this
		'' case never happens.
		assert( is_iif = FALSE )
		assert( call_dtors = FALSE )

		'' If the condition is...
		'' a) false (or true but inverted), emit a simple jump to jump
		''    over the IF block.
		'' b) true (or false but inverted), don't emit a jump at all,
		''    but fall trough to the IF block.
		if( astCONSTIsTrue( n ) = is_inverse ) then
			function = astNewBRANCH( AST_OP_JMP, label, NULL )
		else
			function = astNewNOP( )
		end if

		astDelNode( n )
		exit function

	case AST_NODECLASS_BOP
		'' relational operator?
		select case as const( n->op.op )
		case AST_OP_EQ, AST_OP_NE, AST_OP_GT, _
		     AST_OP_LT, AST_OP_GE, AST_OP_LE
			if( call_dtors = FALSE ) then
				'' Directly update this BOP to do the branch itself
				n->op.ex = label
				if( is_inverse = FALSE ) then
					n->op.op = astGetInverseLogOp( n->op.op )
				end if
				return n
			end if

		'' BOP that sets x86 flags?
		case AST_OP_ADD, AST_OP_SUB, AST_OP_SHL, AST_OP_SHR, _
		     AST_OP_AND, AST_OP_OR, AST_OP_XOR, AST_OP_IMP
		     ''AST_OP_EQV -- NOT doesn't set any flags, so EQV can't be optimized (x86 assumption)

			'' Can't optimize if dtors have be called, they'd trash the flags
			if( call_dtors = FALSE ) then
				dim as integer doopt = any

				if( typeGetClass( dtype ) = FB_DATACLASS_INTEGER ) then
					doopt = irGetOption( IR_OPT_CPUBOPFLAGS )
					if( doopt ) then
						select case as const dtype
						case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
							'' can't be done with longints either, as flag is set twice
							doopt = irGetOption( IR_OPT_64BITCPUREGS )
						end select
					end if
				else
					doopt = irGetOption( IR_OPT_FPUBOPFLAGS )
				end if

				if( doopt ) then
					'' Check against zero (= FALSE), relying on the flags set by the BOP;
					'' so it must not be removed by later astAdd() optimizations.
					return astNewBRANCH( iif( is_inverse, AST_OP_JNE, AST_OP_JEQ ), label, n )
				end if
			end if

		end select

	end select

	'' No optimization could be done, check expression against zero
	expr = n
	n = NULL

	'' Remap zstring/wstring types, we don't want the temp var to be a
	'' string, or the comparison against zero to be a string comparison...
	select case( dtype )
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		dtype = typeRemap( dtype, expr->subtype )
	end select

	if( call_dtors ) then
		'' 1. assign the condition to a temp var
		temp = symbAddTempVar( dtype, expr->subtype )
		n = astBuildVarAssign( temp, expr )

		'' 2. call dtors
		n = astNewLINK( n, astDtorListFlush( ) )

		'' 3. branch if tempvar = zero
		expr = astNewVAR( temp )
	end if

	'' Check expression against zero (= FALSE)
	n = astNewLINK( n, _
		astNewBOP( iif( is_inverse, AST_OP_NE, AST_OP_EQ ), _
			expr, astNewCONSTz( dtype, expr->subtype ), _
			label, AST_OPOPT_NONE ) )

	function = n
end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' temp destructors handling
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

sub astDtorListAdd( byval sym as FBSYMBOL ptr )
	dim as AST_DTORLIST_ITEM ptr n = any
	dim as integer add = any

	assert( symbIsVar( sym ) )

	'' Everything with a destructor (classes)
	add = symbHasDtor( sym )

	'' But also dynamic [w]strings
	select case( symbGetType( sym ) )
	case FB_DATATYPE_STRING
		add = TRUE

	case typeAddrOf( FB_DATATYPE_WCHAR )
		add or= symbGetIsWstring( sym )

	end select

	if( add ) then
		n = listNewNode( @ast.dtorlist )
		n->sym = sym

		with( ast.dtorlistscopes )
			'' If inside a dtorlist scope, mark the new entry
			'' with the scope's cookie
			if( .count > 0 ) then
				n->cookie = .cookies[.count-1]
			else
				n->cookie = 0
			end if
		end with
	end if
end sub

function astDtorListFlush( byval cookie as integer ) as ASTNODE ptr
    dim as AST_DTORLIST_ITEM ptr n = any, p = any
	dim as ASTNODE ptr t = any

	'' call the dtors in the reverse order
	t = NULL
	n = listGetTail( @ast.dtorlist )
	while( n )
		p = listGetPrev( n )

		'' astDtorListFlush() shouldn't be called without cookie
		'' while there still are entries registered with cookies,
		'' they probably should have been flushed first.
		assert( iif( cookie = 0, n->cookie = 0, TRUE ) )

		'' Only call dtors for the given cookie number
		if( n->cookie = cookie ) then
			t = astNewLINK( t, astBuildVarDtorCall( n->sym ) )
			listDelNode( @ast.dtorlist, n )
		end if

		n = p
	wend

	if( cookie = 0 ) then
		ast.dtorlistcookies = 0  '' Can aswell be reset
	end if

	function = t
end function

sub astDtorListDel( byval sym as FBSYMBOL ptr )
    dim as AST_DTORLIST_ITEM ptr n = any

	n = listGetTail( @ast.dtorlist )
	do while( n <> NULL )
		if( n->sym = sym ) then
			listDelNode( @ast.dtorlist, n )
			exit do
		end if

		n = listGetPrev( n )
    loop
end sub

'' Opens a new dtorlist "scope", the newly allocated cookie number will be used
'' to mark all dtorlist entries added by astDtorListAdd()'s while in this scope.
sub astDtorListScopeBegin( )
	'' Allocate new cookie
	ast.dtorlistcookies += 1

	'' Add new scope with that cookie
	with( ast.dtorlistscopes )
		'' No more room? Enlarge the array
		if( .count = .room ) then
			.room += 8
			.cookies = xreallocate( .cookies, sizeof( *.cookies ) * .room )
		end if
		.cookies[.count] = ast.dtorlistcookies
		.count += 1
	end with
end sub

'' Closes the scope and returns its cookie number so it can be passed through
'' to the following astNewIIF()
function astDtorListScopeEnd( ) as integer
	'' Pop entry from the scopes stack
	with( ast.dtorlistscopes )
		assert( .count > 0 )
		function = .cookies[.count-1]
		.count -= 1
	end with
end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' hacks
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astSetType _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

    astGetFullType( n ) = dtype
    n->subtype = subtype

	select case n->class
	case AST_NODECLASS_LINK
		if( n->link.ret_left ) then
			astSetType( n->l, dtype, subtype )
		else
			astSetType( n->r, dtype, subtype )
		end if

	case AST_NODECLASS_FIELD
		astSetType( n->l, dtype, subtype )

	case AST_NODECLASS_CALLCTOR
		'' Propagate type change up to the temp VAR access, since that's
		'' what will be returned by astLoadCALLCTOR().
		astSetType( n->r, dtype, subtype )

		'' This happens with field accesses on a CALLCTOR expression
		'' such as (UDT( )).field. The access to offset 0 of the temp
		'' UDT var is optimized out, causing the CALLCTOR expression to
		'' be changed over to the field's dtype for a "direct" access.

	case AST_NODECLASS_IIF
		astSetType( n->l, dtype, subtype )

#if __FB_DEBUG__
	case AST_NODECLASS_TYPEINI
		'' TYPEINI types shouldn't be changed by optimizations,
		'' it would cause astTypeIniUpdate() to use the wrong type
		'' for the temp var.
		assert( FALSE )
#endif

	end select

end sub

function astSizeOf( byval n as ASTNODE ptr ) as integer
	function = symbCalcLen( n->dtype, n->subtype )

	'' If it's a STRING * N, we must get the real length from the
	'' associated symbol, since the N isn't encoded in the dtype/subtype.
	select case( typeGetDtAndPtrOnly( n->dtype ) )
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, FB_DATATYPE_FIXSTR
		if( n->sym ) then
			function = symbGetLen( n->sym )
		end if
	end select
end function

function astIsAccessToLocal( byval expr as ASTNODE ptr ) as integer
	function = FALSE

	select case( astGetClass( expr ) )
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX
		'' Disallow local vars/arrays
		function = symbIsLocal( expr->sym ) and (not symbIsStatic( expr->sym ))

	case AST_NODECLASS_CALL
		'' No CALLs can be allowed - either their result
		'' is in registers or in a local temp var.
		'' Note: functions returning BYREF are ok,
		'' they appear here as DEREFs.
		function = TRUE

	case AST_NODECLASS_FIELD
		if( astIsDEREF( expr->l ) ) then
			if( astIsBOP( expr->l->l, AST_OP_ADD ) ) then
				if( astGetClass( expr->l->l->l ) = AST_NODECLASS_ADDROF ) then
					'' will be a VAR/FIELD again
					function = astIsAccessToLocal( expr->l->l->l->l )
				end if
			end if
		end if

	end select

end function
