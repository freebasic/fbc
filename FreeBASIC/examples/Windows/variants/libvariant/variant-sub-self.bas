

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( -=, VarSub, integer, I4 )
VAR_GEN_SELFOP( -=, VarSub, uinteger, UI4 )
VAR_GEN_SELFOP( -=, VarSub, longint, I8 )
VAR_GEN_SELFOP( -=, VarSub, ulongint, UI8 )
VAR_GEN_SELFOP( -=, VarSub, single, R4 )
VAR_GEN_SELFOP( -=, VarSub, double, R8 )

operator CVariant.-= _
	( _
		byref rhs as CVariant _
	)
		
	dim as VARIANT res = any
	
	VarSub( @this.var_, @rhs.var_, @res )
		
	VariantClear( @this.var_ )
	this.var_ = res
		
end operator

operator CVariant.-= _
	( _
		byref rhs as VARIANT _
	)
		
	dim as VARIANT res = any
	
	VarSub( @this.var_, @rhs, @res )
		
	VariantClear( @this.var_ )
	this.var_ = res
		
end operator
