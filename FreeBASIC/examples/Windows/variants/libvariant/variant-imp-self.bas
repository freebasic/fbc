

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( imp=, VarImp, integer, I4 )
VAR_GEN_SELFOP( imp=, VarImp, uinteger, UI4 )
VAR_GEN_SELFOP( imp=, VarImp, longint, I8 )
VAR_GEN_SELFOP( imp=, VarImp, ulongint, UI8 )

'':::::
operator CVariant.imp= _
	( _
		byref rhs as CVariant _
	)
	
	dim as VARIANT res = any
	
	VarImp( @this.var_, @rhs.var_, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

'':::::
operator CVariant.imp= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarImp( @this.var_, @rhs, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

