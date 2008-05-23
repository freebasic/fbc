'' misc AST function
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

declare sub astReplaceSymbolOnCALL _
	( _
		byval n as ASTNODE ptr, _
		byval old_sym as FBSYMBOL ptr, _
		byval new_sym as FBSYMBOL ptr _
	)

'' globals
	dim shared as longint ast_minlimitTB( FB_DATATYPE_LOW_INDEX to FB_DATATYPE_UPP_INDEX ) = _
	{ _
/'		-1LL, _									'' boolean byte
		-1LL, _									'' boolean integer '/ _
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

	dim shared as ulongint ast_maxlimitTB( FB_DATATYPE_LOW_INDEX to FB_DATATYPE_UPP_INDEX ) = _
	{ _
/'		1ULL, _                                 '' boolean byte
		1ULL _                                  '' boolean integer '/ _
		127ULL, _                               '' byte
		255ULL, _                               '' ubyte
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


'':::::
sub astMiscInit

	''
	listNew( @ast.dtorlist, 64, len( AST_DTORLIST_ITEM ), LIST_FLAGS_NOCLEAR )

	ast.flushdtorlist = TRUE

	'' wchar len depends on the target platform
	ast_minlimitTB(FB_DATATYPE_WCHAR) = ast_minlimitTB(env.target.wchar.type)
	ast_maxlimitTB(FB_DATATYPE_WCHAR) = ast_maxlimitTB(env.target.wchar.type)

    '' !!!FIXME!!! remap [u]long to [u]longint if target = 64-bit

end sub

'':::::
sub astMiscEnd

	listFree( @ast.dtorlist )

End sub

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
			if( l->con.val.int <> r->con.val.int ) then
				exit function
			end if
		end select

	case AST_NODECLASS_ENUM
		if( l->con.val.int <> r->con.val.int ) then
			exit function
		end if

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
			if( (s->attrib and _
				(FB_SYMBATTRIB_PARAMBYDESC or FB_SYMBATTRIB_PARAMBYREF)) > 0 ) then
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
	case AST_NODECLASS_BOP, AST_NODECLASS_UOP
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

''::::
function astFindLocalSymbol _
	( _
		byval n as ASTNODE ptr _
	) as FBSYMBOL ptr

	if( n = NULL ) then
		return NULL
	end if

	if( n->sym <> NULL ) then
		if( symbIsLocal( n->sym ) ) then
			'' temps will be moved to global in typeIni()
			if( symbIsTemp( n->sym ) = FALSE ) then
				return n->sym
			end if
		end if
	end if

	'' walk
	if( n->l <> NULL ) then
		dim as FBSYMBOL ptr s = astFindLocalSymbol( n->l )
		if( s <> NULL ) then
			return s
		end if
	end if

	if( n->r <> NULL ) then
		function = astFindLocalSymbol( n->r )
	else
		function = NULL
	end if

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' const helpers
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astGetValueAsInt _
	( _
		byval n as ASTNODE ptr _
	) as integer

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

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT
  		function = str( astGetValLong( n ) )

  	case FB_DATATYPE_ULONGINT
  		function = str( cast( ulongint, astGetValLong( n ) ) )

	case FB_DATATYPE_SINGLE
		function = str( csng( astGetValFloat( n ) ) )

	case FB_DATATYPE_DOUBLE
		function = str( astGetValFloat( n ) )

  	case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM, _
		 FB_DATATYPE_BOOL8, FB_DATATYPE_BOOL32

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

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT
		res = wstr( astGetValLong( n ) )

	case FB_DATATYPE_ULONGINT
		res = wstr( cast( ulongint, astGetValLong( n ) ) )

	case FB_DATATYPE_SINGLE
		res = wstr( csng( astGetValFloat( n ) ) )

	case FB_DATATYPE_DOUBLE
		res = wstr( astGetValFloat( n ) )

  	case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM, _
		 FB_DATATYPE_BOOL8, FB_DATATYPE_BOOL32

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
  		if( symbIsSigned( astGetDataType( n ) ) ) then
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

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = astGetValLong( n )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = culngint( astGetValFloat( n ) )

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

'':::::
function astGetValueAsDouble _
	( _
		byval n as ASTNODE ptr _
	) as double

  	select case as const astGetDataType( n )
  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  	    function = cdbl( astGetValLong( n ) )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		function = astGetValFloat( n )

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	    if( FB_LONGSIZE = len( integer ) ) then
  	    	function = cdbl( astGetValLong( n ) )
  	    else
  	    	function = cdbl( astGetValInt( n ) )
  	    end if

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

'':::::
function astCheckConst _
	( _
		byval dtype as integer, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	'' x86/32-bit assumptions
	'' assuming dtype has been stripped of const info

    select case as const dtype
    case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		dim as double dval = any, dmin = any, dmax = any

		if( dtype = FB_DATATYPE_SINGLE ) then
			dmin = 1.175494351e-38
			dmax = 3.402823466e+38
		else
			dmin = 2.2250738585072014e-308
			dmax = 1.7976931348623147e+308
		end if

		dval = abs( astGetValueAsDouble( n ) )
    	if( dval <> 0 ) then
    		if( (dval < dmin) or (dval > dmax) ) then
    			errReport( FB_ERRMSG_MATHOVERFLOW, TRUE )
			end if
		end if

	case FB_DATATYPE_LONGINT

chk_long:
		'' unsigned constant?
		if( symbIsSigned( astGetDataType( n ) ) = FALSE ) then
			'' too big?
			if( astGetValueAsULongInt( n ) > 9223372036854775807ULL ) then
				n = astNewCONV( dtype, NULL, n )
				errReportWarn( FB_WARNINGMSG_CONVOVERFLOW )
			end if
		end if

	case FB_DATATYPE_ULONGINT

chk_ulong:
		'' signed constant?
		if( symbIsSigned( astGetDataType( n ) ) ) then
			'' too big?
			if( astGetValueAsLongInt( n ) and &h8000000000000000 ) then
				n = astNewCONV( dtype, NULL, n )
				errReportWarn( FB_WARNINGMSG_CONVOVERFLOW )
			end if
		end if

    case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, _
    	 FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM

chk_int:
		dim as longint lval = any

		lval = astGetValueAsLongInt( n )
		if( (lval < ast_minlimitTB( dtype )) or _
			(lval > clngint( ast_maxlimitTB( dtype ) )) ) then
			n = astNewCONV( dtype, NULL, n )
			errReportWarn( FB_WARNINGMSG_CONVOVERFLOW )
		end if

    case FB_DATATYPE_UBYTE, FB_DATATYPE_CHAR, _
    	 FB_DATATYPE_USHORT, FB_DATATYPE_WCHAR, _
    	 FB_DATATYPE_UINT

chk_uint:
		dim as ulongint ulval = any

		ulval = astGetValueAsULongInt( n )
		if( (ulval < culngint( ast_minlimitTB( dtype ) )) or _
			(ulval > ast_maxlimitTB( dtype )) ) then
			n = astNewCONV( dtype, NULL, n )
			errReportWarn( FB_WARNINGMSG_CONVOVERFLOW )
		end if

	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			goto chk_int
		else
			goto chk_long
		end if

	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			goto chk_uint
		else
			goto chk_ulong
		end if

	case FB_DATATYPE_BOOL8
	case FB_DATATYPE_BOOL32
	case FB_DATATYPE_BITFIELD
		'' !!!WRITEME!!! use ->subtype's
	end select

	function = n

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

	select case astGetClass( expr )
	case AST_NODECLASS_CONST, AST_NODECLASS_ENUM
    	'' expr not a pointer?
    	if( typeIsPtr( edtype ) = FALSE ) then
    		'' not NULL?
    		if( astGetValInt( expr ) <> NULL ) then
    			exit function
    		else
    			return TRUE
    		end if
    	end if

	case else
    	'' expr not a pointer?
    	if( typeIsPtr( edtype ) = FALSE ) then
    		exit function
    	end if
	end select

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
    		if( symbGetDataSize( pdtype_np ) = symbGetDataSize( edtype_np ) ) then
    			if( symbGetDataClass( pdtype_np ) = symbGetDataClass( edtype_np ) ) then
    				return TRUE
    			end if
    		end if
    	end if

    	exit function
    end if

	'' check sub types
	function = symbIsEqual( psubtype, astGetSubType( expr ) )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' node type update
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astUpdStrConcat _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	static as ASTNODE ptr l, r

	function = n

	if( n = NULL ) then
		exit function
	end if

	'' this proc will be called for each function param, same
	'' with assignment -- assuming here that IIF won't
	'' support strings
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

'':::::
function astUpdComp2Branch _
	( _
		byval n as ASTNODE ptr, _
		byval label as FBSYMBOL ptr, _
		byval isinverse as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr l = any, expr = any
	dim as integer dtype = any, istrue = any

#macro hDoBranch( )
	'' no dtors to call? do an ordinary branch
	if( call_dtors = FALSE ) then
		n = astNewBOP( iif( isinverse, AST_OP_NE, AST_OP_EQ ), _
					   n, _
					   expr, _
					   label, _
					   AST_OPOPT_NONE )

	'' otherwise..
	else
		dim as FBSYMBOL ptr next_label = symbAddLabel( NULL )
		'' branch over the dtor calls
		n = astNewBOP( iif( isinverse, AST_OP_EQ, AST_OP_NE ), _
					   n, _
					   expr, _
					   next_label, _
					   AST_OPOPT_NONE )

		'' do the dtor calls and branch, and also emit the next label
		n = astNewLINK( astNewLINK( astDTorListFlush( n, FALSE ), _
									astNewBRANCH( AST_OP_JMP, label, NULL ) ), _
    					astNewLABEL( next_label ) )
	end if
#endmacro


	if( n = NULL ) then
		return NULL
	end if

	'' the expr must be already optimized because the x86 flag assumptions done below
	n = astOptimizeTree( n )

	dtype = astGetDataType( n )

	'' string? invalid..
	if( symbGetDataClass( dtype ) = FB_DATACLASS_STRING ) then
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

	'' if there's any temp instance, we can't branch without calling the dtors
	dim as integer call_dtors = (astDTorListIsEmpty( ) = FALSE)

	'' shortcut "exp logop exp" if it's at top of tree (used to optimize IF/ELSEIF/WHILE/UNTIL)
	if( n->class <> AST_NODECLASS_BOP ) then
#if 0
		'' UOP? check if it's a NOT
		if( n->class = AST_NODECLASS_UOP ) then
			if( n->op.op = AST_OP_NOT ) then
				l = astUpdComp2Branch( n->l, label, isinverse = FALSE )
				astDelNode( n )
				return l
			end if
		end if
#endif

		'' CONST?
		if( astIsCONST( n ) ) then
			if( isinverse = FALSE ) then
				'' branch if false
				select case as const dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					istrue = n->con.val.long = 0

				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					istrue = n->con.val.float = 0

  				case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	   				if( FB_LONGSIZE = len( integer ) ) then
  	   					istrue = n->con.val.int = 0
  	   				else
  	   					istrue = n->con.val.long = 0
  	   				end if

				case else
					istrue = n->con.val.int = 0
				end select

				if( istrue ) then
					astDelNode( n )
					n = astNewLINK( astDTorListFlush( NULL, FALSE ), _
									astNewBRANCH( AST_OP_JMP, label, NULL ) )
				end if
			else
				'' branch if true
				select case as const dtype
				case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
					istrue = n->con.val.long <> 0

				case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
					istrue = n->con.val.float <> 0

  				case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	   				if( FB_LONGSIZE = len( integer ) ) then
  	   					istrue = n->con.val.int <> 0
  	   				else
  	   					istrue = n->con.val.long <> 0
  	   				end if

				case else
					istrue = n->con.val.int <> 0
				end select

				if( istrue ) then
					astDelNode( n )
					n = astNewLINK( astDTorListFlush( NULL, FALSE ), _
									astNewBRANCH( AST_OP_JMP, label, NULL ) )
				end if
			end if

		else
			'' otherwise, check if zero (ie= FALSE)

			'' zstring? astNewBOP will think both are zstrings..
			select case as const dtype
			case FB_DATATYPE_CHAR
				dtype = FB_DATATYPE_UINT
			case FB_DATATYPE_WCHAR
				dtype = env.target.wchar.type
			end select

			select case as const dtype
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				expr = astNewCONSTl( 0, dtype )

			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				expr = astNewCONSTf( 0.0, dtype )

  			case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	   			if( FB_LONGSIZE = len( integer ) ) then
  	   				expr = astNewCONSTi( 0, dtype )
  	   			else
  	   				expr = astNewCONSTl( 0, dtype )
  	   			end if

			case else
				expr = astNewCONSTi( 0, dtype )
			end select

			hDoBranch( )
		end if

		'' exit
		return n
	end if

	'' relational operator?
	select case as const n->op.op
	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE

		if( call_dtors = FALSE ) then
			'' tell IR that the destine label is already set
			n->op.ex = label

			'' invert it
			if( isinverse = FALSE ) then
				n->op.op = astGetInverseLogOp( n->op.op )
			end if

		else
			dim as FBSYMBOL ptr next_label = symbAddLabel( NULL )

			n->op.ex = next_label

			'' do the dtor calls and branch, and also emit the next label
			n = astNewLINK( astNewLINK( astDTorListFlush( n, FALSE ), _
										astNewBRANCH( AST_OP_JMP, label, NULL ) ), _
    						astNewLABEL( next_label ) )
		end if

		return n

	'' binary op that sets the flags?
	case AST_OP_ADD, AST_OP_SUB, AST_OP_SHL, AST_OP_SHR, _
		 AST_OP_AND, AST_OP_OR, AST_OP_XOR, AST_OP_IMP
		 ', AST_OP_EQV -- NOT doesn't set any flags, so EQV can't be optimized (x86 assumption)

		'' can't optimize if dtors have be called
		if( call_dtors = FALSE ) then
			dim as integer doopt = any

			if( symbGetDataClass( dtype ) = FB_DATACLASS_INTEGER ) then
				doopt = irGetOption( IR_OPT_CPU_BOPSETFLAGS )

				if( doopt ) then
					select case as const dtype
					case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
						'' can't be done with longints either, as flag is set twice
						doopt = irGetOption( IR_OPT_CPU_64BITREGS )
					end select
				end if

			else
				doopt = irGetOption( IR_OPT_FPU_BOPSETFLAGS )
			end if

			if( doopt ) then
				'' check if zero (ie= FALSE)
				return astNewBRANCH( iif( isinverse, AST_OP_JNE, AST_OP_JEQ ), label, n )
			end if
		end if

	end select

	'' if no optimization could be done, check if zero (ie= FALSE)
	select case as const dtype
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		expr = astNewCONSTl( 0, dtype )

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		expr = astNewCONSTf( 0.0, dtype )

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  	   	if( FB_LONGSIZE = len( integer ) ) then
  	   		expr = astNewCONSTi( 0, dtype )
  	   	else
  	   		expr = astNewCONSTl( 0, dtype )
  	   	end if

	case else
		expr = astNewCONSTi( 0, dtype )
	end select

	hDoBranch( )

	function = n

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' temp destructors handling
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astDtorListAdd _
	( _
		byval sym as FBSYMBOL ptr _
	) as AST_DTORLIST_ITEM ptr

	dim as AST_DTORLIST_ITEM ptr n = any

	n = listNewNode( @ast.dtorlist )

	n->sym = sym

	function = n

end function

'':::::
function astDtorListFlush _
	( _
		byval expr as ASTNODE ptr, _
		byval del_nodes as integer _
	) as ASTNODE ptr

    dim as AST_DTORLIST_ITEM ptr n = any, p = any
    dim as ASTNODE ptr dtorexpr = NULL

	'' call the dtors in the reverse order
	n = listGetTail( @ast.dtorlist )
	do while( n <> NULL )
        dtorexpr = astNewLINK( dtorexpr, astBuildVarDtorCall( n->sym ) )

		p = listGetPrev( n )

		if( del_nodes ) then
			listDelNode( @ast.dtorlist, n )
		end if

		n = p
    loop

    '' the current node should be the first to be flushed
    function = astNewLINK( expr, dtorexpr )

end function

'':::::
sub astDtorListClear _
	( _
	)

    dim as AST_DTORLIST_ITEM ptr n = any, p = any

	n = listGetTail( @ast.dtorlist )
	do while( n <> NULL )
		p = listGetPrev( n )
		listDelNode( @ast.dtorlist, n )
		n = p
    loop

end sub

'':::::
sub astDtorListDel _
	( _
		byval sym as FBSYMBOL ptr _
	)

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

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' hacks
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub astIncOffset _
	( _
		byval n as ASTNODE ptr, _
		byval ofs as integer _
	)

	select case as const n->class
	case AST_NODECLASS_VAR
		n->var_.ofs += ofs

	case AST_NODECLASS_IDX
		n->idx.ofs += ofs

	case AST_NODECLASS_DEREF
		n->ptr.ofs += ofs

	case AST_NODECLASS_LINK
		if( n->link.ret_left ) then
			astIncOffset( n->l, ofs )
		else
			astIncOffset( n->r, ofs )
		end if

	case AST_NODECLASS_FIELD
		astIncOffset( n->l, ofs )

	case else
		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
	end select

end sub

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

	end select

end sub


