

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( +=, VarAdd, integer, I4 )
VAR_GEN_SELFOP( +=, VarAdd, uinteger, UI4 )
VAR_GEN_SELFOP( +=, VarAdd, longint, I8 )
VAR_GEN_SELFOP( +=, VarAdd, ulongint, UI8 )
VAR_GEN_SELFOP( +=, VarAdd, single, R4 )
VAR_GEN_SELFOP( +=, VarAdd, double, R8 )

'':::::
operator VARIANT.+= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT_ res = any
	
	VarAdd( @this.var_, @rhs.var_, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

'':::::
operator VARIANT.+= _
	( _
		byref rhs as VARIANT_ _
	)
	
	dim as VARIANT_ res = any
	
	VarAdd( @this.var_, @rhs, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
end operator

'':::::
operator VARIANT.+= _
	( _
		byval rhs as zstring ptr _
	)
	
	dim as VARIANT_ tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
	VarAdd( @this.var_, @tmp, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
	VariantClear( @tmp )
	
end operator

'':::::
operator VARIANT.+= _
	( _
		byval rhs as wstring ptr _
	)
	
	dim as VARIANT_ tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringLen( rhs, len( *rhs ) )
	
	VarAdd( @this.var_, @tmp, @res )
	
	VariantClear( @this.var_ )
	this.var_ = res
	
	VariantClear( @tmp )
	
end operator