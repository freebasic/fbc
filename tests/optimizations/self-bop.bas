#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.self_bop )

	dim shared i as integer

	TEST( all )
		i = i + 1
		CU_ASSERT( i = 1 )

		'' The self-bop optimization should still work when it has to deal with
		'' noconv casts
		#ifdef __FB_64BIT__
			i = clngint(i + 1)
		#else
			i = clng(i + 1)
		#endif
		CU_ASSERT( i = 2 )

		i = cuint(i + 1)
		CU_ASSERT( i = 3 )

		cuint(i) = i + 1
		CU_ASSERT( i = 4 )

		#ifdef __FB_64BIT__
			clngint(i) = i + 1
		#else
			clng(i) = i + 1
		#endif
		CU_ASSERT( i = 5 )

		i = cuint(i) + 1
		CU_ASSERT( i = 6 )

		'' Real conversions that matter shouldn't be ignored though
		i = 255
		i = cbyte( i + 1 )
		CU_ASSERT( i = 0 )

		i = 255
		i = cubyte( i + 1 )
		CU_ASSERT( i = 0 )

		i = 256
		i = cbyte( i + 1 )
		CU_ASSERT( i = 1 )

		i = 256
		i = cbyte( i ) + 1
		CU_ASSERT( i = 1 )
	END_TEST

END_SUITE
