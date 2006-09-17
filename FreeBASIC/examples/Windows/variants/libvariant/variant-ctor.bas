

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_CTOR( integer, I4 )
VAR_GEN_CTOR( uinteger, UI4 )
VAR_GEN_CTOR( longint, I8 )
VAR_GEN_CTOR( ulongint, UI8 )
VAR_GEN_CTOR( single, R4 )
VAR_GEN_CTOR( double, R8 )

'':::::
constructor CVariant _
	( _
		_
	) 
	
	VariantInit( @this.var )
		
end constructor

'':::::
constructor CVariant _
	( _
		byref rhs as CVariant _
	) 
	
	VariantInit( @this.var )
	VariantCopy( @this.var, @rhs.var )
		
end constructor

'':::::
constructor CVariant _
	( _
		byref rhs as VARIANT _
	) 
	
	VariantInit( @this.var )
	VariantCopy( @this.var, @rhs )
		
end constructor

'':::::
constructor CVariant _
	( _
		byval rhs as zstring ptr _
	)
	
	VariantInit( @this.var )

	V_VT(@this.var) = VT_BSTR
	V_BSTR(@this.var) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
end constructor

'':::::
constructor CVariant _
	( _
		byval rhs as wstring ptr _
	)
	
	VariantInit( @this.var )

	V_VT(@this.var) = VT_BSTR
	V_BSTR(@this.var) = SysAllocStringLen( rhs, len( *rhs ) )
	
end constructor

