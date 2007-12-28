

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_COMP_INV( <>, integer, I4 )
VAR_GEN_COMP_INV( <>, uinteger, UI4 )
VAR_GEN_COMP_INV( <>, longint, I8 )
VAR_GEN_COMP_INV( <>, ulongint, UI8 )
VAR_GEN_COMP_INV( <>, single, R4 )
VAR_GEN_COMP_INV( <>, double, R8 )

'':::::
operator <> _
	( _
		byref lhs as VARIANT_, _
		byref rhs as VARIANT _
	) as integer
	
	operator = VarCmp( @lhs, @rhs.var_, NULL, 0 ) <> VARCMP_EQ
	
end operator

'':::::
operator <> _
	( _
		byval lhs as zstring ptr, _
		byref rhs as VARIANT _
	) as integer
	
	dim as VARIANT_ tmp = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringByteLen( lhs, len( *lhs ) )
	
	operator = VarCmp( @tmp, @rhs.var_, NULL, 0 ) <> VARCMP_EQ
	
	VariantClear( @tmp )
	
end operator

'':::::
operator <> _
	( _
		byval lhs as wstring ptr, _
		byref rhs as VARIANT _
	) as integer
	
	dim as VARIANT_ tmp = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringLen( lhs, len( *lhs ) )
	
	operator = VarCmp( @tmp, @rhs.var_, NULL, 0 ) <> VARCMP_EQ
	
	VariantClear( @tmp )
	
end operator

