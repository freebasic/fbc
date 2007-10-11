# include "fbcu.bi"

namespace fbc_tests.structs.obj_field_ini_str

type A
	as string i = "123", j = "abcde", k = wstr( "fOoBaR" )
end type

type B
	c as A
end type

sub test_1 cdecl	
	
	dim x as B
	
	CU_ASSERT_EQUAL( x.c.i, "123" )
	CU_ASSERT_EQUAL( x.c.j, "abcde" )
	CU_ASSERT_EQUAL( x.c.k, "fOoBaR" )

end sub
	
private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:obj-field_ini-str")
	fbcu.add_test( "#1", @test_1)

end sub
	
end namespace	