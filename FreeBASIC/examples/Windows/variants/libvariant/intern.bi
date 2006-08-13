
'':::::
#macro VAR_GEN_ASSIGN( r_type, vt_type )
	operator let _
		( _
			byref lhs as VARIANT, _
			byval rhs as r_type _
		)
		
		VariantClear( @lhs )
	
		V_VT(@lhs) = VT_##vt_type
		V_##vt_type(@lhs) = rhs
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_CAST( ret_type, vt_type )
	operator cast _
		( _
			byref lhs as VARIANT _
		) as ret_type
		
		dim as VARIANT tmp = any
		
		VariantChangeTypeEx( @tmp, @lhs, NULL, VARIANT_NOVALUEPROP, VT_##vt_type )
		
		function = V_##vt_type(@tmp)
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_BOP( op, proc, r_type, vt_type )
	operator op _
		( _
			byref lhs as VARIANT, _
			byval rhs as r_type _
		) as VARIANT
		
		dim as VARIANT tmp = any, res = any
		
		VariantInit( @tmp )
		V_VT(@tmp) = VT_##vt_type
		V_##vt_type(@tmp) = rhs
		
		proc( @lhs, @tmp, @res )
		
		operator = res
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_SELFOP( op, proc, r_type, vt_type )
	operator op _
		( _
			byref lhs as VARIANT, _
			byval rhs as r_type _
		)
		
		dim as VARIANT tmp = any, res = any
		
		VariantInit( @tmp )
		V_VT(@tmp) = VT_##vt_type
		V_##vt_type(@tmp) = rhs
		
		proc( @lhs, @tmp, @res )
		
		VariantClear( @lhs )
		VariantCopy( @lhs, @res )
		
	end operator
#endmacro

'':::::
#macro VAR_GEN_COMP( op, r_type, vt_type )
	operator op _
		( _
			byref lhs as VARIANT, _
			byval rhs as r_type _
		) as integer
		
		dim as VARIANT tmp = any
		
		VariantInit( @tmp )
		V_VT(@tmp) = VT_##vt_type
		V_##vt_type(@tmp) = rhs
		
		operator = VarCmp( @lhs, @tmp, NULL, 0 ) op VARCMP_EQ
		
	end operator
#endmacro
