

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( /, VarDiv, integer, I4 )
VAR_GEN_BOP_INV( /, VarDiv, uinteger, UI4 )
VAR_GEN_BOP_INV( /, VarDiv, longint, I8 )
VAR_GEN_BOP_INV( /, VarDiv, ulongint, UI8 )
VAR_GEN_BOP_INV( /, VarDiv, single, R4 )
VAR_GEN_BOP_INV( /, VarDiv, double, R8 )

'':::::
operator / _
	( _
		byref lhs as VARIANT_, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarDiv( @lhs, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

