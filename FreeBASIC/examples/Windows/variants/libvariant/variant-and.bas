

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP( and, VarAnd, integer, I4 )
VAR_GEN_BOP( and, VarAnd, uinteger, UI4 )
VAR_GEN_BOP( and, VarAnd, longint, I8 )
VAR_GEN_BOP( and, VarAnd, ulongint, UI8 )

'':::::
operator and _
	( _
		byref lhs as CVariant, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarAnd( @lhs.var, @rhs.var, @res )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator and _
	( _
		byref lhs as CVariant, _
		byref rhs as VARIANT _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarAnd( @lhs.var, @rhs, @res )
	
	return CVariant( res, FALSE )
	
end operator

