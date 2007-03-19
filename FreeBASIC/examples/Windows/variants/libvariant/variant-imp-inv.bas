

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( imp, VarImp, integer, I4 )
VAR_GEN_BOP_INV( imp, VarImp, uinteger, UI4 )
VAR_GEN_BOP_INV( imp, VarImp, longint, I8 )
VAR_GEN_BOP_INV( imp, VarImp, ulongint, UI8 )

'':::::
operator imp _
	( _
		byref lhs as VARIANT_, _
		byref rhs as VARIANT _
	) as VARIANT
	
	dim as VARIANT_ res = any
	
	VarImp( @lhs, @rhs.var_, @res )
	
	return VARIANT( res, FALSE )
	
end operator

