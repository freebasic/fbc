

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
		byref lhs as VARIANT, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarMod( @lhs, @rhs.var, @res )
	
	return CVariant( res, FALSE )
	
end operator

