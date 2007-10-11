

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( ^, VarPow, integer, I4 )
VAR_GEN_BOP_INV( ^, VarPow, uinteger, UI4 )
VAR_GEN_BOP_INV( ^, VarPow, longint, I8 )
VAR_GEN_BOP_INV( ^, VarPow, ulongint, UI8 )
VAR_GEN_BOP_INV( ^, VarPow, single, R4 )
VAR_GEN_BOP_INV( ^, VarPow, double, R8 )

'':::::
operator ^ _
	( _
		byref lhs as VARIANT_, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarPow( @lhs, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

