#include once "fbcunit.bi"

'' append multiple tests to a single suite

SUITE( append_ )
	TEST( second )
		CU_ASSERT( true )
	END_TEST
END_SUITE
