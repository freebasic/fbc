

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_ASSIGN( integer, I4 )
VAR_GEN_ASSIGN( uinteger, UI4 )
VAR_GEN_ASSIGN( longint, I8 )
VAR_GEN_ASSIGN( ulongint, UI8 )
VAR_GEN_ASSIGN( single, R4 )
VAR_GEN_ASSIGN( double, R8 )

'':::::
operator CVariant.let _
	( _
		byval rhs as VARIANT_NOTHING _
	)
	
	VariantClear( @this.var )

end operator

'':::::
operator CVariant.let _
	( _
		byref rhs as Cvariant _
	)
	
	VariantClear( @this.var )
	VariantCopy( @this.var, @rhs.var )
	
end operator

'':::::
operator CVariant.let _
	( _
		byref rhs as VARIANT _
	)
	
	VariantClear( @this.var )
	VariantCopy( @this.var, @rhs )
	
end operator

'':::::
operator CVariant.let _
	( _
		byval rhs as zstring ptr _
	)
	
	VariantClear( @this.var )

	V_VT(@this.var) = VT_BSTR
	V_BSTR(@this.var) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
end operator

'':::::
operator CVariant.let _
	( _
		byval rhs as wstring ptr _
	)
	
	VariantClear( @this.var )

	V_VT(@this.var) = VT_BSTR
	V_BSTR(@this.var) = SysAllocStringLen( rhs, len( *rhs ) )
	
end operator

