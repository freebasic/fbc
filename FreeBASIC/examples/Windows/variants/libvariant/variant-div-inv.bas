

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
		byref lhs as VARIANT, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarDiv( @lhs, @rhs.var, @res )
	
	return CVariant( res, FALSE )
	
end operator

