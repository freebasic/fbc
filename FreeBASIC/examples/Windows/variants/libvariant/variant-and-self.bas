option explicit

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( and=, VarAnd, integer, I4 )
VAR_GEN_SELFOP( and=, VarAnd, uinteger, UI4 )
VAR_GEN_SELFOP( and=, VarAnd, longint, I8 )
VAR_GEN_SELFOP( and=, VarAnd, ulongint, UI8 )

'':::::
operator and= _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarAnd( @lhs, @rhs, @res )
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
	
end operator

