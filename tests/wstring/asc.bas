#include "fbcunit.bi"

SUITE( fbc_tests.wstrings.asc_ )

	const TEST_A = asc( wstr( "abc" ), 1 )
	const TEST_B = asc( wstr( "abc" ), 2 )
	const TEST_C = asc( wstr( "abc" ), 3 )
	const TEST_D = asc( wstr( "abc" ), 4 )

	TEST( default )

		CU_ASSERT( TEST_A = asc( wstr( "a" ) ) )
		
		CU_ASSERT( TEST_B = asc( wstr( "b" ) ) )
		
		CU_ASSERT( TEST_C = asc( wstr( "c" ) ) )
		
		CU_ASSERT( TEST_D = 0 )
		
	END_TEST

END_SUITE
