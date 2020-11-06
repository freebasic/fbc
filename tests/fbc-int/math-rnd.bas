#include "fbcunit.bi"
#include "fbmath.bi"
#include "fbc-int/math.bi"

#ifndef NULL
#define NULL 0
#endif

'' tests for random number generator internals

SUITE( fbc_tests.fbc_int.math_rnd )

	TEST( direct )

		fb.randomize 1, FB.FB_RND_FAST

		CU_ASSERT_EQUAL( fb.rnd32(), 1015568748 )
		CU_ASSERT_EQUAL( fb.rnd32(), 1586005467 )
		CU_ASSERT_EQUAL( fb.rnd32(), 2165703038 )
		CU_ASSERT_EQUAL( fb.rnd32(), 3027450565 )
		CU_ASSERT_EQUAL( fb.rnd32(), 217083232 )
		
		dim info as FBC.FB_RNDSTATE ptr
		info = fbc.rndGetState( )

		CU_ASSERT( info->algorithm = FB.FB_RND_FAST )
		CU_ASSERT( info->rndproc <> NULL )
		CU_ASSERT( info->rndproc32 <> NULL )

	END_TEST

	TEST( using_fbc )
	
		using fbc

		fb.randomize
		fb.randomize , FB.FB_RND_MTWIST

		dim info as FB_RNDSTATE ptr
		info = rndGetState( )

		CU_ASSERT( info->algorithm = FB.FB_RND_MTWIST )
		CU_ASSERT( info->length = FB_RND_MAX_STATE )
		CU_ASSERT( info->rndproc <> NULL )
		CU_ASSERT( info->rndproc32 <> NULL )
		
	END_TEST

	TEST( using_fb )
		'' essentially, a compile test only

		using fb

		randomize
		randomize , FB.FB_RND_MTWIST

		var x = rnd
		var y = rnd32

		CU_PASS()

	END_TEST

END_SUITE
