

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( +=, VarAdd, integer, I4 )
VAR_GEN_SELFOP( +=, VarAdd, uinteger, UI4 )
VAR_GEN_SELFOP( +=, VarAdd, longint, I8 )
VAR_GEN_SELFOP( +=, VarAdd, ulongint, UI8 )
VAR_GEN_SELFOP( +=, VarAdd, single, R4 )
VAR_GEN_SELFOP( +=, VarAdd, double, R8 )

'':::::
operator CVariant.+= _
	( _
		byref rhs as CVariant _
	)
	
	dim as VARIANT res = any
	
	VarAdd( @this.var, @rhs.var, @res )
	
	VariantClear( @this.var )
	this.var = res
	
end operator

'':::::
operator CVariant.+= _
	( _
		byref rhs as VARIANT _
	)
	
	dim as VARIANT res = any
	
	VarAdd( @this.var, @rhs, @res )
	
	VariantClear( @this.var )
	this.var = res
	
end operator

'':::::
operator CVariant.+= _
	( _
		byval rhs as zstring ptr _
	)
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
	VarAdd( @this.var, @tmp, @res )
	
	VariantClear( @this.var )
	this.var = res
	
	VariantClear( @tmp )
	
end operator

'':::::
operator CVariant.+= _
	( _
		byval rhs as wstring ptr _
	)
	
	dim as VARIANT tmp = any, res = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringLen( rhs, len( *rhs ) )
	
	VarAdd( @this.var, @tmp, @res )
	
	VariantClear( @this.var )
	this.var = res
	
	VariantClear( @tmp )
	
end operator