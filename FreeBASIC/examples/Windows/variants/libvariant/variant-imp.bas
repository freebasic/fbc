

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
		byref lhs as CVariant, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarImp( @lhs.var_, @rhs.var_, @res )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator imp _
	( _
		byref lhs as CVariant, _
		byref rhs as VARIANT _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarImp( @lhs.var_, @rhs, @res )
	
	return CVariant( res, FALSE )
	
end operator

