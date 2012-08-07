

#include once "variant.bi"
#include once "intern.bi"

'':::::
operator VARIANT.shr= _
	( _
		byref rhs as VARIANT _
	)
		
	dim as VARIANT_ res = any, tmp = any
	
	V_VT(@tmp) = VT_I4
	V_I4(@tmp) = 1 shl cint( rhs )

	VarIdiv( @this.var_, @tmp, @res )
		
	VariantClear( @this.var_ )
	this.var_ = res
	
	VariantClear( @tmp )
		
end operator

'':::::
operator VARIANT.shr= _
	( _
		byval rhs as integer _
	)
		
	dim as VARIANT_ res = any, tmp = any
	
	V_VT(@tmp) = VT_I4
	V_I4(@tmp) = 1 shl rhs
	
	VarIdiv( @this.var_, @tmp, @res )
		
	VariantClear( @this.var_ )
	this.var_ = res
	
	VariantClear( @tmp )
		
end operator
