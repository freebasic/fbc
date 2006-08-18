

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
	
	dim as VARIANT res = any
	
	VarOr( @lhs, @rhs, @res )
	
	operator = res
	
end operator

