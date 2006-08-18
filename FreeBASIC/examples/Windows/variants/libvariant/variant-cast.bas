

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_CAST( integer, I4 )
VAR_GEN_CAST( uinteger, UI4 )
VAR_GEN_CAST( longint, I8 )
VAR_GEN_CAST( ulongint, UI8 )
VAR_GEN_CAST( single, R4 )
VAR_GEN_CAST( double, R8 )

'':::::
operator cast _
	( _
		byref lhs as VARIANT _
	) as string
	
	dim as VARIANT tmp = any
		
	VariantChangeTypeEx( @tmp, @lhs, NULL, VARIANT_NOVALUEPROP, VT_BSTR )

	function = *cast( wstring ptr, V_BSTR(@tmp) )
	
	VariantClear( @tmp )
	
end operator

'':::::
operator cast _
	( _
		byref lhs as VARIANT _
	) as wstring ptr
	
	dim as VARIANT tmp = any
		
	VariantChangeTypeEx( @tmp, @lhs, NULL, VARIANT_NOVALUEPROP, VT_BSTR )

	'' !!!FIXME!!! the pointer returned will leak

	function = V_BSTR(@tmp)
	
	''VariantClear( @tmp )
	
end operator

