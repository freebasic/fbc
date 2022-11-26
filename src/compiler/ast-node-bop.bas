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

	'' !!!FIXME!!! - embedded NUL CHARs incorrectly end the string
	'' !!!TODO!!! - use textlen returned from hUnescape() to get proper comparison length

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

	'' !!!FIXME!!! - embedded NUL CHARs incorrectly end the string
	'' !!!TODO!!! - use textlen returned from hUnescape[W]() to get proper comparison length

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

private function hConstBop _
	( _
		byval op as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

	if( typeGetClass( l->dtype ) = FB_DATACLASS_FPOINT ) then
		'' Float BOP
		select case as const( op )
		case AST_OP_ADD : l->val.f = l->val.f +  r->val.f
		case AST_OP_SUB : l->val.f = l->val.f -  r->val.f
		case AST_OP_MUL : l->val.f = l->val.f *  r->val.f
		'' Note: no division by zero error here - we should return
		'' INF instead, just like with (l / r) at runtime
		case AST_OP_DIV : l->val.f = l->val.f /  r->val.f
		case AST_OP_POW : l->val.f = l->val.f ^  r->val.f
		case AST_OP_NE  : l->val.i = l->val.f <> r->val.f
		case AST_OP_EQ  : l->val.i = l->val.f =  r->val.f
		case AST_OP_GT  : l->val.i = l->val.f >  r->val.f
		case AST_OP_LT  : l->val.i = l->val.f <  r->val.f
		case AST_OP_LE  : l->val.i = l->val.f <= r->val.f
		case AST_OP_GE  : l->val.i = l->val.f >= r->val.f
		case AST_OP_ATAN2 : l->val.f = atan2( l->val.f, r->val.f )
		case AST_OP_ANDALSO
			if( l->val.f ) then
				l->val.i = (r->val.f <> 0)
			else
				l->val.i = 0
			end if
		case AST_OP_ORELSE
			if( l->val.f ) then
				l->val.i = -1
			else
				l->val.i = (r->val.f <> 0)
			end if
		case else
			assert( FALSE )
		end select

	elseif ( ( typeGetDtAndPtrOnly( l->dtype ) = FB_DATATYPE_BOOLEAN ) or _
		    ( typeGetDtAndPtrOnly( r->dtype ) = FB_DATATYPE_BOOLEAN ) ) then
		'' boolean BOP
		select case as const( op )
		case AST_OP_AND : l->val.i = cbool( l->val.i ) and cbool( r->val.i )
		case AST_OP_OR  : l->val.i = cbool( l->val.i ) or  cbool( r->val.i )
		case AST_OP_XOR : l->val.i = cbool( l->val.i ) xor cbool( r->val.i )
		case AST_OP_EQV : l->val.i = cbool( l->val.i ) eqv cbool( r->val.i )
		case AST_OP_IMP : l->val.i = cbool( l->val.i ) imp cbool( r->val.i )
		case AST_OP_NE  : l->val.i = cbool( l->val.i ) <>  cbool( r->val.i )
		case AST_OP_EQ  : l->val.i = cbool( l->val.i ) =   cbool( r->val.i )
		case AST_OP_ANDALSO : l->val.i = cbool( l->val.i ) andalso cbool( r->val.i )
		case AST_OP_ORELSE  : l->val.i = cbool( l->val.i ) orelse  cbool( r->val.i )
		case else
			assert( FALSE )
		end select

	elseif( typeIsSigned( l->dtype ) ) then
		'' Signed integer BOP
		select case as const( op )
		case AST_OP_ADD : l->val.i = l->val.i +   r->val.i
		case AST_OP_SUB : l->val.i = l->val.i -   r->val.i
		case AST_OP_MUL : l->val.i = l->val.i *   r->val.i
		case AST_OP_SHL : l->val.i = l->val.i shl r->val.i : assert( cunsg( r->val.i ) < typeGetBits( l->dtype ) )
		case AST_OP_SHR : l->val.i = l->val.i shr r->val.i : assert( cunsg( r->val.i ) < typeGetBits( l->dtype ) )
		case AST_OP_AND : l->val.i = l->val.i and r->val.i
		case AST_OP_OR  : l->val.i = l->val.i or  r->val.i
		case AST_OP_XOR : l->val.i = l->val.i xor r->val.i
		case AST_OP_EQV : l->val.i = l->val.i eqv r->val.i
		case AST_OP_IMP : l->val.i = l->val.i imp r->val.i
		case AST_OP_NE  : l->val.i = l->val.i <>  r->val.i
		case AST_OP_EQ  : l->val.i = l->val.i =   r->val.i
		case AST_OP_GT  : l->val.i = l->val.i >   r->val.i
		case AST_OP_LT  : l->val.i = l->val.i <   r->val.i
		case AST_OP_LE  : l->val.i = l->val.i <=  r->val.i
		case AST_OP_GE  : l->val.i = l->val.i >=  r->val.i
		case AST_OP_ANDALSO : l->val.i = iif( l->val.i <> 0, r->val.i <> 0, 0 )
		case AST_OP_ORELSE  : l->val.i = iif( l->val.i <> 0, -1, r->val.i <> 0 )
		case AST_OP_INTDIV, AST_OP_MOD
			'' Division by zero?
			if( r->val.i = 0 ) then
				l->val.i = 0
				errReport( FB_ERRMSG_DIVBYZERO )

			'' Avoid incorrect result (x86) or SIGFPE crash (x86_64) for:
			'' -9223372036854775808 \ -1 = 9223372036854775808,
			'' which cannot be represented in a 64bit signed integer,
			'' and, in theory, overflows to 0. Also affects MOD.
			''
			'' Also, avoid SIGFPE crash (x86, if the const folding
			'' arithmetic wasn't implemented using LongInts) for:
			'' -2147483648 \ -1 = 2147483648,
			'' which cannot be represented in a 32bit signed integer,
			'' ditto.
			elseif( (r->val.i = -1) and _
			        (((typeGetSize( l->dtype ) = 8) and (l->val.i = -9223372036854775808ull)) or _
			         ((typeGetSize( l->dtype ) = 4) and (l->val.i = -2147483648u))) ) then
				l->val.i = 0
				if( astShouldShowWarnings( ) ) then
					errReportWarn( FB_WARNINGMSG_CONVOVERFLOW )
				end if

			elseif( op = AST_OP_INTDIV ) then
				l->val.i = l->val.i \   r->val.i
			else
				l->val.i = l->val.i mod r->val.i
			end if
		case else
			assert( FALSE )
		end select

		l = astConvertRawCONSTi( dtype, subtype, l )

	else
		'' Unsigned integer BOP
		select case as const( op )
		case AST_OP_ADD : l->val.i = cunsg( l->val.i ) +   cunsg( r->val.i )
		case AST_OP_SUB : l->val.i = cunsg( l->val.i ) -   cunsg( r->val.i )
		case AST_OP_MUL : l->val.i = cunsg( l->val.i ) *   cunsg( r->val.i )
		case AST_OP_SHL : l->val.i = cunsg( l->val.i ) shl cunsg( r->val.i ) : assert( cunsg( r->val.i ) < typeGetBits( l->dtype ) )
		case AST_OP_SHR : l->val.i = cunsg( l->val.i ) shr cunsg( r->val.i ) : assert( cunsg( r->val.i ) < typeGetBits( l->dtype ) )
		case AST_OP_AND : l->val.i = cunsg( l->val.i ) and cunsg( r->val.i )
		case AST_OP_OR  : l->val.i = cunsg( l->val.i ) or  cunsg( r->val.i )
		case AST_OP_XOR : l->val.i = cunsg( l->val.i ) xor cunsg( r->val.i )
		case AST_OP_EQV : l->val.i = cunsg( l->val.i ) eqv cunsg( r->val.i )
		case AST_OP_IMP : l->val.i = cunsg( l->val.i ) imp cunsg( r->val.i )
		case AST_OP_NE  : l->val.i = cunsg( l->val.i ) <>  cunsg( r->val.i )
		case AST_OP_EQ  : l->val.i = cunsg( l->val.i ) =   cunsg( r->val.i )
		case AST_OP_GT  : l->val.i = cunsg( l->val.i ) >   cunsg( r->val.i )
		case AST_OP_LT  : l->val.i = cunsg( l->val.i ) <   cunsg( r->val.i )
		case AST_OP_LE  : l->val.i = cunsg( l->val.i ) <=  cunsg( r->val.i )
		case AST_OP_GE  : l->val.i = cunsg( l->val.i ) >=  cunsg( r->val.i )
		case AST_OP_ANDALSO : l->val.i = iif( l->val.i <> 0, r->val.i <> 0, 0 )
		case AST_OP_ORELSE  : l->val.i = iif( l->val.i <> 0, -1, r->val.i <> 0 )
		case AST_OP_INTDIV, AST_OP_MOD
			'' Division by zero?
			if( r->val.i = 0 ) then
				l->val.i = 0
				errReport( FB_ERRMSG_DIVBYZERO )
			elseif( op = AST_OP_INTDIV ) then
				l->val.i = cunsg( l->val.i ) \   cunsg( r->val.i )
			else
				l->val.i = cunsg( l->val.i ) mod cunsg( r->val.i )
			end if
		case else
			assert( FALSE )
		end select

		l = astConvertRawCONSTi( dtype, subtype, l )
	end if

	function = l
end function

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
		function = not typeIsPtr( dtype )

	'' short-circuit ops?  operands will be checked against zero, so allow.
	case AST_OP_ANDALSO, AST_OP_ORELSE
		function = TRUE

	'' relational op?
	case else
		function = astOpIsRelational( op )
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
	dim as longint lgt = any

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

'' Convert an expression to the given type, preserving CONST bits, and also
'' updating the corresponding helper variables
private sub hConvOperand _
	( _
		byval newdtype as integer, _
		byref dtype as integer, _
		byref dclass as integer, _
		byref n as ASTNODE ptr _
	)

	dtype = typeJoin( dtype, newdtype )
	dclass = typeGetClass( newdtype )
	n = astNewCONV( dtype, NULL, n )

end sub

'' Return FB_DATATYPE_INTEGER, or the given dtype if it's a bigger integer-class dtype
private function hGetIntegerOrBigger( byval dtype as integer ) as integer
	select case( dtype )
	case FB_DATATYPE_UINT, FB_DATATYPE_ULONGINT  '' these are always > integer
		return dtype
	case FB_DATATYPE_LONGINT '' this is only > integer on 32bit
		if( fbIs64bit( ) = FALSE ) then
			return dtype
		end if
	end select
	return FB_DATATYPE_INTEGER
end function

private function hIsConsideredBoolean( byval n as ASTNODE ptr ) as integer
	return (typeGetDtAndPtrOnly( n->dtype ) = FB_DATATYPE_BOOLEAN) orelse _
	       astIsConst0OrMinus1( n ) orelse _
	       astIsRelationalBop( n )
end function

'' Warn about mixed boolean and non-boolean operands, unless
'' 1. the non-boolean can be considered boolean:
''  - integer constants 0 and -1 (classic FALSE/TRUE definitions)
''  - relational BOPs, which don't return booleans yet,
''    but should really be mixable with booleans
'' 2. the boolean is true/false (0 or -1 constants), which should also be
''    mixable with integers for better backwards compatibility.
private function hShouldWarnAboutMixedBool( byval l as ASTNODE ptr, byval r as ASTNODE ptr ) as integer
	if( (typeGetDtAndPtrOnly( l->dtype ) =  FB_DATATYPE_BOOLEAN) and _
	    (typeGetDtAndPtrOnly( r->dtype ) <> FB_DATATYPE_BOOLEAN) ) then
		return (not astIsConst0OrMinus1( l )) andalso (not hIsConsideredBoolean( r ))
	end if
	if( (typeGetDtAndPtrOnly( l->dtype ) <> FB_DATATYPE_BOOLEAN) and _
	    (typeGetDtAndPtrOnly( r->dtype ) =  FB_DATATYPE_BOOLEAN) ) then
		return (not hIsConsideredBoolean( l )) andalso (not astIsConst0OrMinus1( r ))
	end if
	return FALSE
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
	dim as integer ldtype0 = any, rdtype0 = any
	dim as integer ldtype = any, rdtype = any, dtype = any
	dim as integer ldclass = any, rdclass = any
	dim as integer lrank = any, rrank = any, intrank = any, uintrank = any
	dim as integer is_str = any
	dim as FBSYMBOL ptr litsym = any, subtype = any
	dim as integer do_promote = any

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

	do_promote = TRUE

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

	''
	'' Enum operands? Convert them to integer (but preserve CONSTs).
	''
	'' When doing math BOPs on enum constants, we don't even know whether
	'' the resulting integer value will be a part of that enum.
	'' For typesafe enums, an error would have to be shown here.
	''
	'' Similar for relational BOPs, it's better to compare enums as
	'' integers, especially if the two operands are from different enums.
	'' (also, the result of relational BOPs is an integer anyways...)
	''
	if( typeGet( ldtype ) = FB_DATATYPE_ENUM ) then
		hConvOperand( FB_DATATYPE_INTEGER, ldtype, ldclass, l )
	end if
	if( typeGet( rdtype ) = FB_DATATYPE_ENUM ) then
		hConvOperand( FB_DATATYPE_INTEGER, rdtype, rdclass, r )
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

			'' concatenation?
			if( op = AST_OP_ADD ) then
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
			elseif( astOpIsRelational( op ) ) then
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
			else
				exit function
			end if

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
	elseif( (ldclass = FB_DATACLASS_STRING) or _
	        (rdclass = FB_DATACLASS_STRING) ) then

		'' not both strings?
		if( ldclass <> rdclass ) then
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

		'' concatenation?
		if( op = AST_OP_ADD ) then
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
		elseif( astOpIsRelational( op ) ) then
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
		else
			exit function
		end if

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

	dim as integer is_boolean = FALSE

	'' Any boolean operand(s)?
	if( (typeGetDtAndPtrOnly( ldtype ) = FB_DATATYPE_BOOLEAN) or _
	    (typeGetDtAndPtrOnly( rdtype ) = FB_DATATYPE_BOOLEAN) ) then
		'' Logic BOP which could be pure boolean?
		select case as const op
		case AST_OP_AND, AST_OP_OR, AST_OP_XOR, AST_OP_EQV, AST_OP_IMP, _
		     AST_OP_EQ, AST_OP_NE, AST_OP_ANDALSO, AST_OP_ORELSE
			'' Pure boolean BOPs return booleans and use the boolean operands
			'' as-is (no promotion/conversion to integers).
			'' However, with mixed boolean and non-boolean operands, the boolean
			'' is converted to integer. Then we do the usual promotions for both
			'' operands. This should give good backwards compatibility and
			'' well-defined behaviour when mixing like that.
			is_boolean = (typeGetDtAndPtrOnly( ldtype ) = typeGetDtAndPtrOnly( rdtype ))

		case else
			'' No other BOP's allowed with booleans
			exit function
		end select

		if( hShouldWarnAboutMixedBool( l, r ) ) then
			errReportWarn( FB_WARNINGMSG_OPERANDSMIXEDTYPES )
		end if
	end if

	''::::::

	''
	'' Promote smaller integer types to [U]INTEGER before the operation
	''
	'' - but not if it's -lang qb, because 16bit arithmetic should probably
	''   not become 32bit there. It could matter for code like:
	''        #lang "qb"
	''        dim a as integer  '' 16-bit "integer" (SHORT internally)
	''        dim b as integer
	''        dim x as long
	''        x = a + b
	''   where the result of the 16bit BOP is assigned to a 32bit value.
	''
	'' - do nothing if this BOP is a string concatenation/comparison
	'' - also, do nothing for float/UDT operands
	'' - also, do nothing if both operands are boolean for some BOPs
	''
	'' - Pointers and bitfields should be treated as UINTEGER (their
	''   "remap" types), i.e. they will effectively never be promoted.
	''
	''   Pointers can only appear in BOPs as part of pointer indexing,
	''   which is a special case. The result type should always be the
	''   pointer type, so it mustn't be converted here.
	''
	''   Bitfields must be treated as their remap type, since the BOP result
	''   can't have bitfield type itself... (similar to enums)
	''
	'' - Enums would also be handled via their remap type here, but for now
	''   any enum operand is already converted to integer above anyways,
	''   so enums never arrive here.
	''

	ldtype0 = ldtype
	rdtype0 = rdtype

	do_promote = (env.clopt.lang <> FB_LANG_QB) and (not is_str) and (not is_boolean)

	if( do_promote ) then

		intrank = typeGetIntRank( FB_DATATYPE_INTEGER )
		uintrank = typeGetIntRank( FB_DATATYPE_UINT )

		'' not for float
		if( ldclass = FB_DATACLASS_INTEGER ) then
			lrank = typeGetIntRank( typeGetRemapType( ldtype ) )

			'' l < INTEGER?
			if( lrank < intrank ) then
				hConvOperand( FB_DATATYPE_INTEGER, ldtype, ldclass, l )
			else
				'' INTEGER < l < UINTEGER?
				if( (intrank < lrank) and (lrank < uintrank) ) then
					'' Convert to UINTEGER for consistency with
					'' the above conversion to INTEGER (this can
					'' happen with ULONG on 32bit, and ULONGINT
					'' on 64bit, due to the ranking order)
					hConvOperand( FB_DATATYPE_UINT, ldtype, ldclass, l )
				end if
			end if
		end if

		'' not for float
		if( rdclass = FB_DATACLASS_INTEGER ) then
			rrank = typeGetIntRank( typeGetRemapType( rdtype ) )

			'' same for r
			if( rrank < intrank ) then
				hConvOperand( FB_DATATYPE_INTEGER, rdtype, rdclass, r )
			else
				if( (intrank < rrank) and (rrank < uintrank) ) then
					hConvOperand( FB_DATATYPE_UINT, rdtype, rdclass, r )
				end if
			end if
		end if
	end if

	'' convert types
	select case as const op
	'' flt div (/) can only operate on floats
	case AST_OP_DIV

		if( ldclass <> FB_DATACLASS_FPOINT ) then
			hConvOperand( FB_DATATYPE_DOUBLE, ldtype, ldclass, l )
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

		'' Examples:
		''     double xor double =>  integer xor integer
		''    integer xor double =>  integer xor integer
		''    longint xor double =>  longint xor longint
		''   ulongint xor double => ulongint xor longint
		'' etc.

		if( ldclass <> FB_DATACLASS_INTEGER ) then
			hConvOperand( hGetIntegerOrBigger( rdtype ), ldtype, ldclass, l )
		end if

		if( rdclass <> FB_DATACLASS_INTEGER ) then
			hConvOperand( hGetIntegerOrBigger( ldtype ), rdtype, rdclass, r )
		end if

	'' atan2 can only operate on floats
	case AST_OP_ATAN2, AST_OP_POW

		if( ldclass <> FB_DATACLASS_FPOINT ) then
			hConvOperand( FB_DATATYPE_DOUBLE, ldtype, ldclass, l )
		end if

		if( rdclass <> FB_DATACLASS_FPOINT ) then
			hConvOperand( FB_DATATYPE_DOUBLE, rdtype, rdclass, r )
		end if

	end select

	''::::::

	if( (ldtype <> rdtype) or (l->subtype <> r->subtype) ) then
		'' Pointer arithmetic (but not handled above by hDoPointerArith())?
		'' (assuming hCheckPointers() checks were already done)
		if( (typeIsPtr( ldtype ) or typeIsPtr( rdtype )) and _
		    ((op = AST_OP_ADD) or (op = AST_OP_SUB)) ) then
			'' The result is supposed to be the pointer type
			if( typeIsPtr( ldtype ) ) then
				dtype   = ldtype
				subtype = l->subtype
			else
				dtype   = rdtype
				subtype = r->subtype
			end if
		else
			'' Convert lhs/rhs to most precise type
			'' (e.g. for +/-/* math BOPs, but also for relational BOPs,
			'' even if they involve pointers)
			typeMax( ldtype, l->subtype, rdtype, r->subtype, dtype, subtype )

			if( (typeGetDtAndPtrOnly( dtype ) <> typeGetDtAndPtrOnly( ldtype )) or _
			    (subtype <> l->subtype) ) then
				l = astNewCONV( dtype, subtype, l )
				if( l = NULL ) then exit function
				ldtype = dtype
				ldclass = typeGetClass( dtype )
			end if

			if( (typeGetDtAndPtrOnly( dtype ) <> typeGetDtAndPtrOnly( rdtype )) or _
			    (subtype <> r->subtype) ) then
				'' if it's the src-operand of a shift operation, do nothing
				select case op
				case AST_OP_SHL, AST_OP_SHR
					'' it's already an integer

				case else
					r = astNewCONV( dtype, subtype, r )
					if( r = NULL ) then exit function

					rdtype = dtype
					rdclass = typeGetClass( dtype )
				end select
			end if
		end if
	'' no conversion, same types
	else
		dtype   = ldtype
		subtype = l->subtype
	end if

	'' warn on mixing signed and unsigned ops on comparisons/intdiv/mod/shr (unless signed value was a positive constant)
	select case as const op
	case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_LE, AST_OP_GE, _
	     AST_OP_INTDIV, AST_OP_MOD, AST_OP_SHR

	    dim as FB_WARNINGMSG warning = 0

		'' lhs signed->unsigned?
		if( typeIsSigned( ldtype0 ) ) then
			if( typeIsSigned( ldtype ) = FALSE ) then
				if( astIsConst( l ) ) then
					'' check for negative const lhs
					if( astConstGetAsInt64( l ) < 0 ) then
						'' lhs const int was negative
						warning = FB_WARNINGMSG_OPERANDSMIXEDSIGNEDNESS
					end if
				else
					'' lhs var may have been negative
					'' (only a pedantic warning)
					if( fbPdCheckIsSet( FB_PDCHECK_SIGNEDNESS ) ) then
						warning = FB_WARNINGMSG_OPERANDSMIXEDSIGNEDNESS
					end if
				end if
			end if
		end if

		'' rhs signed->unsigned?  (Except in SHR)
		if( (warning = 0) andalso op <> AST_OP_SHR andalso typeIsSigned( rdtype0 ) ) then
			if( typeIsSigned( rdtype ) = FALSE ) then
				if( astIsConst( r ) ) then
					if( astConstGetAsInt64( r ) < 0 ) then
						'' rhs const int was negative
						warning = FB_WARNINGMSG_OPERANDSMIXEDSIGNEDNESS
					end if
				else
					'' rhs var may have been negative
					'' (only a pedantic warning)
					if( fbPdCheckIsSet( FB_PDCHECK_SIGNEDNESS ) ) then
						warning = FB_WARNINGMSG_OPERANDSMIXEDSIGNEDNESS
					end if
				end if
			end if
		end if

		if( warning <> 0 ) then
			errReportWarn( warning )
		end if

	end select

	'' post check
	select case as const op
	'' relational operations always return an integer
	case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_LE, AST_OP_GE, _
	     AST_OP_ANDALSO, AST_OP_ORELSE

		'' except, if it's boolean
		if( typeGetDtAndPtrOnly( dtype ) <> FB_DATATYPE_BOOLEAN ) then
			dtype = FB_DATATYPE_INTEGER
		end if
		subtype = NULL

	'' right-operand must be an integer, so pow2 opts can be done on longint's
	case AST_OP_SHL, AST_OP_SHR
		if( astIsCONST( r ) ) then
			'' Ensure the shift amount is in the range 0..bitsize-1.
			'' - x86 only supports 0..31 shifts
			'' - GAS will show errors if outside 0..255 (byte operand)
			'' - C backend: anything outside the 0..bitsize-1 range is undefined behaviour
			assert( typeGetClass( r->dtype ) = FB_DATACLASS_INTEGER )
			if( cunsg( r->val.i ) >= typeGetBits( ldtype ) ) then
				errReportWarn( FB_WARNINGMSG_SHIFTEXCEEDSBITSINDATATYPE )
				r = astNewBOP( AST_OP_AND, r, astNewCONSTi( typeGetBits( ldtype )-1 ) )
			end if
		end if

		if( typeGetDtAndPtrOnly( rdtype ) <> FB_DATATYPE_INTEGER ) then
			if( typeGetDtAndPtrOnly( rdtype ) <> FB_DATATYPE_UINT ) then
				rdtype = typeJoin( rdtype, FB_DATATYPE_INTEGER )
				r = astNewCONV( rdtype, NULL, r )
				rdclass = FB_DATACLASS_INTEGER
			end if
		end if
	end select

	'' constant folding (won't handle commutation, ie: "1+a+2+3" will become "1+a+5", not "a+6")
	''
	'' ldtype/rdtype can be different for cases like SHL/SHR or pointer arithmetic,
	'' but for the math, bitwise or relational operators, they will have been
	'' promoted to the same type.
	''
	'' String concatenation/comparison operations won't be affected since
	'' they don't use CONSTs (string literals are VARs). Even "str & int"
	'' BOPs are already converted to "str + fb_IntToStr(int)".

	if( astIsCONST( l ) and astIsCONST( r ) ) then
		l = hConstBop( op, dtype, subtype, l, r )

		astGetFullType( l ) = dtype
		l->subtype = subtype

		astDelNode( r )

		return l
	end if

	'' CONST + x  =>  x + CONST
	'' Moving CONSTs to the rhs (where possible) reduces the amount of code
	'' needed in astOptimizeTree() etc., as from now on only the rhs needs
	'' to be checked for being CONST (otherwise we'd always have to check
	'' both sides).
	if( astIsCONST( l ) ) then
		var do_swap = FALSE

		select case op
		case AST_OP_ADD, AST_OP_MUL, _
		     AST_OP_AND, AST_OP_OR, AST_OP_XOR, AST_OP_EQV, _
		     AST_OP_EQ, AST_OP_NE
			'' ? OP c = c OP ?
			do_swap = TRUE

		case AST_OP_GE
			'' c >= ?  =  ? <= c
			op = AST_OP_LE
			do_swap = TRUE

		case AST_OP_GT
			'' c > ?  =  ? < c
			op = AST_OP_LT
			do_swap = TRUE

		case AST_OP_LE
			'' c <= ?  =  ? >= c
			op = AST_OP_GE
			do_swap = TRUE

		case AST_OP_LT
			'' c < ?  =  ? > c
			op = AST_OP_GT
			do_swap = TRUE

		case AST_OP_SUB
			'' c - ? = -? + c (this will removed later if no const folding can be done)
			astBeginHideWarnings( )
			r = astNewUOP( AST_OP_NEG, r )
			astEndHideWarnings( )
			if( r = NULL ) then
				return NULL
			end if
			op = AST_OP_ADD
			do_swap = TRUE
		end select

		if( do_swap ) then
			swap ldtype, rdtype
			swap ldclass, rdclass
			swap l, r
		end if
	end if

	if( astIsCONST( r ) ) then
		select case op
		case AST_OP_NE
			'' Integer comparison (not a string/float one)?
			if( (ldclass = FB_DATACLASS_INTEGER) and (rdclass = FB_DATACLASS_INTEGER) ) then
				if( r->val.i = 0 ) then
					''
					'' x <> 0  =>  x  if x already is a boolean
					''
					'' but only if x is a relational BOP, for example:
					''   (a <> b) <> 0  =>  a <> b
					''
					'' Generally there are more cases where this optimization could be done, for example:
					''   (not a) <> 0  =>   not a   (at least if the <not a> has Integer type, i.e. boolean)
					'' but then astBuildBranch() could be missing the BOP for doing an optimized conditional branch,
					'' so it's probably better to only optimize if there will still be a BOP.
					''
					if( astIsRelationalBop( l ) ) then
						astDelNode( r )
						return l
					end if
				end if
			end if

		case AST_OP_EQ
			'' Integer comparison (not a string/float one)?
			if( (ldclass = FB_DATACLASS_INTEGER) and (rdclass = FB_DATACLASS_INTEGER) ) then
				if( r->val.i = 0 ) then
					'' Solve out = 0 checks on relational BOPs: = 0 is a logical negation,
					'' and we can solve it out by inverting the relational BOP.
					'' (a <> b) = 0  =>  (a =  b)
					'' (a =  b) = 0  =>  (a <> b)
					'' (a <  b) = 0  =>  (a >= b)
					'' etc.
					if( astIsRelationalBop( l ) ) then
						l->op.op = astGetInverseLogOp( l->op.op )
						astDelNode( r )
						return l
					end if
				end if
			end if

		case AST_OP_ADD
			select case( l->class )
			case AST_NODECLASS_OFFSET
				'' no need to check for other values, floats aren't
				'' allowed and if longints were used, this wouldn't be
				'' an ofs node
				l->ofs.ofs += r->val.i
				astDelNode( r )

				return l

			'' BOP(ADDROF(VAR(x)), CONST(N))  =>  ADDROF(VAR(x, ofs=N))
			case AST_NODECLASS_ADDROF
				if( astIncOffset( l->l, r->val.i ) ) then
					astDelNode( r )
					return l
				end if
			end select

		case AST_OP_SUB
			select case( l->class )
			case AST_NODECLASS_OFFSET
				'' see above
				l->ofs.ofs -= r->val.i
				astDelNode( r )

				return l

			'' BOP(ADDROF(VAR(x)), CONST(N))  =>  ADDROF(VAR(x, ofs=N))
			case AST_NODECLASS_ADDROF
				if( astIncOffset( l->l, -r->val.i ) ) then
					astDelNode( r )
					return l
				end if
			end select

			'' ? - c = ? + -c
			astBeginHideWarnings( )
			r = astNewUOP( AST_OP_NEG, r )
			astEndHideWarnings( )
			op = AST_OP_ADD

		'' report error for 'x \ 0', 'x mod 0'
		'' Note: no error for 'x / 0', that should just return INF
		case AST_OP_INTDIV, AST_OP_MOD
			if( r->val.i = 0 ) then
				errReport( FB_ERRMSG_DIVBYZERO )
			end if

		case AST_OP_POW
			'' convert var ^ 2 to var * var
			if( r->val.f = 2.0 ) then
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
					if( astHasSideFx( l ) = FALSE ) then
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
		'' Call RTL function if backend doesn't support this op directly
		if( irGetOption( IR_OPT_MISSINGOPS ) ) then
			'' (not even checking irSupportsOp() here, because neither
			'' C/LLVM backends support atan2())
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

		assert( (dtype = FB_DATATYPE_BOOLEAN) or (dtype = FB_DATATYPE_INTEGER) )

		if ldclass = FB_DATACLASS_FPOINT then
			cmp_constl = astNewConstf(0.0, FB_DATATYPE_SINGLE)
			cmp_constr = astNewConstf(0.0, FB_DATATYPE_SINGLE)
		else
			cmp_constl = astNewCONSTi( 0, dtype )
			cmp_constr = astNewCONSTi( 0, dtype )
		end if

		if op = AST_OP_ANDALSO then
			cmp_op = AST_OP_NE
		else
			cmp_op = AST_OP_EQ
		end if

		l = astNewBOP( cmp_op, l, cmp_constl )
		r = astNewBOP( AST_OP_NE, r, cmp_constr )

		if op = AST_OP_ANDALSO then
			return astNewIIF( l, r, cint( ex ), astNewCONSTi( 0, dtype ), 0 )
		else
			return astNewIIF( l, r, cint( ex ), astNewCONSTi( -1, dtype ), 0 )
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

function astNewSelfBOP _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval ex as FBSYMBOL ptr, _
		byval options as AST_OPOPT _
	) as ASTNODE ptr

	dim as ASTNODE ptr t = any
	dim as FBSYMBOL ptr proc = any
	dim as FB_ERRMSG err_num = any

	function = NULL

	'' check op overloading
	proc = symbFindSelfBopOvlProc( op, l, r, @err_num )
	if( proc ) then
		'' build a proc call
		return astBuildCall( proc, l, r )
	end if
	if( err_num <> FB_ERRMSG_OK ) then
		return NULL
	end if

	'' Build the self-BOP
	''      l selfbop= r
	'' by doing an assignment:
	''      l = l normalbop r
	'' (will be optimized by astOptAssignment() again later)
	t = NULL

	if( astHasSideFx( l ) ) then
		t = astNewLINK( t, astMakeRef( l ), AST_LINK_RETURN_NONE )
	end if

	'' ... = l normalbop r
	r = astNewBOP( astGetOpSelfVer( op ), astCloneTree( l ), r, ex, options or AST_OPOPT_ALLOCRES )
	'' astNewBOP() may fail if the two operands aren't compatible (depending on the operation).
	if( r = NULL ) then
		astDelTree( t )
		exit function
	end if

	'' l = ...
	l = astNewASSIGN( l, r )
	'' astNewASSIGN() may fail if the operation result isn't compatible with the lhs.
	'' This can happen e.g. with the & string concatenation operator, which can take
	'' integers as both lhs/rhs, but always returns a string, which then can't be
	'' assigned back to an integer lhs.
	if( l = NULL ) then
		astDelTree( t )
		exit function
	end if
	t = astNewLINK( t, l, AST_LINK_RETURN_NONE )

	function = t
end function

function astLoadBOP( byval n as ASTNODE ptr ) as IRVREG ptr
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
		'' ex=label? Then this is an optimized conditional branch
		if( n->op.ex <> NULL ) then
			vr = NULL
			irEmitBOP( op, v1, v2, NULL, n->op.ex )
		else
			if( (n->op.options and AST_OPOPT_ALLOCRES) <> 0 ) then
				'' Self-BOPs: Always re-use the lhs vreg to store the result,
				'' that way no assignment is needed anymore,
				'' at least from the x86 ASM backend's point of view.
				vr = irAllocVREG( astGetDataType( n ), n->subtype )
				vr->vector = n->vector
			else
				'' Normal BOPs: The result must be stored into a newly allocated vreg,
				'' although the ASM backend may end up optimizing it out (hReuse()).
				vr = NULL
				v1->vector = n->vector
			end if

			irEmitBOP( op, v1, v2, vr, NULL )

			'' Return vr to parent even for self-BOPs - this is probably useless at the moment though,
			'' because FB self-BOPs can only be used as statements, not in expressions...
			if( vr = NULL ) then
				vr = v1
			end if
		end if
	end if

	'' nodes not needed anymore
	astDelNode( l )
	astDelNode( r )

	function = vr
end function
