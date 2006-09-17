

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( and=, VarAnd, integer, I4 )
VAR_GEN_SELFOP( and=, VarAnd, uinteger, UI4 )
VAR_GEN_SELFOP( and=, VarAnd, longint, I8 )
VAR_GEN_SELFOP( and=, VarAnd, ulongint, UI8 )

'':::::
operator CVariant.and= _
	( _
		byref rhs as CVariant _
	)
	
	dim as VARIANT res = any
	
	VarAnd( @this.var, @rhs.var, @res )
	
	VariantClear( @this.var )
	this.var = res
	
end operator


'':::::
operator CVariant.and= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarAnd( @this.var, @rhs, @res )
	
	VariantClear( @this.var )
	this.var = res
	
end operator

