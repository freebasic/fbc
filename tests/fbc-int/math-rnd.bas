#include "fbcunit.bi"
#include "fbprng.bi"
#include "fbc-int/math.bi"

#ifndef NULL
#define NULL 0
#endif

'' tests for random number generator internals

SUITE( fbc_tests.fbc_int.math_rnd )

	TEST( direct )

		fbc.randomize 1, FB.FB_RND_FAST

		CU_ASSERT_EQUAL( fbc.rnd32(), 1015568748 )
		CU_ASSERT_EQUAL( fbc.rnd32(), 1586005467 )
		CU_ASSERT_EQUAL( fbc.rnd32(), 2165703038 )
		CU_ASSERT_EQUAL( fbc.rnd32(), 3027450565 )
		CU_ASSERT_EQUAL( fbc.rnd32(), 217083232 )

		dim info as FBC.FB_RNDSTATE ptr
		info = fbc.rndGetState( )

		CU_ASSERT( info->algorithm = FB.FB_RND_FAST )
		CU_ASSERT( info->rndproc <> NULL )
		CU_ASSERT( info->rndproc32 <> NULL )

	END_TEST

	TEST( using_fbc )

		using fbc

		randomize
		randomize , FB.FB_RND_MTWIST
		var x = rnd
		var y = rnd32

		dim info as FB_RNDSTATE ptr
		info = rndGetState( )

		CU_ASSERT( info->algorithm = FB.FB_RND_MTWIST )
		CU_ASSERT( info->length = FB_RND_MAX_STATE )
		CU_ASSERT( info->rndproc <> NULL )
		CU_ASSERT( info->rndproc32 <> NULL )

	END_TEST

	TEST( using_fb )

		using fb

		CU_ASSERT( FB_RND_AUTO   = 0 )
		CU_ASSERT( FB_RND_CRT    = 1 )
		CU_ASSERT( FB_RND_FAST   = 2 )
		CU_ASSERT( FB_RND_MTWIST = 3 )
		CU_ASSERT( FB_RND_QB     = 4 )
		CU_ASSERT( FB_RND_REAL   = 5 )

	END_TEST

END_SUITE
