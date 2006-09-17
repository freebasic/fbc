

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP( \, VarIdiv, integer, I4 )
VAR_GEN_BOP( \, VarIdiv, uinteger, UI4 )
VAR_GEN_BOP( \, VarIdiv, longint, I8 )
VAR_GEN_BOP( \, VarIdiv, ulongint, UI8 )
VAR_GEN_BOP( \, VarIdiv, single, R4 )
VAR_GEN_BOP( \, VarIdiv, double, R8 )

'':::::
operator \ _
	( _
		byref lhs as CVariant, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarIdiv( @lhs.var, @rhs.var, @res )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator \ _
	( _
		byref lhs as CVariant, _
		byref rhs as VARIANT _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarIdiv( @lhs.var, @rhs, @res )
	
	return CVariant( res, FALSE )
	
end operator

