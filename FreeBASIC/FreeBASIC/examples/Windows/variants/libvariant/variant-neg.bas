

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

'':::::
operator - _
	( _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarNeg( @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

