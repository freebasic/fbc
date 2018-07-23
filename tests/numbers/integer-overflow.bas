#include "fbcunit.bi"

SUITE( fbc_tests.numbers.integer_overflow )

	TEST( signed_ )
		'' int32
		scope
			const IMIN as long = -&h7FFFFFFF - 1
			const IMAX as long =  &h7FFFFFFF
			dim i as long

			i = IMAX
			CU_ASSERT( i = IMAX )
			CU_ASSERT( i > 0 )
			CU_ASSERT( IMAX > 0 )
			CU_ASSERT( clng(i + 1) = IMIN )
			CU_ASSERT( clng(i + 1) < 0 )
			CU_ASSERT( clng(IMAX + 1) = IMIN )
			CU_ASSERT( clng(IMAX + 1) < 0 )
			#ifndef __FB_64BIT__
				CU_ASSERT( (i + 1) = IMIN )
				CU_ASSERT( (i + 1) < 0 )
				CU_ASSERT( (IMAX + 1) = IMIN )
				CU_ASSERT( (IMAX + 1) < 0 )
			#endif

			i = IMIN
			CU_ASSERT( i = IMIN )
			CU_ASSERT( i < 0 )
			CU_ASSERT( IMIN < 0 )
			CU_ASSERT( clng(i - 1) = IMAX )
			CU_ASSERT( clng(i - 1) > 0 )
			CU_ASSERT( clng(IMIN - 1) = IMAX )
			CU_ASSERT( clng(IMIN - 1) > 0 )
			#ifndef __FB_64BIT__
				CU_ASSERT( (i - 1) = IMAX )
				CU_ASSERT( (i - 1) > 0 )
				CU_ASSERT( (IMIN - 1) = IMAX )
				CU_ASSERT( (IMIN - 1) > 0 )
			#endif
		end scope

		'' int64
		scope
			const IMIN as longint = -&h7FFFFFFFFFFFFFFFll - 1
			const IMAX as longint =  &h7FFFFFFFFFFFFFFFll
			dim i as longint

			i = IMAX
			CU_ASSERT( i = IMAX )
			CU_ASSERT( i > 0 )
			CU_ASSERT( (i + 1) = IMIN )
			CU_ASSERT( (i + 1) < 0 )
			CU_ASSERT( IMAX > 0 )
			CU_ASSERT( (IMAX + 1) = IMIN )
			CU_ASSERT( (IMAX + 1) < 0 )

			i = IMIN
			CU_ASSERT( i = IMIN )
			CU_ASSERT( i < 0 )
			CU_ASSERT( (i - 1) = IMAX )
			CU_ASSERT( (i - 1) > 0 )
			CU_ASSERT( IMIN < 0 )
			CU_ASSERT( (IMIN - 1) = IMAX )
			CU_ASSERT( (IMIN - 1) > 0 )
		end scope
	END_TEST

	TEST( unsigned_ )
		'' int32
		scope
			const IMAX as ulong = &hFFFFFFFFu
			dim i as ulong

			i = IMAX
			CU_ASSERT( i = IMAX )
			CU_ASSERT( culng(i + 1) = 0 )
			CU_ASSERT( culng(IMAX + 1) = 0 )
			#ifndef __FB_64BIT__
				CU_ASSERT( (i + 1) = 0 )
				CU_ASSERT( (IMAX + 1) = 0 )
			#endif

			i = 0
			CU_ASSERT( i = 0 )
			CU_ASSERT( culng(i - 1) = IMAX )
			CU_ASSERT( culng(0u - 1) = IMAX )
			#ifndef __FB_64BIT__
				CU_ASSERT( (i - 1) = IMAX )
				CU_ASSERT( (0u - 1) = IMAX )
			#endif
		end scope

		'' int64
		scope
			const IMAX as ulongint = &hFFFFFFFFFFFFFFFFull
			dim i as ulongint

			i = IMAX
			CU_ASSERT( i = IMAX )
			CU_ASSERT( (i + 1) = 0 )
			CU_ASSERT( (IMAX + 1) = 0 )

			i = 0
			CU_ASSERT( i = 0 )
			CU_ASSERT( (i - 1) = IMAX )
			CU_ASSERT( (0ull - 1) = IMAX )
		end scope
	END_TEST

END_SUITE
