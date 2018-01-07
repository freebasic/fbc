/'
	fbcunit example

		- direct use of CU_ASSERT() macro
		- failed assertions will be displayed immediately
		- fbcu.run_tests not needed
		- fbcu.show_results optional
'/

#include once "fbcunit.bi"

'' simulate 3 passes and 2 fails

for i as integer = 1 to 5
	CU_ASSERT( i mod 2 = 1 )
next i

fbcu.show_results
