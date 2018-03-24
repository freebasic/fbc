#include "fbcunit.bi"

SUITE( fbc_tests.pp.assert_ )

	TEST( all )
		dim as integer i = 0
		dim as string s

		#assert 1

		#assert 1 <> 2

		#assert 1 = 5 - (((4 * 2) + 8) / 4)

		#assert (1 + 2 + 3) = 6

		#assert (1 + (2 * 3)) = 7

		#assert (1 + 2 + 3 - 4) = 2

		CU_ASSERT( (1/2) > .49 )
		#assert (1/2) > .49

		#assert (10\5) = 2

		CU_ASSERT( &hFFFFFFFFu > 0 )
		#assert &hFFFFFFFFu > 0

		CU_ASSERT( &hFFFFFFFFu > 0u )
		#assert &hFFFFFFFFu > 0u

		CU_ASSERT( &hFFFFFFFFFFFFFFFFull > 0 )
		#assert &hFFFFFFFFFFFFFFFFull > 0

		CU_ASSERT( &hFFFFFFFFFFFFFFFFull > 0u )
		#assert &hFFFFFFFFFFFFFFFFull > 0u

		CU_ASSERT( &hFFFFFFFFFFFFFFFFull > 0ull )
		#assert &hFFFFFFFFFFFFFFFFull > 0ull

		#assert "a" + "b" = "ab"

		const N1 = 123
		#assert N1 = 123

		const S1 = "abc"
		#assert "abc" = S1

		#assert undeclaredid = undeclaredid

		#assert undeclaredid = UNDECLAREDID

		#assert UNDECLAREDID = undeclaredid

		#assert undeclaredid1 <> undeclaredid2

		'' constant
		#assert defined( N1 )

		#assert defined( N1 ) = -1

		#assert -1 = defined( N1 )

		'' variable
		#assert defined( i )

		'' procedure
		#assert defined( test )

		'' The #assert directive should be accepted inside #if 0 blocks.
		'' (it shouldn't be evaluated there though)
		#if 0
			#assert 1
			#assert 0
		#endif
	END_TEST

END_SUITE
