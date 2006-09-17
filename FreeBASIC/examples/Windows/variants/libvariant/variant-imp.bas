

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP( imp, VarImp, integer, I4 )
VAR_GEN_BOP( imp, VarImp, uinteger, UI4 )
VAR_GEN_BOP( imp, VarImp, longint, I8 )
VAR_GEN_BOP( imp, VarImp, ulongint, UI8 )

'':::::
operator imp _
	( _
		byref lhs as CVariant, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarImp( @lhs.var, @rhs.var, @res )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator imp _
	( _
		byref lhs as CVariant, _
		byref rhs as VARIANT _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarImp( @lhs.var, @rhs, @res )
	
	return CVariant( res, FALSE )
	
end operator

'':::::
operator imp _
	( _
		byref lhs as CVariant, _
		byval rhs as zstring ptr _
	) as CVariant
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
	VarImp( @lhs.var, @tmp, @res )
	
	return CVariant( res )
	
	VariantClear( @tmp )
	
end operator

'':::::
operator imp _
	( _
		byref lhs as CVariant, _
		byval rhs as wstring ptr _
	) as CVariant
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringLen( rhs, len( *rhs ) )
	
	VarImp( @lhs.var, @tmp, @res )
	
	return CVariant( res )
	
	VariantClear( @tmp )
	
end operator

