

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP( mod, VarMod, integer, I4 )
VAR_GEN_BOP( mod, VarMod, uinteger, UI4 )
VAR_GEN_BOP( mod, VarMod, longint, I8 )
VAR_GEN_BOP( mod, VarMod, ulongint, UI8 )
VAR_GEN_BOP( mod, VarMod, single, R4 )
VAR_GEN_BOP( mod, VarMod, double, R8 )

'':::::
operator mod _
	( _
		byref lhs as CVariant, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarMod( @lhs.var, @rhs.var, @res )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator mod _
	( _
		byref lhs as CVariant, _
		byref rhs as VARIANT _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarMod( @lhs.var, @rhs, @res )
	
	return CVariant( res, FALSE )
	
end operator

