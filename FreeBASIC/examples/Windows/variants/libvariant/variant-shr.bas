

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

'':::::
operator shr _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any, tmp = any
	
	V_VT(@tmp) = VT_I4
	V_I4(@tmp) = 1 shl cint( rhs )
	
	VarIdiv( @lhs.var_, @tmp, @res )
	
	VariantClear( @tmp )
	
	return VARIANT( res, FALSE )
	
end operator

'':::::
operator shr _
	( _
		byref lhs as VARIANT, _
		byval rhs as integer _
	) as VARIANT
	
	dim as VARIANT_ res = any, tmp = any
	
	V_VT(@tmp) = VT_I4
	V_I4(@tmp) = 1 shl rhs
	
	VarIdiv( @lhs.var_, @tmp, @res )
	
	VariantClear( @tmp )
	
	return VARIANT( res, FALSE )
	
end operator

