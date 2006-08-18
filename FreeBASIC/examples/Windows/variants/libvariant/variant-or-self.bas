

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( or=, VarOr, integer, I4 )
VAR_GEN_SELFOP( or=, VarOr, uinteger, UI4 )
VAR_GEN_SELFOP( or=, VarOr, longint, I8 )
VAR_GEN_SELFOP( or=, VarOr, ulongint, UI8 )

'':::::
operator or= _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarOr( @lhs, @rhs, @res )
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
	
end operator

