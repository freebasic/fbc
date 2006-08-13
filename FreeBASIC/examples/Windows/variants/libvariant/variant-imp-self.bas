option explicit

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( imp=, VarImp, integer, I4 )
VAR_GEN_SELFOP( imp=, VarImp, uinteger, UI4 )
VAR_GEN_SELFOP( imp=, VarImp, longint, I8 )
VAR_GEN_SELFOP( imp=, VarImp, ulongint, UI8 )

'':::::
operator imp= _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarImp( @lhs, @rhs, @res )
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
	
end operator

'':::::
operator imp= _
	( _
		byref lhs as VARIANT, _
		byval rhs as zstring ptr _
	)
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
	VarImp( @lhs, @tmp, @res )
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
	
	VariantClear( @tmp )
	
end operator

'':::::
operator imp= _
	( _
		byref lhs as VARIANT, _
		byval rhs as wstring ptr _
	)
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringLen( rhs, len( *rhs ) )
	
	VarImp( @lhs, @tmp, @res )
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
	
	VariantClear( @tmp )
	
end operator