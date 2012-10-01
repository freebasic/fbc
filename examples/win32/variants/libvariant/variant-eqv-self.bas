

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( eqv=, VarEqv, integer, I4 )
VAR_GEN_SELFOP( eqv=, VarEqv, uinteger, UI4 )
VAR_GEN_SELFOP( eqv=, VarEqv, longint, I8 )
VAR_GEN_SELFOP( eqv=, VarEqv, ulongint, UI8 )

'':::::
operator VARIANT.eqv= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT_ res = any
	
	VarEqv( @this.var_, @rhs.var_, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

'':::::
operator VARIANT.eqv= _
	( _
		byref rhs as VARIANT_ _
	)
	
	dim as VARIANT_ res = any
	
	VarEqv( @this.var_, @rhs, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

