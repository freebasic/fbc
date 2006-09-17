

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
		byref lhs as VARIANT, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarOr( @lhs, @rhs.var, @res )
	
	return CVariant( res, FALSE )
	
end operator

