

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( xor=, VarXor, integer, I4 )
VAR_GEN_SELFOP( xor=, VarXor, uinteger, UI4 )
VAR_GEN_SELFOP( xor=, VarXor, longint, I8 )
VAR_GEN_SELFOP( xor=, VarXor, ulongint, UI8 )

'':::::
operator xor= _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarXor( @lhs, @rhs, @res )
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
	
end operator

