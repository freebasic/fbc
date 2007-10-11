

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( xor, VarXor, integer, I4 )
VAR_GEN_BOP_INV( xor, VarXor, uinteger, UI4 )
VAR_GEN_BOP_INV( xor, VarXor, longint, I8 )
VAR_GEN_BOP_INV( xor, VarXor, ulongint, UI8 )

'':::::
operator xor _
	( _
		byref lhs as VARIANT_, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarXor( @lhs, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

