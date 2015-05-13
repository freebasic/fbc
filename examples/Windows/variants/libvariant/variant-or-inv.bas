

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( or, VarOr, integer, I4 )
VAR_GEN_BOP_INV( or, VarOr, uinteger, UI4 )
VAR_GEN_BOP_INV( or, VarOr, longint, I8 )
VAR_GEN_BOP_INV( or, VarOr, ulongint, UI8 )

'':::::
operator or _
	( _
		byref lhs as VARIANT_, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarOr( @lhs, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

