# include "fbcu.bi"

#define expr(a,b,c) ( (a) - ( (b)+1 )*3 + (c) )

namespace fbc_tests.optimizations.side_effects

	sub test_mul_dist cdecl( )

		dim as integer a = 0, b = 0, c = 0

		CU_ASSERT_EQUAL( expr(0,0,0), -3 )
		CU_ASSERT_EQUAL( expr(a,b,c), expr(0,0,0) )

	end sub

	private sub ctor () constructor

		fbcu.add_suite("fbc_tests.optimizations.mul_dist")
		fbcu.add_test("Optimizing distributive multiplication", @test_mul_dist)

	end sub

end namespace
