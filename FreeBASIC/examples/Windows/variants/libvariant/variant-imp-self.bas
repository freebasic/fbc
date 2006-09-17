

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
	
	VarImp( @this.var, @rhs.var, @res )
	
	VariantClear( @this.var )
	this.var = res
	
end operator

'':::::
operator CVariant.imp= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarImp( @this.var, @rhs, @res )
	
	VariantClear( @this.var )
	this.var = res
	
end operator

