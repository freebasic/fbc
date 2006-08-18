

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( \=, VarIdiv, integer, I4 )
VAR_GEN_SELFOP( \=, VarIdiv, uinteger, UI4 )
VAR_GEN_SELFOP( \=, VarIdiv, longint, I8 )
VAR_GEN_SELFOP( \=, VarIdiv, ulongint, UI8 )
VAR_GEN_SELFOP( \=, VarIdiv, single, R4 )
VAR_GEN_SELFOP( \=, VarIdiv, double, R8 )

'':::::
operator \= _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarIdiv( @lhs, @rhs, @res )
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
	
end operator

