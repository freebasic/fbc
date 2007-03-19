

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP( imp, VarImp, integer, I4 )
VAR_GEN_BOP( imp, VarImp, uinteger, UI4 )
VAR_GEN_BOP( imp, VarImp, longint, I8 )
VAR_GEN_BOP( imp, VarImp, ulongint, UI8 )

'':::::
operator imp _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarImp( @lhs.var_, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

'':::::
operator imp _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT_ _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarImp( @lhs.var_, @rhs, @res )
	
	return VARIANT( res, FALSE )
	
end operator

