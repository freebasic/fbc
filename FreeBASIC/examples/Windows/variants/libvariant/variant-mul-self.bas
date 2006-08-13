option explicit

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( *=, VarMul, integer, I4 )
VAR_GEN_SELFOP( *=, VarMul, uinteger, UI4 )
VAR_GEN_SELFOP( *=, VarMul, longint, I8 )
VAR_GEN_SELFOP( *=, VarMul, ulongint, UI8 )
VAR_GEN_SELFOP( *=, VarMul, single, R4 )
VAR_GEN_SELFOP( *=, VarMul, double, R8 )

operator *= _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	)
		
	dim as VARIANT res = any
	
	VarMul( @lhs, @rhs, @res )
		
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
		
end operator
