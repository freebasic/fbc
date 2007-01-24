

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

'':::::
operator - _
	( _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarNeg( @rhs.var_, @res )
	
	return CVariant( res, FALSE )
	
end operator

