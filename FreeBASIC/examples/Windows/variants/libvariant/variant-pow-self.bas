option explicit

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( ^=, VarPow, integer, I4 )
VAR_GEN_SELFOP( ^=, VarPow, uinteger, UI4 )
VAR_GEN_SELFOP( ^=, VarPow, longint, I8 )
VAR_GEN_SELFOP( ^=, VarPow, ulongint, UI8 )
VAR_GEN_SELFOP( ^=, VarPow, single, R4 )
VAR_GEN_SELFOP( ^=, VarPow, double, R8 )

operator ^= _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	)
		
	dim as VARIANT res = any
	
	VarPow( @lhs, @rhs, @res )
		
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
		
end operator
