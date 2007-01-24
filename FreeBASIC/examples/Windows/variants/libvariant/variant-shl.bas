

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

'':::::
operator shl _
	( _
		byref lhs as CVariant, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any, tmp = any
	
	V_VT(@tmp) = VT_I4
	V_I4(@tmp) = 1 shl cint( rhs )
	
	VarMul( @lhs.var_, @tmp, @res )
	
	VariantClear( @tmp )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator shl _
	( _
		byref lhs as CVariant, _
		byval rhs as integer _
	) as CVariant
	
	dim as VARIANT res = any, tmp = any
	
	V_VT(@tmp) = VT_I4
	V_I4(@tmp) = 1 shl rhs
	
	VarMul( @lhs.var_, @tmp, @res )
	
	VariantClear( @tmp )
	
	return CVariant( res, FALSE )
	
end operator

