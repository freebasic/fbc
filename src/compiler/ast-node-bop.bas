'' AST binary operation nodes
'' l = left operand expression; r = right operand expression
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "dstr.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

'':::::
private function hStrLiteralConcat _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr s = any, ls = any, rs = any

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	'' new len = both strings' len less the 2 null-chars
	s = symbAllocStrConst( *symbGetVarLitText( ls ) + *symbGetVarLitText( rs ), _
						   symbGetStrLen( ls ) - 1 + symbGetStrLen( rs ) - 1 )

	function = astNewVAR( s )

	astDelNode( r )
	astDelNode( l )

end function

'':::::
private function hWstrLiteralConcat _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr s = any, ls = any, rs = any

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	if( symbGetType( ls ) <> FB_DATATYPE_WCHAR ) then
		'' new len = both strings' len less the 2 null-chars
		s = symbAllocWstrConst( wstr( *symbGetVarLitText( ls ) ) + *symbGetVarLitTextW( rs ), _
						    	symbGetStrLen( ls ) - 1 + symbGetWstrLen( rs ) - 1 )

	elseif( symbGetType( rs ) <> FB_DATATYPE_WCHAR ) then
		s = symbAllocWstrConst( *symbGetVarLitTextW( ls ) + wstr( *symbGetVarLitText( rs ) ), _
						    	symbGetWstrLen( ls ) - 1 + symbGetStrLen( rs ) - 1 )

	else
		s = symbAllocWstrConst( *symbGetVarLitTextW( ls ) + *symbGetVarLitTextW( rs ), _
						    	symbGetWstrLen( ls ) - 1 + symbGetWstrLen( rs ) - 1 )
    end if

	function = astNewVAR( s )

	astDelNode( r )
	astDelNode( l )

end function

'':::::
private function hStrLiteralCompare _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

    static as DZSTRING ltext, rtext
    dim as integer res = any

   	DZstrAssign( ltext, hUnescape( symbGetVarLitText( astGetSymbol( l ) ) ) )
   	DZstrAssign( rtext, hUnescape( symbGetVarLitText( astGetSymbol( r ) ) ) )

   	select case as const op
   	case AST_OP_EQ
   		res = (*ltext.data = *rtext.data)
   	case AST_OP_GT
   		res = (*ltext.data > *rtext.data)
   	case AST_OP_LT
   		res = (*ltext.data < *rtext.data)
   	case AST_OP_NE
   		res = (*ltext.data <> *rtext.data)
   	case AST_OP_LE
   		res = (*ltext.data <= *rtext.data)
   	case AST_OP_GE
   		res = (*ltext.data >= *rtext.data)
   	end select

	function = astNewCONSTi( res )

	astDelNode( r )
	astDelNode( l )

end function

'':::::
private function hWStrLiteralCompare _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr ls = any, rs = any
    static as DZSTRING textz
    static as DWSTRING ltextw, rtextw
    dim as integer res = any

	ls = astGetSymbol( l )
	rs = astGetSymbol( r )

	'' left operand not a wstring?
	if( symbGetType( ls ) <> FB_DATATYPE_WCHAR ) then
   		DZstrAssign( textz, hUnescape( symbGetVarLitText( ls ) ) )
   		DWstrAssign( rtextw, hUnescapeW( symbGetVarLitTextW( rs ) ) )

   		select case as const op
   		case AST_OP_EQ
   			res = (*textz.data = *rtextw.data)
   		case AST_OP_GT
   			res = (*textz.data > *rtextw.data)
   		case AST_OP_LT
   			res = (*textz.data < *rtextw.data)
   		case AST_OP_NE
   			res = (*textz.data <> *rtextw.data)
   		case AST_OP_LE
   			res = (*textz.data <= *rtextw.data)
   		case AST_OP_GE
   			res = (*textz.data >= *rtextw.data)
   		end select

   	'' right operand?
   	elseif( symbGetType( rs ) <> FB_DATATYPE_WCHAR ) then
   		DWstrAssign( ltextw, hUnescapeW( symbGetVarLitTextW( ls ) ) )
   		DZstrAssign( textz, hUnescape( symbGetVarLitText( rs ) ) )

   		select case as const op
   		case AST_OP_EQ
   			res = (*ltextw.data = *textz.data)
   		case AST_OP_GT
   			res = (*ltextw.data > *textz.data)
   		case AST_OP_LT
   			res = (*ltextw.data < *textz.data)
   		case AST_OP_NE
   			res = (*ltextw.data <> *textz.data)
   		case AST_OP_LE
   			res = (*ltextw.data <= *textz.data)
   		case AST_OP_GE
   			res = (*ltextw.data >= *textz.data)
   		end select

   	'' both wstrings..
   	else
   		DWstrAssign( ltextw, hUnescapeW( symbGetVarLitTextW( ls ) ) )
   		DWstrAssign( rtextw, hUnescapeW( symbGetVarLitTextW( rs ) ) )

   		select case as const op
   		case AST_OP_EQ
   			res = (*ltextw.data = *rtextw.data)
   		case AST_OP_GT
   			res = (*ltextw.data > *rtextw.data)
   		case AST_OP_LT
   			res = (*ltextw.data < *rtextw.data)
   		case AST_OP_NE
   			res = (*ltextw.data <> *rtextw.data)
   		case AST_OP_LE
   			res = (*ltextw.data <= *rtextw.data)
   		case AST_OP_GE
   			res = (*ltextw.data >= *rtextw.data)
   		end select

   	end if

	function = astNewCONSTi( res )

	astDelNode( r )
	astDelNode( l )

end function

private sub hToStr(byref l as ASTNODE ptr, byref r as ASTNODE ptr)
	dim as integer ldtype = any, rdtype = any

	ldtype = astGetDataType( l )
	rdtype = astGetDataType( r )

    '' convert left operand to string if needed
    select case as const ldtype
    case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
    	 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

    '' not a string..
    case else
		l = rtlToStr( l, FALSE )
		if( l = NULL ) then
				errReport( FB_ERRMSG_TYPEMISMATCH )
				'' error recovery: fake a new node
				l = astNewCONSTstr( NULL )
		end if
    end select


	'' convert the right operand to string if needed
   	select case as const rdtype
   	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
   		 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

   	'' not a string..
   	case else
   		'' expression is not a wstring?
   		if( ldtype <> FB_DATATYPE_WCHAR ) then
   			r = rtlToStr( r, FALSE )
   		else
   			r = rtlToWstr( r )
   		end if

   		if( r = NULL ) then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: fake a new node
			r = astNewCONSTstr( NULL )
   		end if
   	end select
end sub

private function hBOPConstFoldInt _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

	dim as integer issigned = any, ldfull = any
	dim as FBSYMBOL ptr lsubtype = any

	issigned = typeIsSigned( l->dtype )

	select case as const op
	case AST_OP_ADD
		l->con.val.int = l->con.val.int + r->con.val.int

	case AST_OP_SUB
		l->con.val.int = l->con.val.int - r->con.val.int

	case AST_OP_MUL
		if( issigned ) then
			l->con.val.int = l->con.val.int * r->con.val.int
		else
			l->con.val.int = cunsg(l->con.val.int) * cunsg(r->con.val.int)
		end if

	case AST_OP_INTDIV
		if( r->con.val.int <> 0 ) then
			if( issigned ) then
				l->con.val.int = l->con.val.int \ r->con.val.int
			else
				l->con.val.int = cunsg( l->con.val.int ) \ cunsg( r->con.val.int )
			end if
		else
			l->con.val.int = 0
			errReport( FB_ERRMSG_DIVBYZERO )
		end if

	case AST_OP_MOD
		if( r->con.val.int <> 0 ) then
			if( issigned ) then
				l->con.val.int = l->con.val.int mod r->con.val.int
			else
				l->con.val.int = cunsg( l->con.val.int ) mod cunsg( r->con.val.int )
			end if
		else
			l->con.val.int = 0
			errReport( FB_ERRMSG_DIVBYZERO )
		end if

	case AST_OP_SHL
		if( issigned ) then
			l->con.val.int = l->con.val.int shl r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) shl r->con.val.int
		end if

	case AST_OP_SHR
		if( issigned ) then
			l->con.val.int = l->con.val.int shr r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) shr r->con.val.int
		end if

	case AST_OP_AND
		l->con.val.int = l->con.val.int and r->con.val.int

	case AST_OP_OR
		l->con.val.int = l->con.val.int or r->con.val.int

	case AST_OP_ANDALSO
		if l->con.val.int then
			l->con.val.int = (r->con.val.int <> 0)
		else
			l->con.val.int = 0
		end if

	case AST_OP_ORELSE
		if l->con.val.int then
			l->con.val.int = -1
		else
			l->con.val.int = (r->con.val.int <> 0)
		end if

	case AST_OP_XOR
		l->con.val.int = l->con.val.int xor r->con.val.int

	case AST_OP_EQV
		l->con.val.int = l->con.val.int eqv r->con.val.int

	case AST_OP_IMP
		l->con.val.int = l->con.val.int imp r->con.val.int

	case AST_OP_NE
		l->con.val.int = l->con.val.int <> r->con.val.int

	case AST_OP_EQ
		l->con.val.int = l->con.val.int = r->con.val.int

	case AST_OP_GT
		if( issigned ) then
			l->con.val.int = l->con.val.int > r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) > cunsg( r->con.val.int )
		end if

	case AST_OP_LT
		if( issigned ) then
			l->con.val.int = l->con.val.int < r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) < cunsg( r->con.val.int )
		end if

	case AST_OP_LE
		if( issigned ) then
			l->con.val.int = l->con.val.int <= r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) <= cunsg( r->con.val.int )
		end if

	case AST_OP_GE
		if( issigned ) then
			l->con.val.int = l->con.val.int >= r->con.val.int
		else
			l->con.val.int = cunsg( l->con.val.int ) >= cunsg( r->con.val.int )
		end if
	end select

	'' Pretend the CONST is an integer for a moment, since the result was
	'' calculated and stored at INTEGER precision above, then do a CONV
	'' back to the original type and let it show any overflow warnings in
	'' case the real type cannot hold the calculated value.
	ldfull = l->dtype
	lsubtype = l->subtype
	l->dtype = FB_DATATYPE_INTEGER
	l->subtype = NULL

	function = astNewCONV( ldfull, lsubtype, l )
end function

'':::::
private sub hBOPConstFoldFlt _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) static

	select case as const op
	case AST_OP_ADD
		l->con.val.float = l->con.val.float + r->con.val.float

	case AST_OP_SUB
		l->con.val.float = l->con.val.float - r->con.val.float

	case AST_OP_MUL
		l->con.val.float = l->con.val.float * r->con.val.float

	case AST_OP_DIV
		'' Note: no division by zero error here - we should return
		'' INF instead, just like with (l / r) at runtime
		l->con.val.float = l->con.val.float / r->con.val.float

    case AST_OP_POW
		l->con.val.float = l->con.val.float ^ r->con.val.float

	case AST_OP_NE
		l->con.val.int = l->con.val.float <> r->con.val.float

	case AST_OP_EQ
		l->con.val.int = l->con.val.float = r->con.val.float

	case AST_OP_GT
		l->con.val.int = l->con.val.float > r->con.val.float

	case AST_OP_LT
		l->con.val.int = l->con.val.float < r->con.val.float

	case AST_OP_LE
		l->con.val.int = l->con.val.float <= r->con.val.float

	case AST_OP_GE
		l->con.val.int = l->con.val.float >= r->con.val.float

    case AST_OP_ATAN2
		l->con.val.float = atan2( l->con.val.float, r->con.val.float )

	case AST_OP_ANDALSO
		if l->con.val.float then
			l->con.val.int = (r->con.val.float <> 0)
		else
			l->con.val.int = 0
		end if

	case AST_OP_ORELSE
		if l->con.val.float then
			l->con.val.int = -1
		else
			l->con.val.int = (r->con.val.float <> 0)
		end if
	end select

end sub

private sub hBOPConstFold64 _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	)

	dim as integer issigned = any

	issigned = typeIsSigned( l->dtype )

	select case as const op
	case AST_OP_ADD
		l->con.val.long = l->con.val.long + r->con.val.long

	case AST_OP_SUB
		l->con.val.long = l->con.val.long - r->con.val.long

	case AST_OP_MUL
		if( issigned ) then
			l->con.val.long = l->con.val.long * r->con.val.long
		else
			l->con.val.long = cunsg(l->con.val.long) * cunsg(r->con.val.long)
		end if

	case AST_OP_INTDIV
		if( r->con.val.long <> 0 ) then
			if( issigned ) then
				l->con.val.long = l->con.val.long \ r->con.val.long
			else
				l->con.val.long = cunsg( l->con.val.long ) \ cunsg( r->con.val.long )
			end if
		else
			l->con.val.long = 0
			errReport( FB_ERRMSG_DIVBYZERO )
		end if

	case AST_OP_MOD
		if( r->con.val.long <> 0 ) then
			if( issigned ) then
				l->con.val.long = l->con.val.long mod r->con.val.long
			else
				l->con.val.long = cunsg( l->con.val.long ) mod cunsg( r->con.val.long )
			end if
		else
			l->con.val.long = 0
			errReport( FB_ERRMSG_DIVBYZERO )
		end if

	case AST_OP_SHL
		if( issigned ) then
			l->con.val.long = l->con.val.long shl r->con.val.int
		else
			l->con.val.long = cunsg( l->con.val.long ) shl r->con.val.int
		end if

	case AST_OP_SHR
		if( issigned ) then
			l->con.val.long = l->con.val.long shr r->con.val.int
		else
			l->con.val.long = cunsg( l->con.val.long ) shr r->con.val.int
		end if

	case AST_OP_AND
		l->con.val.long = l->con.val.long and r->con.val.long

	case AST_OP_OR
		l->con.val.long = l->con.val.long or r->con.val.long

	case AST_OP_ANDALSO
		if l->con.val.long then
			l->con.val.long = (r->con.val.long <> 0)
		else
			l->con.val.long = 0
		end if

	case AST_OP_ORELSE
		if l->con.val.long then
			l->con.val.long = -1
		else
			l->con.val.long = (r->con.val.long <> 0)
		end if

	case AST_OP_XOR
		l->con.val.long = l->con.val.long xor r->con.val.long

	case AST_OP_EQV
		l->con.val.long = l->con.val.long eqv r->con.val.long

	case AST_OP_IMP
		l->con.val.long = l->con.val.long imp r->con.val.long

	case AST_OP_NE
		l->con.val.int = l->con.val.long <> r->con.val.long

	case AST_OP_EQ
		l->con.val.int = l->con.val.long = r->con.val.long

	case AST_OP_GT
		if( issigned ) then
			l->con.val.int = l->con.val.long > r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) > cunsg( r->con.val.long )
		end if

	case AST_OP_LT
		if( issigned ) then
			l->con.val.int = l->con.val.long < r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) < cunsg( r->con.val.long )
		end if

	case AST_OP_LE
		if( issigned ) then
			l->con.val.int = l->con.val.long <= r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) <= cunsg( r->con.val.long )
		end if

	case AST_OP_GE
		if( issigned ) then
			l->con.val.int = l->con.val.long >= r->con.val.long
		else
			l->con.val.int = cunsg( l->con.val.long ) >= cunsg( r->con.val.long )
		end if
	end select

end sub

'':::::
private function hCheckPointer _
	( _
		byval op as integer, _
		byval dtype as integer, _
		byval dclass as integer _
	) as integer

    '' not int?
    if( dclass <> FB_DATACLASS_INTEGER ) then
    	return FALSE

    '' CHAR and WCHAR literals are also from the INTEGER class
    else
    	select case typeGet( dtype )
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		return FALSE
        end select
    end if

    select case op
    '' add op?
    case AST_OP_ADD, AST_OP_SUB

    	'' another pointer?
    	if( typeIsPtr( dtype ) ) then
    		return FALSE
    	end if

    	return TRUE

	'' short-circuit ops?  operands will be checked against zero, so allow.
	case AST_OP_ANDALSO, AST_OP_ORELSE
		return TRUE

	'' relational op?
	case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_LE, AST_OP_GE

    	return TRUE

    case else
    	return FALSE
    end select

end function

'':::::
private function hDoPointerArith _
	( _
		byval op as integer, _
		byval p as ASTNODE ptr, _
		byval e as ASTNODE ptr, _
		byval swapped as integer = FALSE _
	) as ASTNODE ptr

    dim as integer edtype = any
    dim as integer lgt = any

    function = NULL

    edtype = astGetDataType( e )

    '' not integer class?
    if( typeGetClass( edtype ) <> FB_DATACLASS_INTEGER ) then
    	exit function

    '' CHAR and WCHAR literals are also from the INTEGER class (to allow *p = 0 etc)
    else
    	select case edtype
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		exit function
    	end select
    end if

	'' calc len( *p )
	lgt = symbCalcDerefLen( astGetDataType( p ), astGetSubType( p ) )
	if( lgt <= 0 ) then
		'' incomplete type
		exit function
	end if

    '' another pointer?
    if( typeIsPtr( edtype ) ) then
    	'' only allow if it's a subtraction
    	if( op = AST_OP_SUB ) then
    		'' types can't be different..
    		if( (edtype <> astGetDataType( p )) or _
    			(astGetSubType( e ) <> astGetSubType( p )) ) then
    			exit function
    		end if

    		'' convert to int or BOP will complain..
    		p = astNewCONV( FB_DATATYPE_INTEGER, NULL, p )
    		e = astNewCONV( FB_DATATYPE_INTEGER, NULL, e )

 			'' subtract..
 			e = astNewBOP( AST_OP_SUB, p, e )

 			'' and divide by length
			function = astNewBOP( AST_OP_INTDIV, e, astNewCONSTi( lgt ) )
    	end if

    	exit function
    end if

    '' not integer? convert
    if( edtype <> FB_DATATYPE_INTEGER ) then
    	e = astNewCONV( FB_DATATYPE_INTEGER, NULL, e )
    end if

    '' any op but +|-?
    select case op
    case AST_OP_ADD, AST_OP_SUB

		if( (op = AST_OP_SUB) andalso swapped ) then
			exit function
		end if

		'' multiple by length
		e = astNewBOP( AST_OP_MUL, e, astNewCONSTi( lgt ) )

		'' do op
		function = astNewBOP( op, p, e )

    case else
    	'' allow AND and OR??
    	exit function
    end select

end function

'':::::
private function hConvertUDT_l _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ex as FBSYMBOL ptr, _
		byval options as AST_OPOPT _
	) as ASTNODE ptr

	dim as ASTNODE ptr t = any

	'' try to convert to l type
	t = astNewCONV( astGetFullType( l ), l->subtype, r )
    if( t <> NULL ) then
    	t = astNewBOP( op, l, t, ex, options or AST_OPOPT_NOCOERCION )
    	if( t <> NULL ) then
    		return t
    	end if
	end if

    '' try convert to r type
	t = astNewCONV( astGetFullType( r ), r->subtype, l )
    if( t <> NULL ) then
    	t = astNewBOP( op, t, r, ex, options or AST_OPOPT_NOCOERCION )
    	if( t <> NULL ) then
    		return t
    	end if
	end if

    '' try convert to the most precise type
	t = astNewCONV( FB_DATATYPE_VOID, NULL, l )
    if( t <> NULL ) then
    	'' coercion allowed, so hConvertUDT_r() can be called if r is an UDT too
    	return astNewBOP( op, t, r, ex, options )
	end if

	function = NULL

end function

'':::::
private function hConvertUDT_r _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ex as FBSYMBOL ptr, _
		byval options as AST_OPOPT _
	) as ASTNODE ptr

	dim as ASTNODE ptr t = any

	'' try to convert to r type
	t = astNewCONV( astGetFullType( r ), r->subtype, l )
	if( t <> NULL ) then
    	t = astNewBOP( op, t, r, ex, options or AST_OPOPT_NOCOERCION )
    	if( t <> NULL ) then
    		return t
    	end if
	end if

    '' try convert to l type
	t = astNewCONV( astGetFullType( l ), l->subtype, r )
    if( t <> NULL ) then
    	t = astNewBOP( op, l, t, ex, options or AST_OPOPT_NOCOERCION )
    	if( t <> NULL ) then
    		return t
    	end if
	end if

    '' try convert to the most precise type
	t = astNewCONV( FB_DATATYPE_VOID, NULL, r )
    if( t <> NULL ) then
    	return astNewBOP( op, l, t, ex, options or AST_OPOPT_NOCOERCION )
	end if

	function = NULL

end function

'':::::
#macro hDoGlobOpOverload _
	( _
		op, l, r _
	)

	if( symb.globOpOvlTb(op).head <> NULL ) then
		dim as FBSYMBOL ptr proc = any
		dim as FB_ERRMSG err_num = any

		proc = symbFindBopOvlProc( op, l, r, @err_num )
		if( proc <> NULL ) then
			'' build a proc call
			return astBuildCall( proc, l, r )
		else
			if( err_num <> FB_ERRMSG_OK ) then
				return NULL
			end if

			'' commutative?
			/'if( astGetOpIsCommutative( op ) ) then
				'' try (r, l) too
				proc = symbFindBopOvlProc( op, r, l, @err_num )
				if( proc <> NULL ) then
					'' build a proc call
					return astBuildCall( proc, r, l )
				else
					if( err_num <> FB_ERRMSG_OK ) then
						return NULL
					end if
				end if
			end if'/
		end if
	end if

#endmacro

private function hCheckDerefWcharPtr _
	( _
		byval l as ASTNODE ptr, _
		byval pldtype as integer ptr, _
		byval r as ASTNODE ptr, _
		byval rdtype as integer _
	) as integer

	dim as ASTNODE ptr ll = any

	'' Disallow if it's not a DEREF'ed wcharptr
	if( l->class <> AST_NODECLASS_DEREF ) then
		exit function
	end if

	'' Disallow if it's a fake dynamic string
	ll = l->l
	if( ll ) then
		if( ll->class = AST_NODECLASS_VAR ) then
			if( symbGetIsWstring( ll->sym ) ) then
				exit function
			end if
		end if
	end if

	'' remap the type or the optimizer can
	'' make a wrong assumption
	*pldtype = typeJoin( *pldtype, env.target.wchar )

	function = TRUE
end function

'':::::
function astNewBOP _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ex as FBSYMBOL ptr, _
		byval options as AST_OPOPT _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any
    dim as integer ldtype = any, rdtype = any, dtype = any
    dim as integer ldclass = any, rdclass = any
    dim as integer is_str = any
    dim as FBSYMBOL ptr litsym = any, subtype = any

	function = NULL

	'' check op overloading
	hDoGlobOpOverload( op, l, r )

	is_str = FALSE

	'' special cases..
	select case op
	case AST_OP_CONCAT
		hToStr( l, r )
		op = AST_OP_ADD
	case AST_OP_IS
		return rtlOOPIsTypeOf( l, r )
	end select

	ldtype = astGetFullType( l )
	rdtype = astGetFullType( r )
	ldclass = typeGetClass( ldtype )
	rdclass = typeGetClass( rdtype )

	'' UDT's? try auto-coercion
	if( (typeGet( ldtype ) = FB_DATATYPE_STRUCT) or _
		(typeGet( rdtype ) = FB_DATATYPE_STRUCT) ) then

		'' recursion?
		if( (options and AST_OPOPT_NOCOERCION) <> 0 ) then
			exit function
		end if

		'' l or both UDTs?
		if( typeGet( ldtype ) = FB_DATATYPE_STRUCT ) then
			return hConvertUDT_l( op, l, r, ex, options )

		'' only r is..
		else
			return hConvertUDT_r( op, l, r, ex, options )
		end if
    end if

	''::::::
    '' pointers?
    if( typeIsPtr( ldtype ) ) then
		'' do arithmetics?
		if( (options and AST_OPOPT_LPTRARITH) <> 0 ) then
    		return hDoPointerArith( op, l, r )
		else
    		if( hCheckPointer( op, rdtype, rdclass ) = FALSE ) then
    			exit function
    		end if
		end if

    elseif( typeIsPtr( rdtype ) ) then
		'' do arithmetics?
		if( (options and AST_OPOPT_RPTRARITH) <> 0 ) then
			return hDoPointerArith( op, r, l, TRUE )
		else
    		if( hCheckPointer( op, ldtype, ldclass ) = FALSE ) then
    			exit function
    		end if
		end if
    end if

    '' enums?
    if( (typeGet( ldtype ) = FB_DATATYPE_ENUM) or _
    	(typeGet( rdtype ) = FB_DATATYPE_ENUM) ) then
    	'' not the same?
    	if( ldtype <> rdtype ) then
    		if( (ldclass <> FB_DATACLASS_INTEGER) or _
    			(rdclass <> FB_DATACLASS_INTEGER) ) then
    			errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
    		end if
    	end if
    end if

    '' both zstrings? treat as string..
    if( (typeGet( ldtype ) = FB_DATATYPE_CHAR) and _
    	(typeGet( rdtype ) = FB_DATATYPE_CHAR) ) then
    	ldclass = FB_DATACLASS_STRING
    	rdclass = ldclass
    end if

    '' wstrings?
    if( (typeGet( ldtype ) = FB_DATATYPE_WCHAR) or _
    	(typeGet( rdtype ) = FB_DATATYPE_WCHAR) ) then

		'' not both wstrings?
		if( typeGetDtAndPtrOnly( ldtype ) <> typeGetDtAndPtrOnly( rdtype ) ) then
			if( typeGet( ldtype ) = FB_DATATYPE_WCHAR ) then
				'' is right a string?
				is_str = (rdclass = FB_DATACLASS_STRING) or (typeGet( rdtype ) = FB_DATATYPE_CHAR)
			else
				'' is left a string?
				is_str = (ldclass = FB_DATACLASS_STRING) or (typeGet( ldtype ) = FB_DATATYPE_CHAR)
			end if
		else
			is_str = TRUE
		end if

		if( is_str ) then

			'' check for string literals
			litsym = NULL
			select case typeGet( ldtype )
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				litsym = astGetStrLitSymbol( l )
				if( litsym <> NULL ) then
					select case rdtype
					case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
						litsym = astGetStrLitSymbol( r )
					case else
						litsym = NULL
					end select
				end if
			end select

			select case as const op
			'' concatenation?
			case AST_OP_ADD

				'' both literals?
				if( litsym <> NULL ) then
					'' ok to convert at compile-time?
					if( (typeGetDtAndPtrOnly( ldtype ) = typeGetDtAndPtrOnly( rdtype )) or _
					    env.wchar_doconv ) then
						return hWstrLiteralConcat( l, r )
					end if
				end if

				'' not both wstrings?
				if( typeGetDtAndPtrOnly( ldtype ) <> typeGetDtAndPtrOnly( rdtype ) ) then
					return rtlWstrConcat( l, ldtype, r, rdtype )
				end if

				'' result will be always a wstring
				ldtype = typeUnsetIsConst( typeJoin( ldtype, FB_DATATYPE_WCHAR ) )
				ldclass = FB_DATACLASS_INTEGER
				rdtype = typeJoin( rdtype, ldtype )
				rdclass = ldclass
				is_str = TRUE

				'' concatenation will only be done when loading,
				'' to allow optimizations..

			'' comparison?
			case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_LE, AST_OP_GE
				'' both literals?
				if( litsym <> NULL ) then
					return hWstrLiteralCompare( op, l, r )
				end if

				'' convert to: wstrcmp(l,r) op 0
				l = rtlWstrCompare( l, r )
				r = astNewCONSTi( 0 )

				ldtype = typeJoin( ldtype, astGetFullType( l ) )
				rdtype = typeJoin( rdtype, astGetFullType( r ) )
				ldclass = FB_DATACLASS_INTEGER
				rdclass = FB_DATACLASS_INTEGER

			'' no other operation allowed
			case else
				exit function
			end select

		'' One is not a string, but e.g. an integer. Disallow if the
		'' other is not a DEREF'ed wchar ptr - this allows comparisons
		'' such as "wstringptr[index] = someinteger", i.e. a simplified
		'' form of string indexing when dealing with a DEREF'ed ptr.
		else
			if( typeGet( ldtype ) = FB_DATATYPE_WCHAR ) then
				if( hCheckDerefWcharPtr( l, @ldtype, r, rdtype ) = FALSE ) then
					exit function
				end if
			else
				if( hCheckDerefWcharPtr( r, @rdtype, l, ldtype ) = FALSE ) then
					exit function
				end if
			end if
		end if

    '' strings?
    elseif( (typeGet( ldclass ) = FB_DATACLASS_STRING) or _
    		(typeGet( rdclass ) = FB_DATACLASS_STRING) ) then

		'' not both strings?
		if( typeGetDtAndPtrOnly( ldclass ) <> typeGetDtAndPtrOnly( rdclass ) ) then
			if( ldclass = FB_DATACLASS_STRING ) then
				'' not a zstring?
				if( typeGet( rdtype ) <> FB_DATATYPE_CHAR ) then
					exit function
				end if
			else
				'' not a zstring?
				if( typeGet( ldtype ) <> FB_DATATYPE_CHAR ) then
					exit function
				end if
			end if
		end if

		'' check for string literals
		litsym = NULL
		if( typeGet( ldtype ) = FB_DATATYPE_CHAR ) then
			if( typeGet( rdtype ) = FB_DATATYPE_CHAR ) then
				litsym = astGetStrLitSymbol( l )
				if( litsym <> NULL ) then
					litsym = astGetStrLitSymbol( r )
				end if
			end if
		end if

		select case as const op
		'' concatenation?
		case AST_OP_ADD
			'' both literals?
			if( litsym <> NULL ) then
				return hStrLiteralConcat( l, r )
			end if

			'' result will be always an var-len string
			ldtype = typeUnsetIsConst( typeJoin( ldtype, FB_DATATYPE_STRING ) )
			ldclass = FB_DATACLASS_STRING
			rdtype = typeJoin( rdtype, ldtype )
			rdclass = ldclass
			is_str = TRUE

			'' concatenation will only be done when loading,
			'' to allow optimizations..

		'' comparison?
		case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_LE, AST_OP_GE
			'' both literals?
			if( litsym <> NULL ) then
				return hStrLiteralCompare( op, l, r )
			end if

			'' convert to: strcmp(l,r) op 0
			l = rtlStrCompare( l, ldtype, r, rdtype )
			r = astNewCONSTi( 0 )

			ldtype = typeJoin( ldtype, astGetFullType( l ) )
			ldclass = FB_DATACLASS_INTEGER
			rdtype = typeJoin( rdtype, astGetFullType( r ) )
			rdclass = FB_DATACLASS_INTEGER

		'' no other operation allowed
		case else
			exit function
		end select

    '' zstrings?
    elseif( (typeGet( ldtype ) = FB_DATATYPE_CHAR) or _
    	    (typeGet( rdtype ) = FB_DATATYPE_CHAR) ) then

   		'' one is not a string (not fixed, var-len, z- or w-string,
   		'' or the tests above would catch them)
		if( typeGet( ldtype ) = FB_DATATYPE_CHAR ) then
			'' don't allow, unless it's a deref pointer
			if( l->class <> AST_NODECLASS_DEREF ) then
				exit function
			end if
			'' remap the type or the optimizer can
			'' make a wrong assumption
			ldtype = typeJoin( ldtype, FB_DATATYPE_UBYTE )

		else
			'' same as above..
			if( r->class <> AST_NODECLASS_DEREF ) then
				exit function
			end if
			rdtype = typeJoin( rdtype, FB_DATATYPE_UBYTE )
		end if

    end if

    ''::::::

	'' convert byte to int
	if( typeGetSize( ldtype ) = 1 ) then
		if( is_str = FALSE ) then
			if( typeIsSigned( ldtype ) ) then
				ldtype = typeJoin( ldtype, FB_DATATYPE_INTEGER )
			else
				ldtype = typeJoin( ldtype, FB_DATATYPE_UINT )
			end if
			l = astNewCONV( ldtype, NULL, l )
		end if
	end if

	if( typeGetSize( rdtype ) = 1 ) then
		if( is_str = FALSE ) then
			if( typeIsSigned( rdtype ) ) then
				rdtype = typeJoin( rdtype, FB_DATATYPE_INTEGER )
			else
				rdtype = typeJoin( rdtype, FB_DATATYPE_UINT )
			end if
			r = astNewCONV( rdtype, NULL, r )
		end if
	end if

    '' convert types
	select case as const op
	'' flt div (/) can only operate on floats
	case AST_OP_DIV

		if( ldclass <> FB_DATACLASS_FPOINT ) then
			ldtype = typeJoin( ldtype, FB_DATATYPE_DOUBLE )
			l = astNewCONV( ldtype, NULL, l )
			ldclass = FB_DATACLASS_FPOINT
		end if

		if( rdclass <> FB_DATACLASS_FPOINT ) then
			rdtype = typeJoin( rdtype, FB_DATATYPE_DOUBLE )

			if( irGetOption( IR_OPT_FPUCONV ) ) then
				r = astNewCONV( rdtype, NULL, r )
			else
				'' if it's an int var, let the FPU do it
				if( (r->class <> AST_NODECLASS_VAR) or (rdtype <> FB_DATATYPE_INTEGER) ) then
					r = astNewCONV( rdtype, NULL, r )
				end if
			end if

			rdclass = FB_DATACLASS_FPOINT
		end if

	'' bitwise ops, int div (\), modulus and shift can only operate on integers
	case AST_OP_AND, AST_OP_OR, AST_OP_XOR, AST_OP_EQV, AST_OP_IMP, _
		 AST_OP_INTDIV, AST_OP_MOD, AST_OP_SHL, AST_OP_SHR

		if( ldclass <> FB_DATACLASS_INTEGER ) then
			ldtype = typeJoin( ldtype, FB_DATATYPE_INTEGER )
			l = astNewCONV( ldtype, NULL, l )
			ldclass = FB_DATACLASS_INTEGER
		end if

		if( rdclass <> FB_DATACLASS_INTEGER ) then
			rdtype = typeJoin( rdtype, FB_DATATYPE_INTEGER )
			r = astNewCONV( rdtype, NULL, r )
			rdclass = FB_DATACLASS_INTEGER
		end if

	'' atan2 can only operate on floats
	case AST_OP_ATAN2, AST_OP_POW

		if( ldclass <> FB_DATACLASS_FPOINT ) then
			ldtype = typeJoin( ldtype, FB_DATATYPE_DOUBLE )
			l = astNewCONV( ldtype, NULL, l )
			ldclass = FB_DATACLASS_FPOINT
		end if

		if( rdclass <> FB_DATACLASS_FPOINT ) then
			rdtype = typeJoin( rdtype, FB_DATATYPE_DOUBLE )
			r = astNewCONV( rdtype, NULL, r )
			rdclass = FB_DATACLASS_FPOINT
		end if

	end select

    ''::::::

    '' convert types to the most precise if needed
	if( ldtype <> rdtype ) then

		dtype = typeMax( ldtype, rdtype )

		'' don't convert?
		if( dtype = FB_DATATYPE_INVALID ) then

			'' as types are different, if class is fp,
			'' the result type will be always a double
			if( ldclass = FB_DATACLASS_FPOINT ) then

				if( irGetOption( IR_OPT_FPUCONV ) ) then
					dtype   = ldtype
					subtype = l->subtype
				else
					dtype   = typeJoin( dtype, FB_DATATYPE_DOUBLE )
					subtype = NULL
				end if
			else

				'' an ENUM or POINTER always has the precedence
				if( (rdtype = FB_DATATYPE_ENUM) or typeIsPtr( rdtype ) ) then
					dtype = rdtype
					subtype = r->subtype
				else
					dtype = ldtype
					subtype = l->subtype
				end if

			end if

		else
			'' convert the l operand?
			if( typeGetDtAndPtrOnly( dtype ) <> typeGetDtAndPtrOnly( ldtype ) ) then
				subtype = r->subtype
				l = astNewCONV( dtype, subtype, l )
				if( l = NULL ) then exit function

				ldtype = dtype
				ldclass = rdclass

			'' convert the r operand..
			else
				subtype = l->subtype

				'' if it's the src-operand of a shift operation, do nothing
				select case op
				case AST_OP_SHL, AST_OP_SHR
					'' it's already an integer

				case else
					r = astNewCONV( dtype, subtype, r )
					if( r = NULL ) then exit function

					rdtype = dtype
					rdclass = ldclass
				end select

			end if
		end if

	'' no conversion, same types
	else
		dtype   = ldtype
		subtype = l->subtype
	end if

	'' post check
	select case as const op
	'' relative ops, the result is always an integer
	case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_LE, AST_OP_GE
		dtype = FB_DATATYPE_INTEGER
		subtype = NULL
	'' ANDALSO and ORELSE always return an integer
	case AST_OP_ANDALSO, AST_OP_ORELSE
		dtype = FB_DATATYPE_INTEGER
		subtype = NULL
	'' right-operand must be an integer, so pow2 opts can be done on longint's
	case AST_OP_SHL, AST_OP_SHR

		if( astIsCONST( r ) ) then
			'' warn if shift is greater than or equal to the number of bits in ldtype
			'' !!!FIXME!!! prevent asm error when value is higher than 255
			select case astGetValueAsLongInt( r )
			case 0 to (typeGetSize( ldtype ) * 8)-1

			case else
				errReportWarn( FB_WARNINGMSG_SHIFTEXCEEDSBITSINDATATYPE )
			end select
		end if

		if( typeGet( rdtype ) <> FB_DATATYPE_INTEGER ) then
			if( typeGet( rdtype ) <> FB_DATATYPE_UINT ) then
				rdtype = typeJoin( rdtype, FB_DATATYPE_INTEGER )
				r = astNewCONV( rdtype, NULL, r )
				rdclass = FB_DATACLASS_INTEGER
			end if
		end if
	end select

	''::::::

	'' constant folding (won't handle commutation, ie: "1+a+2+3" will become "1+a+5", not "a+6")
	if( astIsCONST( l ) and astIsCONST( r ) ) then

		select case as const typeGet( ldtype )
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    hBOPConstFold64( op, l, r )

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			hBOPConstFoldFlt( op, l, r )

		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
			if( FB_LONGSIZE = len( integer ) ) then
				l = hBOPConstFoldInt( op, l, r )
			else
				hBOPConstFold64( op, l, r )
			end if

		case else
			'' byte's, short's, int's and enum's
			l = hBOPConstFoldInt( op, l, r )
		end select

		astGetFullType( l ) = dtype
		l->subtype = subtype

		astDelNode( r )

		return l

#if 0 '' this optimization causes bug #2099245
	elseif( astIsCONST( l ) ) then
		select case op
		case AST_OP_ADD, AST_OP_MUL
			'' ? + c = c + ?  |  ? * c = ? * c
			astSwap( r, l )

		case AST_OP_SUB
			'' c - ? = -? + c (this will removed later if no const folding can be done)
			r = astNewUOP( AST_OP_NEG, r )
			if( r = NULL ) then
				return NULL
			end if
			astSwap( r, l )
			op = AST_OP_ADD
		end select
#endif

	elseif( astIsCONST( r ) ) then
		select case op
		case AST_OP_ADD
			'' offset?
			if( l->class = AST_NODECLASS_OFFSET ) then
				'' no need to check for other values, floats aren't
				'' allowed and if longints were used, this wouldn't be
				'' an ofs node
				l->ofs.ofs += r->con.val.int
				astDelNode( r )

				return l
			end if

		case AST_OP_SUB
			'' offset?
			if( l->class = AST_NODECLASS_OFFSET ) then
				'' see above
				l->ofs.ofs -= r->con.val.int
				astDelNode( r )

				return l
			end if

			'' ? - c = ? + -c
			select case as const typeGet( rdtype )
			case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
				r->con.val.long = -r->con.val.long

			case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
				r->con.val.float = -r->con.val.float

			case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
				if( FB_LONGSIZE = len( integer ) ) then
					r->con.val.int = -r->con.val.int
				else
					r->con.val.long = -r->con.val.long
				end if

			case else
				r->con.val.int = -r->con.val.int

			end select
			op = AST_OP_ADD

		'' report error for 'x \ 0', 'x mod 0'
		'' Note: no error for 'x / 0', that should just return INF
		case AST_OP_INTDIV, AST_OP_MOD
			if( r->con.val.int = 0 ) then
				errReport( FB_ERRMSG_DIVBYZERO )
			end if

		case AST_OP_POW

			'' convert var ^ 2 to var * var
			if( r->con.val.float = 2.0 ) then

				'' operands will be converted to DOUBLE if not floats..
				if( l->class = AST_NODECLASS_CONV ) then
					select case l->l->class
					case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
						 AST_NODECLASS_FIELD, AST_NODECLASS_DEREF
						n = l
						l = l->l
						astDelNode( n )
						ldtype = typeJoin( ldtype, astGetFullType( l ) )
					end select
				end if

				select case l->class
				case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
					 AST_NODECLASS_FIELD, AST_NODECLASS_DEREF

					'' can't clone if there's a side-effect in the tree
					if( astIsClassOnTree( AST_NODECLASS_CALL, l ) = NULL ) then
						' A pow should always promote l and r to
						' float, and return a float
						if( typeGetClass( astGetDataType( l ) ) <> FB_DATACLASS_FPOINT ) then
							l = astNewCONV( FB_DATATYPE_DOUBLE, NULL, l )
						end if
						astDelNode( r )
						r = astCloneTree( l )
						op = AST_OP_MUL
					end if
				end select
			end if
		end select
	end if

	''::::::
	'' handle special cases

	select case as const op
	case AST_OP_POW
	    return rtlMathPow( l, r )

	case AST_OP_ATAN2
	    if( irGetOption( IR_OPT_NOINLINEOPS ) ) then
	    	return rtlMathBop( op, l, r )
	    end if

	case AST_OP_INTDIV
		'' longint?
		select case typeGet( dtype )
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			return rtlMathLongintDIV( dtype, l, ldtype, r, rdtype )
		end select

	case AST_OP_MOD
		'' longint?
		select case typeGet( dtype )
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			return rtlMathLongintMOD( dtype, l, ldtype, r, rdtype )
		end select

	' Trap ANDALSO, ORELSE, handle floats, and convert to IIF
	case AST_OP_ANDALSO, AST_OP_ORELSE
		dim cmp_op as integer
		dim cmp_constl as ASTNODE ptr
		dim cmp_constr as ASTNODE ptr

		'' For ANDALSO/ORELSE, "ex" is the dtorlist cookie

		if ldclass = FB_DATACLASS_FPOINT then
			cmp_constl = astNewConstf(0.0, FB_DATATYPE_SINGLE)
			cmp_constr = astNewConstf(0.0, FB_DATATYPE_SINGLE)
		else
			cmp_constl = astNewCONSTi( 0 )
			cmp_constr = astNewCONSTi( 0 )
		end if

		if op = AST_OP_ANDALSO then
			cmp_op = AST_OP_NE
		else
			cmp_op = AST_OP_EQ
		end if

		l = astNewBOP( cmp_op, l, cmp_constl )
		r = astNewBOP( AST_OP_NE, r, cmp_constr )

		if op = AST_OP_ANDALSO then
			return astNewIIF( l, r, cint( ex ), astNewCONSTi( 0 ), 0 )
		else
			return astNewIIF( l, r, cint( ex ), astNewCONSTi( -1 ), 0 )
		end if
	end select

	'' alloc new node
	n = astNewNode( AST_NODECLASS_BOP, dtype, subtype )

	'' fill it
	n->l = l
	n->r = r
	n->op.ex = ex
	n->op.op = op

	'' always alloc the result VR for the C backend
	if( env.clopt.backend = FB_BACKEND_GCC ) then
		options or= AST_OPOPT_ALLOCRES
	end if

	n->op.options = options

	function = n

end function

'':::::
#macro hDoSelfOpOverload _
	( _
		op, l, r _
	)

	scope
		dim as FBSYMBOL ptr proc = any
		dim as FB_ERRMSG err_num = any

		proc = symbFindSelfBopOvlProc( op, l, r, @err_num )
		if( proc <> NULL ) then
			'' build a proc call
			function = astBuildCall( proc, l, r )
			exit function
		else
			if( err_num <> FB_ERRMSG_OK ) then
				return NULL
			end if
		end if
	end scope

#endmacro

'':::::
function astNewSelfBOP _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ex as FBSYMBOL ptr, _
		byval options as AST_OPOPT _
	) as ASTNODE ptr

	function = NULL

	'' check op overloading
	hDoSelfOpOverload( op, l, r )

	'' get the not-to-self version
	op = astGetOpSelfVer( op )

	'' if there's a function call in lvalue, convert to tmp = @lvalue, *tmp = *tmp op rhs:
	if( astIsClassOnTree( AST_NODECLASS_CALL, l ) ) then
		dim as FBSYMBOL ptr tmp = any
		dim as ASTNODE ptr ll = any, lr = any

		tmp = symbAddTempVar( typeAddrOf( astGetFullType( l ) ), astGetSubType( l ) )

		'' tmp = @lvalue
		ll = astNewASSIGN( astNewVAR( tmp ), astNewADDROF( l ) )
		if( ll = NULL ) then
			exit function
		end if

		'' *tmp = *tmp op expr
		lr = astNewASSIGN( _
			astNewDEREF( astNewVAR( tmp ) ), _
			astNewBOP( op, _
				astNewDEREF( astNewVAR( tmp ) ), _
				r, ex, options or AST_OPOPT_ALLOCRES ) )

		if( lr = NULL ) then
			exit function
		end if

		function = astNewLink( ll, lr )

	'' no side-effects, convert it to lvalue = lvalue op rhs and let it be optimized later
	else
		r = astNewBOP( op, astCloneTree( l ), r, ex, options or AST_OPOPT_ALLOCRES )

 		if( r = NULL ) then
 			exit function
 		end if

 		'' do the assignment
		function = astNewASSIGN( l, r )
	end if

end function

'':::::
function astLoadBOP _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any, r = any
    dim as integer op = any
    dim as IRVREG ptr v1 = any, v2 = any, vr = any

	op = n->op.op
	l  = n->l
	r  = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	if( l->class = AST_NODECLASS_CONV ) then
		astUpdateCONVFD2FS( l, n->dtype, TRUE )
	end if
	if( r->class = AST_NODECLASS_CONV ) then
		astUpdateCONVFD2FS( r, n->dtype, TRUE )
	end if

	'' need some other algo here to select which operand is better to evaluate
	'' first - pay attention to logical ops, "func1(bar) OR func1(foo)" isn't
	'' the same as the inverse if func1 depends on the order..
	v1 = astLoad( l )
	v2 = astLoad( r )

	if( ast.doemit ) then
		'' result type can be different, with boolean operations on floats
		if( (n->op.options and AST_OPOPT_ALLOCRES) <> 0 ) then
			vr = irAllocVREG( astGetDataType( n ), n->subtype )
			vr->vector = n->vector
		else
			vr = NULL
			v1->vector = n->vector
		end if

		'' execute the operation
		if( n->op.ex <> NULL ) then
			'' hack! ex=label, vr being NULL 'll gen better code at IR..
			irEmitBOP( op, v1, v2, NULL, n->op.ex )
		else
			irEmitBOP( op, v1, v2, vr, NULL )
		end if

		'' "var op= expr" optimizations
		if( vr = NULL ) then
			vr = v1
		end if
	end if

	'' nodes not needed anymore
	astDelNode( l )
	astDelNode( r )

	function = vr

end function

