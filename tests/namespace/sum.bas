#include "fbcunit.bi"

extern "c++"

	type baz
		as integer i
	end type
	
	namespace module.ns.sum.outer
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

private sub test_proc
	dim as baz z = ( 1 )
	dim as module.ns.sum.outer.foo f1 = ( 1 ), f2 = ( 1 )
	dim as module.ns.sum.outer.inner.bar b = ( 1 )
	
	dim as integer res
	
	res = module.ns.sum.outer.inner.dosum( @z, @f1, @f2, @b )
	
	CU_ASSERT( res = 4 )
end sub

SUITE( fbc_tests.namespace_.sum )
	TEST( all )
		test_proc
	END_TEST
END_SUITE
