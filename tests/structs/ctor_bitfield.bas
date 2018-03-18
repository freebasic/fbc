#include "fbcunit.bi"

SUITE( fbc_tests.structs.ctor_bitfield )

	const TEST_F1 = 11
	const TEST_F2 = 22
	const TEST_F3 = 33
	const TEST_F4 = 44

	type foo
		f1:8 as integer = TEST_F1
		f2:8 as integer = TEST_F2
		f3:8 as integer = TEST_F3
		f4:8 as integer = TEST_F4
	end type

		
	TEST( all )
		dim f as foo
		
		CU_ASSERT_EQUAL( f.f1, TEST_F1 )
		CU_ASSERT_EQUAL( f.f2, TEST_F2 )
		CU_ASSERT_EQUAL( f.f3, TEST_F3 )
		CU_ASSERT_EQUAL( f.f4, TEST_F4 )
		
	END_TEST

END_SUITE
