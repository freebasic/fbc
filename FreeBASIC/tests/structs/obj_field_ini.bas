# include "fbcu.bi"

namespace fbc_tests.structs.obj_field_ini

type A
	as integer i, j, k
end type

type B
	c as A = (1, 2, 3)
end type


sub test cdecl	
	
	dim x as B
	
	CU_ASSERT_EQUAL( x.c.i, 1 )
	CU_ASSERT_EQUAL( x.c.j, 2 )
	CU_ASSERT_EQUAL( x.c.k, 3 )

end sub
	
private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:obj-field_ini")
	fbcu.add_test( "test", @test)

end sub
	
end namespace	