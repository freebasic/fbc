

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( xor=, VarXor, integer, I4 )
VAR_GEN_SELFOP( xor=, VarXor, uinteger, UI4 )
VAR_GEN_SELFOP( xor=, VarXor, longint, I8 )
VAR_GEN_SELFOP( xor=, VarXor, ulongint, UI8 )

'':::::
operator CVariant.xor= _
	( _
		byref rhs as CVariant _
	)
	
	dim as VARIANT res = any
	
	VarXor( @this.var, @rhs.var, @res )
	
	VariantClear( @this.var )
	VariantCopy( @this.var, @res )
	
end operator

'':::::
operator CVariant.xor= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarXor( @this.var, @rhs, @res )
	
	VariantClear( @this.var )
	VariantCopy( @this.var, @res )
	
end operator

