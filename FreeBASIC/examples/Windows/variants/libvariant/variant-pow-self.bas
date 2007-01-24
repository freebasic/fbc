

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( ^=, VarPow, integer, I4 )
VAR_GEN_SELFOP( ^=, VarPow, uinteger, UI4 )
VAR_GEN_SELFOP( ^=, VarPow, longint, I8 )
VAR_GEN_SELFOP( ^=, VarPow, ulongint, UI8 )
VAR_GEN_SELFOP( ^=, VarPow, single, R4 )
VAR_GEN_SELFOP( ^=, VarPow, double, R8 )

operator CVariant.^= _
	( _
		byref rhs as CVariant _
	)
		
	dim as VARIANT res = any
	
	VarPow( @this.var_, @rhs.var_, @res )
		
	VariantClear( @this.var_ )
	this.var_ = res
		
end operator

operator CVariant.^= _
	( _
		byref rhs as VARIANT _
	)
		
	dim as VARIANT res = any
	
	VarPow( @this.var_, @rhs, @res )
		
	VariantClear( @this.var_ )
	this.var_ = res
		
end operator
