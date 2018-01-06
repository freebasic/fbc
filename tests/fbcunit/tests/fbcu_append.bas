#include once "fbcunit.bi"

'' append multiple tests to a single suite

SUITE( append_ )
	TEST( first )
		CU_ASSERT( true )
	END_TEST
END_SUITE

SUITE( append_ )
	TEST( third )
		CU_ASSERT( true )
	END_TEST
END_SUITE

