#include "fbcunit.bi"

SUITE( fbc_tests.string_.array_len )

	dim shared as string foo()  

	TEST( test1 )
		CU_ASSERT_EQUAL( len(foo), len(string) )
	END_TEST

END_SUITE
