

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
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT res = any
	
	VarDiv( @lhs, @rhs, @res )
	
	operator = res
	
end operator

