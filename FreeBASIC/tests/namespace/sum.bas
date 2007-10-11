# include "fbcu.bi"

extern "c++"

	type baz
		as integer i
	end type
	
	namespace fbc_tests.ns.sum.outer
		type foo
			as integer i
		end type
	
		namespace inner	
			type bar
				as integer i
			end type
		
			function dosum( byval z as baz ptr, _
						  	byval f1 as foo ptr, _
						  	byval f2 as foo ptr, _
						  	byval b as bar ptr) as integer
				
				return z->i + f1->i + f2->i + b->i
				
			end function
		end namespace
	end namespace


end extern

private sub test cdecl
	dim as baz z = ( 1 )
	dim as fbc_tests.ns.sum.outer.foo f1 = ( 1 ), f2 = ( 1 )
	dim as fbc_tests.ns.sum.outer.inner.bar b = ( 1 )
	
	dim as integer res
	
	res = fbc_tests.ns.sum.outer.inner.dosum( @z, @f1, @f2, @b )
	
	CU_ASSERT( res = 4 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.sum")
	fbcu.add_test("test", @test)
	
end sub

