

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
		byref lhs as CVariant, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarXor( @lhs.var_, @rhs.var_, @res )
	
	return CVariant( res, FALSE )
	
end operator


'':::::
operator xor _
	( _
		byref lhs as CVariant, _
		byref rhs as VARIANT _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarXor( @lhs.var_, @rhs, @res )
	
	return CVariant( res, FALSE )
	
end operator

