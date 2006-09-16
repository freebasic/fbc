

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( or=, VarOr, integer, I4 )
VAR_GEN_SELFOP( or=, VarOr, uinteger, UI4 )
VAR_GEN_SELFOP( or=, VarOr, longint, I8 )
VAR_GEN_SELFOP( or=, VarOr, ulongint, UI8 )

'':::::
operator CVariant.or= _
	( _
		byref rhs as CVariant _
	)
	
	dim as VARIANT res = any
	
	VarOr( @this.var, @rhs.var, @res )
	
	VariantClear( @this.var )
	VariantCopy( @this.var, @res )
	
end operator

'':::::
operator CVariant.or= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarOr( @this.var, @rhs, @res )
	
	VariantClear( @this.var )
	VariantCopy( @this.var, @res )
	
end operator

