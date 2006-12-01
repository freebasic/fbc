
# include "fbcu.bi"

namespace fbc_tests.structs.obj_ptr3

type foo
	as integer pad = any
	declare destructor( )
end type

destructor foo()
	CU_ASSERT_EQUAL( @this, NULL )
	CU_FAIL( "destructor called" )
end destructor

sub test_1 cdecl	
	dim as foo ptr pf = NULL
	
	CU_ASSERT_EQUAL( pf, NULL )
	
	delete[] pf
end sub
	
sub test_2 cdecl	
	dim as foo ptr pf(0) = { NULL}
	
	CU_ASSERT_EQUAL( pf(0), NULL )
	
	delete pf(0)
end sub
	
private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:obj-ptr3")
	fbcu.add_test( "1", @test_1)
	fbcu.add_test( "2", @test_2)

end sub
	
end namespace