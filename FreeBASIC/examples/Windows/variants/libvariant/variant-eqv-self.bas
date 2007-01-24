

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( eqv=, VarEqv, integer, I4 )
VAR_GEN_SELFOP( eqv=, VarEqv, uinteger, UI4 )
VAR_GEN_SELFOP( eqv=, VarEqv, longint, I8 )
VAR_GEN_SELFOP( eqv=, VarEqv, ulongint, UI8 )

'':::::
operator CVariant.eqv= _
	( _
		byref rhs as CVariant _
	)
	
	dim as VARIANT res = any
	
	VarEqv( @this.var_, @rhs.var_, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

'':::::
operator CVariant.eqv= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarEqv( @this.var_, @rhs, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

