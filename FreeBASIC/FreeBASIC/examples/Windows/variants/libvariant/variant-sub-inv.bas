

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( -, VarSub, integer, I4 )
VAR_GEN_BOP_INV( -, VarSub, uinteger, UI4 )
VAR_GEN_BOP_INV( -, VarSub, longint, I8 )
VAR_GEN_BOP_INV( -, VarSub, ulongint, UI8 )
VAR_GEN_BOP_INV( -, VarSub, single, R4 )
VAR_GEN_BOP_INV( -, VarSub, double, R8 )

'':::::
operator - _
	( _
		byref lhs as VARIANT_, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarSub( @lhs, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

