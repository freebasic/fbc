# include "fbcu.bi"

#define expr(n) ((n - (n - (n + (n - (n + 1))))))

namespace fbc_tests.optimizations.side_effects

	sub test_accum_addsub cdecl( )

		dim as integer n = 0

		CU_ASSERT_EQUAL( expr(0), -1 )
		CU_ASSERT_EQUAL( expr(n), expr(0) )

	end sub

	private sub ctor () constructor

		fbcu.add_suite("fbc_tests.optimizations.accum_addsub")
		fbcu.add_test("Optimizing constant folding in nested add/subtract expressions", @test_accum_addsub)

	end sub

end namespace
