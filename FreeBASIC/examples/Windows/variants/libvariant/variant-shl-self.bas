

#include once "variant.bi"
#include once "intern.bi"

'':::::
operator CVariant.shl= _
	( _
		byref rhs as CVariant _
	)
		
	dim as VARIANT res = any, tmp = any
	
	V_VT(@tmp) = VT_I4
	V_I4(@tmp) = 1 shl cint( rhs )

	VarMul( @this.var, @tmp, @res )
		
	VariantClear( @this.var )
	this.var = res
	
	VariantClear( @tmp )
		
end operator

'':::::
operator CVariant.shl= _
	( _
		byval rhs as integer _
	)
		
	dim as VARIANT res = any, tmp = any
	
	V_VT(@tmp) = VT_I4
	V_I4(@tmp) = 1 shl rhs
	
	VarMul( @this.var, @tmp, @res )
		
	VariantClear( @this.var )
	this.var = res
	
	VariantClear( @tmp )
		
end operator
