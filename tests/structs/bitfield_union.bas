# include "fbcu.bi"

 

namespace fbc_tests.structs.bitfield_union

const TEST_NUM_1 = &b1
const TEST_NUM_9 = &b100000001
const TEST_NUM_17 = &b10000000000000001
	
union foo field=1 
	as short                a:1
	as short                b:9
	as integer              c:17
	as integer				d
end union 

type bar field=1
	as uinteger		a:1
	union
		as uinteger	b:1
		as uinteger	c:1
	end union
	as uinteger		d:1
end type

sub test_0 cdecl ()
	CU_ASSERT_EQUAL( sizeof( foo ), sizeof( integer ) )
end sub

sub test_1 cdecl ()

	dim as foo f
	
	f.d = 0
	f.a = TEST_NUM_1

	CU_ASSERT_EQUAL( f.a, TEST_NUM_1 )
	CU_ASSERT_EQUAL( f.b, TEST_NUM_1 )
	CU_ASSERT_EQUAL( f.c, TEST_NUM_1 )
	CU_ASSERT_EQUAL( f.d, TEST_NUM_1 )

end sub

sub test_2 cdecl ()

	dim as foo f
	
	f.d = 0
	f.b = TEST_NUM_9

	CU_ASSERT_EQUAL( f.a, TEST_NUM_1 )
	CU_ASSERT_EQUAL( f.b, TEST_NUM_9 )
	CU_ASSERT_EQUAL( f.c, TEST_NUM_9 )
	CU_ASSERT_EQUAL( f.d, TEST_NUM_9 )

end sub

sub test_3 cdecl ()

	dim as foo f
	
	f.d = 0
	f.c = TEST_NUM_17

	CU_ASSERT_EQUAL( f.a, TEST_NUM_1 )
	CU_ASSERT_EQUAL( f.b, TEST_NUM_1 )
	CU_ASSERT_EQUAL( f.c, TEST_NUM_17 )
	CU_ASSERT_EQUAL( f.d, TEST_NUM_17 )

end sub

sub test_4 cdecl ()
	dim as bar f
	dim as integer ptr i
	i = cast(integer ptr, @f)

	CU_ASSERT_EQUAL( sizeof( bar ), sizeof( integer ) * 3 )

	CU_ASSERT_EQUAL( *i, 0 )

	CU_ASSERT_EQUAL( f.a, 0 )
	CU_ASSERT_EQUAL( f.b, 0 )
	CU_ASSERT_EQUAL( f.c, 0 )
	CU_ASSERT_EQUAL( f.d, 0 )

	CU_ASSERT_EQUAL(  *(i+0), 0 )
	CU_ASSERT_EQUAL(  *(i+1), 0 )
	CU_ASSERT_EQUAL(  *(i+2), 0 )

	f.a = 1

	CU_ASSERT_EQUAL( f.a, 1 )
	CU_ASSERT_EQUAL( f.b, 0 )
	CU_ASSERT_EQUAL( f.c, 0 )
	CU_ASSERT_EQUAL( f.d, 0 )

	CU_ASSERT_EQUAL(  *(i+0), 1 )
	CU_ASSERT_EQUAL(  *(i+1), 0 )
	CU_ASSERT_EQUAL(  *(i+2), 0 )

	f.b = 1

	CU_ASSERT_EQUAL( f.a, 1 )
	CU_ASSERT_EQUAL( f.b, 1 )
	CU_ASSERT_EQUAL( f.c, 1 )
	CU_ASSERT_EQUAL( f.d, 0 )

	CU_ASSERT_EQUAL(  *(i+0), 1 )
	CU_ASSERT_EQUAL(  *(i+1), 1 )
	CU_ASSERT_EQUAL(  *(i+2), 0 )

	f.c = 0

	CU_ASSERT_EQUAL( f.a, 1 )
	CU_ASSERT_EQUAL( f.b, 0 )
	CU_ASSERT_EQUAL( f.c, 0 )
	CU_ASSERT_EQUAL( f.d, 0 )

	CU_ASSERT_EQUAL(  *(i+0), 1 )
	CU_ASSERT_EQUAL(  *(i+1), 0 )
	CU_ASSERT_EQUAL(  *(i+2), 0 )

	f.d = 1

	CU_ASSERT_EQUAL( f.a, 1 )
	CU_ASSERT_EQUAL( f.b, 0 )
	CU_ASSERT_EQUAL( f.c, 0 )
	CU_ASSERT_EQUAL( f.d, 1 )

	CU_ASSERT_EQUAL(  *(i+0), 1 )
	CU_ASSERT_EQUAL(  *(i+1), 0 )
	CU_ASSERT_EQUAL(  *(i+2), 1 )

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.bitfield_union")
	fbcu.add_test("test_0", @test_0)
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("test_2", @test_2)
	fbcu.add_test("test_3", @test_3)
	fbcu.add_test("test_4", @test_4)

end sub

end namespace
