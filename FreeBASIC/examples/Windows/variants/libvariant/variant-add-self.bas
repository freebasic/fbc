

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( +=, VarAdd, integer, I4 )
VAR_GEN_SELFOP( +=, VarAdd, uinteger, UI4 )
VAR_GEN_SELFOP( +=, VarAdd, longint, I8 )
VAR_GEN_SELFOP( +=, VarAdd, ulongint, UI8 )
VAR_GEN_SELFOP( +=, VarAdd, single, R4 )
VAR_GEN_SELFOP( +=, VarAdd, double, R8 )

'':::::
operator += _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarAdd( @lhs, @rhs, @res )
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
	
end operator

'':::::
operator += _
	( _
		byref lhs as VARIANT, _
		byval rhs as zstring ptr _
	)
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
	VarAdd( @lhs, @tmp, @res )
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
	
	VariantClear( @tmp )
	
end operator

'':::::
operator += _
	( _
		byref lhs as VARIANT, _
		byval rhs as wstring ptr _
	)
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringLen( rhs, len( *rhs ) )
	
	VarAdd( @lhs, @tmp, @res )
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @res )
	
	VariantClear( @tmp )
	
end operator