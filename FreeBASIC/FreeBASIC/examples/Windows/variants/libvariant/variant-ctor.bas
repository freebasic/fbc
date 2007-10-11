

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_CTOR( integer, I4 )
VAR_GEN_CTOR( uinteger, UI4 )
VAR_GEN_CTOR( longint, I8 )
VAR_GEN_CTOR( ulongint, UI8 )
VAR_GEN_CTOR( single, R4 )
VAR_GEN_CTOR( double, R8 )

'':::::
constructor VARIANT _
	( _
		_
	) 
	
	VariantInit( @this.var_ )
	
end constructor

'':::::
constructor VARIANT _
	( _
		byref rhs as VARIANT _
	) 
	
	VariantInit( @this.var_ )
	VariantCopy( @this.var_, @rhs.var_ )
		
end constructor

'':::::
constructor VARIANT _
	( _
		byref rhs as VARIANT, _
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
constructor VARIANT _
	( _
		byref rhs as VARIANT_ _
	) 
	
	VariantInit( @this.var_ )
	VariantCopy( @this.var_, @rhs )
	
end constructor

'':::::
constructor VARIANT _
	( _
		byref rhs as VARIANT_, _
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
constructor VARIANT _
	( _
		byval rhs as zstring ptr _
	)
	
	VariantInit( @this.var_ )
	
	var wlen = MultiByteToWideChar(CP_ACP, NULL, rhs, &HFFFFFFFF, 0, 0)
	
 	V_VT(@this.var_) = VT_BSTR
	V_BSTR(@this.var_) = SysAllocStringLen(NULL, wlen)	
	
	MultiByteToWideChar(CP_ACP, NULL, rhs, &HFFFFFFFF, V_BSTR(@this.var_), wlen)
	
end constructor

'':::::
constructor VARIANT _
	( _
		byval rhs as wstring ptr _
	)
	
	VariantInit( @this.var_ )
	
	V_VT(@this.var_) = VT_BSTR
	V_BSTR(@this.var_) = SysAllocStringLen( rhs, len( *rhs ) )
	
end constructor

