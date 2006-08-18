

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
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT res = any
	
	VarIdiv( @lhs, @rhs, @res )
	
	operator = res
	
end operator

