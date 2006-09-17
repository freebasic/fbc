

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( \=, VarIdiv, integer, I4 )
VAR_GEN_SELFOP( \=, VarIdiv, uinteger, UI4 )
VAR_GEN_SELFOP( \=, VarIdiv, longint, I8 )
VAR_GEN_SELFOP( \=, VarIdiv, ulongint, UI8 )
VAR_GEN_SELFOP( \=, VarIdiv, single, R4 )
VAR_GEN_SELFOP( \=, VarIdiv, double, R8 )


'':::::
operator CVariant.\= _
	( _
		byref rhs as CVariant _
	)
	
	dim as VARIANT res = any
	
	VarIdiv( @this.var, @rhs.var, @res )
	
	VariantClear( @this.var )
	this.var = res
	
end operator

'':::::
operator CVariant.\= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarIdiv( @this.var, @rhs, @res )
	
	VariantClear( @this.var )
	this.var = res
	
end operator

