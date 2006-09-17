

#include once "variant.bi"
#include once "intern.bi"

'':::::
operator CVariant.shr= _
	( _
		byref rhs as CVariant _
	)
		
	dim as VARIANT res = any, tmp = any
	
	V_VT(@tmp) = VT_I4
	V_I4(@tmp) = 1 shl cint( rhs )

	VarIdiv( @this.var, @tmp, @res )
		
	VariantClear( @this.var )
	VariantCopy( @this.var, @res )
	
	VariantClear( @res )
	VariantClear( @tmp )
		
end operator

'':::::
operator CVariant.shr= _
	( _
		byval rhs as integer _
	)
		
	dim as VARIANT res = any, tmp = any
	
	V_VT(@tmp) = VT_I4
	V_I4(@tmp) = 1 shl rhs
	
	VarIdiv( @this.var, @tmp, @res )
		
	VariantClear( @this.var )
	VariantCopy( @this.var, @res )
	
	VariantClear( @res )
	VariantClear( @tmp )
		
end operator
