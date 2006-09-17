'':::::
#macro VAR_GEN_CTOR( r_type, vt_type )
	constructor CVariant _
		( _
			byval rhs as r_type _
		)
		
		VariantInit( @this.var )
	
		V_VT(@this.var) = VT_##vt_type
		V_##vt_type(@this.var) = rhs
		
	end constructor
#endmacro

'':::::
#macro VAR_GEN_ASSIGN( r_type, vt_type )
	operator CVariant.let _
		( _
			byval rhs as r_type _
		)
		
		VariantClear( @this.var )
	
		V_VT(@this.var) = VT_##vt_type
		V_##vt_type(@this.var) = rhs
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_CAST( ret_type, vt_type )
	operator CVariant.cast _
		( _
			_
		) as ret_type
		
		dim as VARIANT tmp = any
		
		VariantInit( @tmp )
		VariantChangeTypeEx( @tmp, @this.var, NULL, VARIANT_NOVALUEPROP, VT_##vt_type )
		
		operator = V_##vt_type(@tmp)
		
		VariantClear( @tmp )
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_BOP( op, proc, r_type, vt_type )
	operator op _
		( _
			byref lhs as CVariant, _
			byval rhs as r_type _
		) as CVariant
		
		dim as VARIANT tmp = any, res = any
		
		VariantInit( @tmp )
		V_VT(@tmp) = VT_##vt_type
		V_##vt_type(@tmp) = rhs
		
		proc( @lhs.var, @tmp, @res )
		
		return CVariant( res, FALSE )
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_SELFOP( op, proc, r_type, vt_type )
	operator CVariant.##op _
		( _
			byval rhs as r_type _
		)
		
		dim as VARIANT tmp = any, res = any
		
		VariantInit( @tmp )
		V_VT(@tmp) = VT_##vt_type
		V_##vt_type(@tmp) = rhs
		
		proc( @this.var, @tmp, @res )
		
		VariantClear( @this.var )
		this.var = res
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_COMP( op, r_type, vt_type )
	operator op _
		( _
			byref lhs as CVariant, _
			byval rhs as r_type _
		) as integer
		
		dim as VARIANT tmp = any
		
		VariantInit( @tmp )
		V_VT(@tmp) = VT_##vt_type
		V_##vt_type(@tmp) = rhs
		
		operator = VarCmp( @lhs.var, @tmp, NULL, 0 ) op VARCMP_EQ
		
	end operator
#endmacro
