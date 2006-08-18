

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( -=, VarSub, integer, I4 )
VAR_GEN_SELFOP( -=, VarSub, uinteger, UI4 )
VAR_GEN_SELFOP( -=, VarSub, longint, I8 )
VAR_GEN_SELFOP( -=, VarSub, ulongint, UI8 )
VAR_GEN_SELFOP( -=, VarSub, single, R4 )
VAR_GEN_SELFOP( -=, VarSub, double, R8 )

operator -= _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	)
		
	dim as VARIANT res = any
	
	VarSub( @lhs, @rhs, @res )
		
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
		
end operator
