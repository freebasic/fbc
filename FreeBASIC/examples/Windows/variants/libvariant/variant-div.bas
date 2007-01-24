

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP( /, VarDiv, integer, I4 )
VAR_GEN_BOP( /, VarDiv, uinteger, UI4 )
VAR_GEN_BOP( /, VarDiv, longint, I8 )
VAR_GEN_BOP( /, VarDiv, ulongint, UI8 )
VAR_GEN_BOP( /, VarDiv, single, R4 )
VAR_GEN_BOP( /, VarDiv, double, R8 )

'':::::
operator / _
	( _
		byref lhs as CVariant, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarDiv( @lhs.var_, @rhs.var_, @res )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator / _
	( _
		byref lhs as CVariant, _
		byref rhs as VARIANT _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarDiv( @lhs.var_, @rhs, @res )
	
	return CVariant( res, FALSE )
	
end operator

