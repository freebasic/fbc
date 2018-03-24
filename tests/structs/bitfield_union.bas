#include "fbcunit.bi"

SUITE( fbc_tests.structs.bitfield_union )

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

	TEST( test1 )
		CU_ASSERT_EQUAL( sizeof( foo ), sizeof( integer ) )
	END_TEST

	TEST( test2 )

		dim as foo f
		
		f.d = 0
		f.a = TEST_NUM_1

		CU_ASSERT_EQUAL( f.a, TEST_NUM_1 )
		CU_ASSERT_EQUAL( f.b, TEST_NUM_1 )
		CU_ASSERT_EQUAL( f.c, TEST_NUM_1 )
		CU_ASSERT_EQUAL( f.d, TEST_NUM_1 )

	END_TEST

	TEST( test3 )

		dim as foo f
		
		f.d = 0
		f.b = TEST_NUM_9

		CU_ASSERT_EQUAL( f.a, TEST_NUM_1 )
		CU_ASSERT_EQUAL( f.b, TEST_NUM_9 )
		CU_ASSERT_EQUAL( f.c, TEST_NUM_9 )
		CU_ASSERT_EQUAL( f.d, TEST_NUM_9 )

	END_TEST

	TEST( test4 )

		dim as foo f
		
		f.d = 0
		f.c = TEST_NUM_17

		CU_ASSERT_EQUAL( f.a, TEST_NUM_1 )
		CU_ASSERT_EQUAL( f.b, TEST_NUM_1 )
		CU_ASSERT_EQUAL( f.c, TEST_NUM_17 )
		CU_ASSERT_EQUAL( f.d, TEST_NUM_17 )

	END_TEST

	TEST( test5 )
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

	END_TEST

END_SUITE
