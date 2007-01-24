

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( -, VarSub, integer, I4 )
VAR_GEN_BOP_INV( -, VarSub, uinteger, UI4 )
VAR_GEN_BOP_INV( -, VarSub, longint, I8 )
VAR_GEN_BOP_INV( -, VarSub, ulongint, UI8 )
VAR_GEN_BOP_INV( -, VarSub, single, R4 )
VAR_GEN_BOP_INV( -, VarSub, double, R8 )

'':::::
operator - _
	( _
		byref lhs as VARIANT, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarSub( @lhs, @rhs.var_, @res )
	
	return CVariant( res, FALSE )
	
end operator

