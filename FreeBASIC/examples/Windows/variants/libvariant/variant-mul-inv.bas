

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( *, VarMul, integer, I4 )
VAR_GEN_BOP_INV( *, VarMul, uinteger, UI4 )
VAR_GEN_BOP_INV( *, VarMul, longint, I8 )
VAR_GEN_BOP_INV( *, VarMul, ulongint, UI8 )
VAR_GEN_BOP_INV( *, VarMul, single, R4 )
VAR_GEN_BOP_INV( *, VarMul, double, R8 )

'':::::
operator * _
	( _
		byref lhs as VARIANT, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarMul( @lhs, @rhs.var_, @res )
	
	return CVariant( res, FALSE )
	
end operator

