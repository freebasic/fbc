

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( *=, VarMul, integer, I4 )
VAR_GEN_SELFOP( *=, VarMul, uinteger, UI4 )
VAR_GEN_SELFOP( *=, VarMul, longint, I8 )
VAR_GEN_SELFOP( *=, VarMul, ulongint, UI8 )
VAR_GEN_SELFOP( *=, VarMul, single, R4 )
VAR_GEN_SELFOP( *=, VarMul, double, R8 )

'':::::
operator CVariant.*= _
	( _
		byref rhs as CVariant _
	)
		
	dim as VARIANT res = any
	
	VarMul( @this.var, @rhs.var, @res )
		
	VariantClear( @this.var )
	VariantCopy( @this.var, @res )
		
end operator

'':::::
operator CVariant.*= _
	( _
		byref rhs as VARIANT _
	)
		
	dim as VARIANT res = any
	
	VarMul( @this.var, @rhs, @res )
		
	VariantClear( @this.var )
	VariantCopy( @this.var, @res )
		
end operator
