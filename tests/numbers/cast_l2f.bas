#include "fbcunit.bi"

SUITE( fbc_tests.numbers.cast_l2f )

	const c as longint = 1l shl 16

	TEST( cast_ul )

		dim as ulong n = 1ul
		dim as double x = 1.0

		for i as integer = 0 to 31

			cu_assert_equal( cdbl(n), x )
			if n <= not c then
				cu_assert_equal( cdbl(n + c), x + c )
			end if
			if n >= c then
				cu_assert_equal( cdbl(n - c), x - c )
			end if

			cu_assert_equal( cdbl(n + 1), x + 1.0 )
			cu_assert_equal( cdbl(n - 1), x - 1.0 )

			n shl= 1: x *= 2.0

		next

	END_TEST

	TEST( cast_l )

		dim as long n = 1l
		dim as double x = 1.0

		for i as integer = 0 to 30

			cu_assert_equal( cdbl(n), x )
			cu_assert_equal( cdbl(n + c), x + c )
			cu_assert_equal( cdbl(n - c), x - c )

			cu_assert_equal( cdbl(-n), -x )
			cu_assert_equal( cdbl(-n + c), -x + c )
			cu_assert_equal( cdbl(-n - c), -x - c )

			cu_assert_equal( cdbl(n + 1), x + 1.0 )
			cu_assert_equal( cdbl(n - 1), x - 1.0 )
			cu_assert_equal( cdbl(-n + 1), -x + 1.0 )
			cu_assert_equal( cdbl(-n - 1), -x - 1.0 )

			n shl= 1: x *= 2.0

		next
                               
	END_TEST

END_SUITE
