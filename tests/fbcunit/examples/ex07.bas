/'
	fbcunit example #7 -- ex07.bas

		- usage in -lang qb
		- SUITE_INIT & SUITE_CLEANUP need to set
		  the return value
		- !!! currently, fbcunit does not check
		  return value of init/cleanup procs
'/

'$lang: "qb"

option explicit
'$include: "fbcunit.bi"

const false = 0, true = not false

SUITE( qb_example )

	SUITE_INIT
		'' return success
		tests.qb_example.init = 0
	END_SUITE_INIT

	SUITE_CLEANUP
		'' return success
		tests.qb_example.cleanup = 0
	END_SUITE_CLEANUP

	TEST( always_true )
		CU_ASSERT( true )
	END_TEST

END_SUITE

fbcu.run_tests
