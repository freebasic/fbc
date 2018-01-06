/'
	fbcunit example

		- direct use of TEST() macro
		- test is added to default suite automatically
		- fbcu.run_tests will start the tests
'/

#include once "fbcunit.bi"

TEST( basic )
	'' 1 fail and 1 pass
	CU_ASSERT( false )
	CU_ASSERT( true )
END_TEST

fbcu.run_tests
