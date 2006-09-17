

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP( eqv, VarEqv, integer, I4 )
VAR_GEN_BOP( eqv, VarEqv, uinteger, UI4 )
VAR_GEN_BOP( eqv, VarEqv, longint, I8 )
VAR_GEN_BOP( eqv, VarEqv, ulongint, UI8 )

'':::::
operator eqv _
	( _
		byref lhs as CVariant, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarEqv( @lhs.var, @rhs.var, @res )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator eqv _
	( _
		byref lhs as CVariant, _
		byref rhs as VARIANT _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarEqv( @lhs.var, @rhs, @res )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator eqv _
	( _
		byref lhs as CVariant, _
		byval rhs as zstring ptr _
	) as CVariant
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
	VarEqv( @lhs.var, @tmp, @res )
	
	VariantClear( @tmp )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator eqv _
	( _
		byref lhs as CVariant, _
		byval rhs as wstring ptr _
	) as CVariant
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringLen( rhs, len( *rhs ) )
	
	VarEqv( @lhs.var, @tmp, @res )
	
	VariantClear( @tmp )
	
	return CVariant( res, FALSE )
	
end operator

