#include "fbcunit.bi"

SUITE( fbc_tests.numbers.cast_ll2f )

	const c as longint = 1ll shl 32

	TEST( cast_ull )

		dim as ulongint n = 1ull
		dim as double x = 1.0

		for i as integer = 0 to 63

			cu_assert_equal( cdbl(n), x )
			if n <= not c then
				cu_assert_equal( cdbl(n + c), x + c )
			end if
			if n >= c then
				cu_assert_equal( cdbl(n - c), x - c )
			end if
			if( i <= 52) then
				cu_assert_equal( cdbl(n + 1), x + 1.0 )
				cu_assert_equal( cdbl(n - 1), x - 1.0 )
			end if

			n shl= 1: x *= 2.0

		next

	END_TEST

	TEST( cast_ll )

		dim as longint n = 1ll
		dim as double x = 1.0

		for i as integer = 0 to 62

			cu_assert_equal( cdbl(n), x )
			cu_assert_equal( cdbl(n + c), x + c )
			cu_assert_equal( cdbl(n - c), x - c )

			cu_assert_equal( cdbl(-n), -x )
			cu_assert_equal( cdbl(-n + c), -x + c )
			cu_assert_equal( cdbl(-n - c), -x - c )

			if( i <= 52) then
				cu_assert_equal( cdbl(n + 1), x + 1.0 )
				cu_assert_equal( cdbl(n - 1), x - 1.0 )
				cu_assert_equal( cdbl(-n + 1), -x + 1.0 )
				cu_assert_equal( cdbl(-n - 1), -x - 1.0 )
			end if

			n shl= 1: x *= 2.0

		next

		cu_assert_equal( cdbl(n), -n )

	END_TEST

END_SUITE
