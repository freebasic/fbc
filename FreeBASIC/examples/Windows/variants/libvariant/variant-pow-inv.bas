

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
		byref lhs as VARIANT, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarPow( @lhs, @rhs.var_, @res )
	
	return CVariant( res, FALSE )
	
end operator

