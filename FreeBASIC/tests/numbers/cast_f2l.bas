# include "fbcu.bi"

namespace fbc_tests.numbers.cast_f2l

	sub test_cast()

		dim as ulongint n = 1ull
		dim as double x = 1.0

		for i as integer = 0 to 30

			cu_assert_equal(cdbl(n), x)
			cu_assert_equal(cdbl(n + 1), x + 1.0)
			cu_assert_equal(cdbl(n - 1), x - 1.0)

			n shl= 1: x *= 2.0

		next

	end sub

	sub ctor () constructor

		fbcu.add_suite("fbc_tests.numbers.cast_f2l")
		fbcu.add_test("test_cast", @test_cast)

	end sub

end namespace
