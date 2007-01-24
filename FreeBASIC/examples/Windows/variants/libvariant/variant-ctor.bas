

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
	
	VariantInit( @this.var_ )
		
end constructor

'':::::
constructor CVariant _
	( _
		byref rhs as CVariant _
	) 
	
	VariantInit( @this.var_ )
	VariantCopy( @this.var_, @rhs.var_ )
		
end constructor

'':::::
constructor CVariant _
	( _
		byref rhs as CVariant, _
		byval deep_copy as integer _
	) 
	
	VariantInit( @this.var_ )
	
	if( deep_copy ) then
		VariantCopy( @this.var_, @rhs.var_ )
	else
		this.var_ = rhs.var_
	end if
		
end constructor

'':::::
constructor CVariant _
	( _
		byref rhs as VARIANT _
	) 
	
	VariantInit( @this.var_ )
	VariantCopy( @this.var_, @rhs )
		
end constructor

'':::::
constructor CVariant _
	( _
		byref rhs as VARIANT, _
		byval deep_copy as integer _
	) 
	
	VariantInit( @this.var_ )
	
	if( deep_copy ) then
		VariantCopy( @this.var_, @rhs )
	else
		this.var_ = rhs
	end if
		
end constructor

'':::::
constructor CVariant _
	( _
		byval rhs as zstring ptr _
	)
	
	VariantInit( @this.var_ )

	V_VT(@this.var_) = VT_BSTR
	V_BSTR(@this.var_) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
end constructor

'':::::
constructor CVariant _
	( _
		byval rhs as wstring ptr _
	)
	
	VariantInit( @this.var_ )

	V_VT(@this.var_) = VT_BSTR
	V_BSTR(@this.var_) = SysAllocStringLen( rhs, len( *rhs ) )
	
end constructor

