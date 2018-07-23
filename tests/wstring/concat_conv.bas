#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.concat_conv )

	const TESTVALUE_1 = "abcd"
	const TESTVALUE_2 = "EFGH"

	TEST( default )

		dim as wstring * 32 w = TESTVALUE_1
		dim as zstring * 32 z = TESTVALUE_2
		dim as wstring * 256 res
		
		res = w + z
		
		CU_ASSERT( res = wstr(TESTVALUE_1) + wstr(TESTVALUE_2) )
		
		res = z + w
		
		CU_ASSERT( res = wstr(TESTVALUE_2) + wstr(TESTVALUE_1) )

	END_TEST

END_SUITE
