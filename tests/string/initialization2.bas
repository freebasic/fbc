#include "fbcunit.bi"

SUITE( fbc_tests.string_.initialization2 )

	TEST( test1 )

		dim as string a = "abc"
		dim as string b = a
		dim as string c = a + b
		
		CU_ASSERT_EQUAL( b, "abc" )
		CU_ASSERT_EQUAL( c, "abcabc" )

	END_TEST

END_SUITE
