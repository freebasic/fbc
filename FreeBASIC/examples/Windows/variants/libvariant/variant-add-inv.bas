

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP_INV( +, VarAdd, integer, I4 )
VAR_GEN_BOP_INV( +, VarAdd, uinteger, UI4 )
VAR_GEN_BOP_INV( +, VarAdd, longint, I8 )
VAR_GEN_BOP_INV( +, VarAdd, ulongint, UI8 )
VAR_GEN_BOP_INV( +, VarAdd, single, R4 )
VAR_GEN_BOP_INV( +, VarAdd, double, R8 )

'':::::
operator + _
	( _
		byref lhs as VARIANT, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarAdd( @lhs, @rhs.var_, @res )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator + _
	( _
		byval lhs as zstring ptr, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringByteLen( lhs, len( *lhs ) )
	
	VarAdd( @tmp, @rhs.var_, @res )
	
	VariantClear( @tmp )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator + _
	( _
		byval lhs as wstring ptr, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringLen( lhs, len( *lhs ) )
	
	VarAdd( @tmp, @rhs.var_, @res )
	
	VariantClear( @tmp )
	
	return CVariant( res, FALSE )
	
end operator

