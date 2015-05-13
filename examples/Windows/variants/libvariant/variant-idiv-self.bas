

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( \=, VarIdiv, integer, I4 )
VAR_GEN_SELFOP( \=, VarIdiv, uinteger, UI4 )
VAR_GEN_SELFOP( \=, VarIdiv, longint, I8 )
VAR_GEN_SELFOP( \=, VarIdiv, ulongint, UI8 )
VAR_GEN_SELFOP( \=, VarIdiv, single, R4 )
VAR_GEN_SELFOP( \=, VarIdiv, double, R8 )


'':::::
operator VARIANT.\= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT_ res = any
	
	VarIdiv( @this.var_, @rhs.var_, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

'':::::
operator VARIANT.\= _
	( _
		byref rhs as VARIANT_ _
	)
	
	dim as VARIANT_ res = any
	
	VarIdiv( @this.var_, @rhs, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

