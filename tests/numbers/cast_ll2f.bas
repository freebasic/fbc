# include "fbcu.bi"

namespace fbc_tests.numbers.cast_ll2f

	const c as longint = 1ll shl 32

	sub test_cast_ull cdecl()

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

	end sub

	sub test_cast_ll cdecl()

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

	end sub

	sub ctor () constructor

		fbcu.add_suite("fbc_tests.numbers.cast_ll2f")
		fbcu.add_test("test_cast_ll",  @test_cast_ll)
		fbcu.add_test("test_cast_ull", @test_cast_ull)

	end sub

end namespace
