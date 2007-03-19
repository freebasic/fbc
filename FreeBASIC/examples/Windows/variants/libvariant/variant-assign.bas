

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_ASSIGN( integer, I4 )
VAR_GEN_ASSIGN( uinteger, UI4 )
VAR_GEN_ASSIGN( longint, I8 )
VAR_GEN_ASSIGN( ulongint, UI8 )
VAR_GEN_ASSIGN( single, R4 )
VAR_GEN_ASSIGN( double, R8 )

'':::::
operator VARIANT.let _
	( _
		byval rhs as VARIANT_NOTHING _
	)
	
	VariantClear( @this.var_ )

end operator

'':::::
operator VARIANT.let _
	( _
		byref rhs as VARIANT _
	)
	
	VariantClear( @this.var_ )
	VariantCopy( @this.var_, @rhs.var_ )
	
end operator

'':::::
operator VARIANT.let _
	( _
		byref rhs as VARIANT_ _
	)
	
	VariantClear( @this.var_ )
	VariantCopy( @this.var_, @rhs )
	
end operator

'':::::
operator VARIANT.let _
	( _
		byval rhs as zstring ptr _
	)
	
	VariantClear( @this.var_ )

	V_VT(@this.var_) = VT_BSTR
	V_BSTR(@this.var_) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
end operator

'':::::
operator VARIANT.let _
	( _
		byval rhs as wstring ptr _
	)
	
	VariantClear( @this.var_ )

	V_VT(@this.var_) = VT_BSTR
	V_BSTR(@this.var_) = SysAllocStringLen( rhs, len( *rhs ) )
	
end operator

