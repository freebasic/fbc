# include "fbcu.bi"



namespace fbc_tests.structs.assign_anon

type t
	a as short
	b as integer
	c(0 to 1) as single
	d as double
end type

sub test_1 cdecl ()
	dim as t udt = (1, 2, {3, 4}, 5 ) 
	
	CU_ASSERT_EQUAL( udt.a, 1 )
	CU_ASSERT_EQUAL( udt.b, 2 )
	CU_ASSERT_EQUAL( udt.c(0), 3 )
	CU_ASSERT_EQUAL( udt.c(1), 4 )
	CU_ASSERT_EQUAL( udt.d, 5 )
end sub

sub test_2 cdecl ()
	static as t udt = (1, 2, {3, 4}, 5 ) 
	
	CU_ASSERT_EQUAL( udt.a, 1 )
	CU_ASSERT_EQUAL( udt.b, 2 )
	CU_ASSERT_EQUAL( udt.c(0), 3 )
	CU_ASSERT_EQUAL( udt.c(1), 4 )
	CU_ASSERT_EQUAL( udt.d, 5 )
end sub

sub test_3 cdecl ()
	dim as t udt
	
	udt = type( -1, -2, {-3, -4}, -5 )

	CU_ASSERT_EQUAL( udt.a, -1 )
	CU_ASSERT_EQUAL( udt.b, -2 )
	CU_ASSERT_EQUAL( udt.c(0), -3 )
	CU_ASSERT_EQUAL( udt.c(1), -4 )
	CU_ASSERT_EQUAL( udt.d, -5 )	
end sub

sub test_4  cdecl ()
	static as t udt
	
	udt = type( -1, -2, {-3, -4}, -5 )

	CU_ASSERT_EQUAL( udt.a, -1 )
	CU_ASSERT_EQUAL( udt.b, -2 )
	CU_ASSERT_EQUAL( udt.c(0), -3 )
	CU_ASSERT_EQUAL( udt.c(1), -4 )
	CU_ASSERT_EQUAL( udt.d, -5 )	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.assign_anon")
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("test_2", @test_2)
	fbcu.add_test("test_3", @test_3)
	fbcu.add_test("test_4", @test_4)

end sub

end namespace
