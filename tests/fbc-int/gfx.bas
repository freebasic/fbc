#include "fbcunit.bi"
#include "fbc-int/gfx.bi"

'' tests for gfx library internals

SUITE( fbc_tests.fbc_int.gfx )

	TEST( structure )

		#ifdef __FB_64BIT__
			CU_ASSERT_EQUAL( sizeof( fbgfxlib.FB_GFXCTX ), 216 )
		#else
			CU_ASSERT_EQUAL( sizeof( fbgfxlib.FB_GFXCTX ), 148 )
		#endif

	END_TEST

END_SUITE
