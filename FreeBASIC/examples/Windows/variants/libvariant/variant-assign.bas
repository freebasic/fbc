option explicit

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_ASSIGN( integer, I4 )
VAR_GEN_ASSIGN( uinteger, UI4 )
VAR_GEN_ASSIGN( longint, I8 )
VAR_GEN_ASSIGN( ulongint, UI8 )
VAR_GEN_ASSIGN( single, R4 )
VAR_GEN_ASSIGN( double, R8 )

'':::::
operator let _
	( _
		byref lhs as VARIANT, _
		byval rhs as VARIANT_NOTHING _
	)
	
	VariantClear( @lhs )

end operator

'':::::
operator let _
	( _
		byref lhs as VARIANT, _
		byref rhs as VARIANT _
	)
	
	VariantClear( @lhs )
	VariantCopy( @lhs, @rhs )
	
end operator

'':::::
operator let _
	( _
		byref lhs as VARIANT, _
		byval rhs as zstring ptr _
	)
	
	VariantClear( @lhs )

	V_VT(@lhs) = VT_BSTR
	V_BSTR(@lhs) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
end operator

'':::::
operator let _
	( _
		byref lhs as VARIANT, _
		byval rhs as wstring ptr _
	)
	
	VariantClear( @lhs )

	V_VT(@lhs) = VT_BSTR
	V_BSTR(@lhs) = SysAllocStringLen( rhs, len( *rhs ) )
	
end operator

