

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP( or, VarOr, integer, I4 )
VAR_GEN_BOP( or, VarOr, uinteger, UI4 )
VAR_GEN_BOP( or, VarOr, longint, I8 )
VAR_GEN_BOP( or, VarOr, ulongint, UI8 )

'':::::
operator or _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarOr( @lhs.var_, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

'':::::
operator or _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT_ _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarOr( @lhs.var_, @rhs, @res )
	
	return VARIANT( res, FALSE )
	
end operator

