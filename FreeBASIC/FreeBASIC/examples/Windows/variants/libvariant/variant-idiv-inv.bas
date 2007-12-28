

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( \, VarIdiv, integer, I4 )
VAR_GEN_BOP_INV( \, VarIdiv, uinteger, UI4 )
VAR_GEN_BOP_INV( \, VarIdiv, longint, I8 )
VAR_GEN_BOP_INV( \, VarIdiv, ulongint, UI8 )
VAR_GEN_BOP_INV( \, VarIdiv, single, R4 )
VAR_GEN_BOP_INV( \, VarIdiv, double, R8 )

'':::::
operator \ _
	( _
		byref lhs as VARIANT_, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarIdiv( @lhs, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

