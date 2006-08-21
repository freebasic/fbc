

extern "c++"

	type baz
		as integer i
	end type
	
	namespace outer
		type foo
			as integer i
		end type
	
		namespace inner	
			type bar
				as integer i
			end type
		
			function sum( byval z as baz ptr, _
						  byval f1 as foo ptr, _
						  byval f2 as foo ptr, _
						  byval b as bar ptr) as integer
				
				return z->i + f1->i + f2->i + b->i
				
			end function
		end namespace
	end namespace


end extern

	dim as baz z = ( 1 )
	dim as outer.foo f1 = ( 1 ), f2 = ( 1 )
	dim as outer.inner.bar b = ( 1 )
	
	dim as integer res
	
	res = outer.inner.sum( @z, @f1, @f2, @b )
	
	CU_ASSERT( res = 4 )


