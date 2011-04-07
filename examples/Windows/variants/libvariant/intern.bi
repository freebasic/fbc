'':::::
#macro VAR_GEN_CTOR( r_type, vt_type )
	constructor VARIANT _
		( _
			byval rhs as r_type _
		)
		
		VariantInit( @this.var_ )
	
		V_VT(@this.var_) = VT_##vt_type
		V_##vt_type(@this.var_) = rhs
		
	end constructor
#endmacro

'':::::
#macro VAR_GEN_ASSIGN( r_type, vt_type )
	operator VARIANT.let _
		( _
			byval rhs as r_type _
		)
		
		VariantClear( @this.var_ )
	
		V_VT(@this.var_) = VT_##vt_type
		V_##vt_type(@this.var_) = rhs
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_CAST( ret_type, vt_type )
	operator VARIANT.cast _
		( _
			_
		) as ret_type
		
		dim as VARIANT_ tmp = any
		
		VariantInit( @tmp )
		VariantChangeTypeEx( @tmp, @this.var_, NULL, VARIANT_NOVALUEPROP, VT_##vt_type )
		
		operator = V_##vt_type(@tmp)
		
		VariantClear( @tmp )
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_BOP( op, proc, r_type, vt_type )
	operator op _
		( _
			byref lhs as VARIANT, _
			byval rhs as r_type _
		) as VARIANT
		
		dim as VARIANT_ tmp = any, res = any
		
		VariantInit( @tmp )
		V_VT(@tmp) = VT_##vt_type
		V_##vt_type(@tmp) = rhs
		
		proc( @lhs.var_, @tmp, @res )
		
		return VARIANT( res, FALSE )
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_BOP_INV( op, proc, r_type, vt_type )
	operator op _
		( _
			byval lhs as r_type, _
			byref rhs as VARIANT _
		) as VARIANT
		
		dim as VARIANT_ tmp = any, res = any
		
		VariantInit( @tmp )
		V_VT(@tmp) = VT_##vt_type
		V_##vt_type(@tmp) = lhs
		
		proc( @tmp, @rhs.var_, @res )
		
		return VARIANT( res, FALSE )
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_SELFOP( op, proc, r_type, vt_type )
	operator VARIANT.##op _
		( _
			byval rhs as r_type _
		)
		
		dim as VARIANT_ tmp = any, res = any
		
		VariantInit( @tmp )
		V_VT(@tmp) = VT_##vt_type
		V_##vt_type(@tmp) = rhs
		
		proc( @this.var_, @tmp, @res )
		
		VariantClear( @this.var_ )
		this.var_ = res
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_COMP( op, r_type, vt_type )
	operator op _
		( _
			byref lhs as VARIANT, _
			byval rhs as r_type _
		) as integer
		
		dim as VARIANT_ tmp = any
		
		VariantInit( @tmp )
		V_VT(@tmp) = VT_##vt_type
		V_##vt_type(@tmp) = rhs
		
		operator = VarCmp( @lhs.var_, @tmp, NULL, 0 ) op VARCMP_EQ
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_COMP_INV( op, r_type, vt_type )
	operator op _
		( _
			byval lhs as r_type, _
			byref rhs as VARIANT _
		) as integer
		
		dim as VARIANT_ tmp = any
		
		VariantInit( @tmp )
		V_VT(@tmp) = VT_##vt_type
		V_##vt_type(@tmp) = lhs
		
		operator = VarCmp( @tmp, @rhs.var_, NULL, 0 ) op VARCMP_EQ
		
	end operator
#endmacro
