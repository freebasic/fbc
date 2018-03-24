#include "fbcunit.bi"

SUITE( fbc_tests.numbers.hexliteral )

	TEST( all )

		dim as ulongint lint

		lint = ((&hffffffff00000000ull shr 32) And &hffffffffll) 

		CU_ASSERT_EQUAL( lint, 4294967295ll )

	END_TEST

END_SUITE
