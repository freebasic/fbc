

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP( *, VarMul, integer, I4 )
VAR_GEN_BOP( *, VarMul, uinteger, UI4 )
VAR_GEN_BOP( *, VarMul, longint, I8 )
VAR_GEN_BOP( *, VarMul, ulongint, UI8 )
VAR_GEN_BOP( *, VarMul, single, R4 )
VAR_GEN_BOP( *, VarMul, double, R8 )

'':::::
operator * _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarMul( @lhs.var_, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

'':::::
operator * _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT_ _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarMul( @lhs.var_, @rhs, @res )
	
	return VARIANT( res, FALSE )
	
end operator

