# include "fbcu.bi"

namespace fbc_tests.numbers.cast_f2ll

	const c as ulongint = 1ll shl 31

	sub test_cast_ull()

		dim as ulongint n = 1ull
		dim as double x = 1.0

		for i as integer = 0 to 62

			cu_assert_equal( culngint(x), n )
			cu_assert_equal( culngint(x + c), n + c )
			cu_assert_equal( culngint(x - c), n - c )
			if( i <= 52) then
				cu_assert_equal( culngint(x + 1.0), n + 1 )
				cu_assert_equal( culngint(x - 1.0), n - 1 )
			end if

			n shl= 1: x *= 2.0

		next

	end sub

	sub test_cast_ll()

		dim as longint n = 1ll
		dim as double x = 1.0

		for i as integer = 0 to 62

			cu_assert_equal( clngint(x), n )
			cu_assert_equal( clngint(x + c), n + c )
			cu_assert_equal( clngint(x - c), n - c )
			if( i <= 52) then
				cu_assert_equal( clngint(x + 1.0), n + 1 )
				cu_assert_equal( clngint(x - 1.0), n - 1 )
			end if

			n shl= 1: x *= 2.0

		next

	end sub

	sub ctor () constructor

		fbcu.add_suite("fbc_tests.numbers.cast_f2ll")
		fbcu.add_test("test_cast_ll",  @test_cast_ll)
		fbcu.add_test("test_cast_ull", @test_cast_ull)

	end sub

end namespace
