option explicit

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( mod=, VarMod, integer, I4 )
VAR_GEN_SELFOP( mod=, VarMod, uinteger, UI4 )
VAR_GEN_SELFOP( mod=, VarMod, longint, I8 )
VAR_GEN_SELFOP( mod=, VarMod, ulongint, UI8 )
VAR_GEN_SELFOP( mod=, VarMod, single, R4 )
VAR_GEN_SELFOP( mod=, VarMod, double, R8 )

'':::::
operator mod= _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarMod( @lhs, @rhs, @res )
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
	
end operator

