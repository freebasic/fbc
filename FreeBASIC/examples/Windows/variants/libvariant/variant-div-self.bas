

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( /=, VarDiv, integer, I4 )
VAR_GEN_SELFOP( /=, VarDiv, uinteger, UI4 )
VAR_GEN_SELFOP( /=, VarDiv, longint, I8 )
VAR_GEN_SELFOP( /=, VarDiv, ulongint, UI8 )
VAR_GEN_SELFOP( /=, VarDiv, single, R4 )
VAR_GEN_SELFOP( /=, VarDiv, double, R8 )

'':::::
operator CVariant./= _
	( _
		byref rhs as CVariant _
	)
	
	dim as VARIANT res = any
	
	VarDiv( @this.var, @rhs.var, @res )
	
	VariantClear( @this.var )
	this.var = res
	
end operator

'':::::
operator CVariant./= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarDiv( @this.var, @rhs, @res )
	
	VariantClear( @this.var )
	this.var = res
	
end operator

