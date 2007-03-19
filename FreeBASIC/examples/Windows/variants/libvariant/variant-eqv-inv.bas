

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( eqv, VarEqv, integer, I4 )
VAR_GEN_BOP_INV( eqv, VarEqv, uinteger, UI4 )
VAR_GEN_BOP_INV( eqv, VarEqv, longint, I8 )
VAR_GEN_BOP_INV( eqv, VarEqv, ulongint, UI8 )

'':::::
operator eqv _
	( _
		byref lhs as VARIANT_, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarEqv( @lhs, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

