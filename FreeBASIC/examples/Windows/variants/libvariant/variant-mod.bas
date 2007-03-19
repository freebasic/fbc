

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
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarMod( @lhs.var_, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

'':::::
operator mod _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT_ _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarMod( @lhs.var_, @rhs, @res )
	
	return VARIANT( res, FALSE )
	
end operator

