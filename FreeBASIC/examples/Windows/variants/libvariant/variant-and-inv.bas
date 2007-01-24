

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( and, VarAnd, integer, I4 )
VAR_GEN_BOP_INV( and, VarAnd, uinteger, UI4 )
VAR_GEN_BOP_INV( and, VarAnd, longint, I8 )
VAR_GEN_BOP_INV( and, VarAnd, ulongint, UI8 )

'':::::
operator and _
	( _
		byref lhs as VARIANT, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarAnd( @lhs, @rhs.var_, @res )
	
	return CVariant( res, FALSE )
	
end operator

