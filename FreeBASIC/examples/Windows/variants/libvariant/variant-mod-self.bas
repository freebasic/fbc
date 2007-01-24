

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( mod=, VarMod, integer, I4 )
VAR_GEN_SELFOP( mod=, VarMod, uinteger, UI4 )
VAR_GEN_SELFOP( mod=, VarMod, longint, I8 )
VAR_GEN_SELFOP( mod=, VarMod, ulongint, UI8 )
VAR_GEN_SELFOP( mod=, VarMod, single, R4 )
VAR_GEN_SELFOP( mod=, VarMod, double, R8 )

'':::::
operator CVariant.mod= _
	( _
		byref rhs as CVariant _
	)
	
	dim as VARIANT res = any
	
	VarMod( @this.var_, @rhs.var_, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

'':::::
operator CVariant.mod= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarMod( @this.var_, @rhs, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

