

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( mod, VarMod, integer, I4 )
VAR_GEN_BOP_INV( mod, VarMod, uinteger, UI4 )
VAR_GEN_BOP_INV( mod, VarMod, longint, I8 )
VAR_GEN_BOP_INV( mod, VarMod, ulongint, UI8 )
VAR_GEN_BOP_INV( mod, VarMod, single, R4 )
VAR_GEN_BOP_INV( mod, VarMod, double, R8 )

'':::::
operator mod _
	( _
		byref lhs as VARIANT_, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarMod( @lhs, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

