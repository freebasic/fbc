#include "fbcunit.bi"
#include "fbc-int/math.bi"

#ifndef NULL
#define NULL 0
#endif

'' tests for random number generator internals

SUITE( fbc_tests.fbc_int.math_rnd )

	TEST( direct )

		fbc.randomize 1, FBC.FB_RND_FAST

		CU_ASSERT_EQUAL( fbc.rnd32(), 1015568748 )
		CU_ASSERT_EQUAL( fbc.rnd32(), 1586005467 )
		CU_ASSERT_EQUAL( fbc.rnd32(), 2165703038 )
		CU_ASSERT_EQUAL( fbc.rnd32(), 3027450565 )
		CU_ASSERT_EQUAL( fbc.rnd32(), 217083232 )
		
		dim info as FBC.FB_RNDINTERNALS
		fbc.rndGetInternals( @info )

		CU_ASSERT( info.algorithm = FBC.FB_RND_FAST )
		CU_ASSERT( info.rndproc <> NULL )
		CU_ASSERT( info.rndproc32 <> NULL )

	END_TEST

	TEST( using_fbc )
	
		'' essentially, a compile test only
		using fbc

		randomize
		randomize , FB_RND_MTWIST

		var x = rnd
		var y = rnd32

		dim info as FB_RNDINTERNALS
		rndGetInternals( @info )

		CU_PASS()
		
	END_TEST

END_SUITE
