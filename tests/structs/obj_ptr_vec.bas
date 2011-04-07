
# include "fbcu.bi"

namespace fbc_tests.structs.obj_ptr_vec

	dim as integer dtor_cnt = 0

type abc
	declare destructor()
	member as integer
end type

destructor abc()
	dtor_cnt += 1
end destructor

sub test_1 cdecl	
	dim dummy as abc ptr = new abc[2]
	
	CU_ASSERT_EQUAL( dtor_cnt, 0 )
	
	delete[] dummy
	
	CU_ASSERT_EQUAL( dtor_cnt, 2 )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:obj-ptr-vec")
	fbcu.add_test( "1", @test_1)

end sub
	
end namespace	