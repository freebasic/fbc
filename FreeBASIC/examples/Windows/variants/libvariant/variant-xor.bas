

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP( xor, VarXor, integer, I4 )
VAR_GEN_BOP( xor, VarXor, uinteger, UI4 )
VAR_GEN_BOP( xor, VarXor, longint, I8 )
VAR_GEN_BOP( xor, VarXor, ulongint, UI8 )

'':::::
operator xor _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT res = any
	
	VarXor( @lhs, @rhs, @res )
	
	operator = res
	
end operator

