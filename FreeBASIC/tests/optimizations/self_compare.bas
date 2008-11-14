# include "fbcu.bi"

namespace fbc_tests.optimizations.self_compare

	sub test_self_compare cdecl( )

		dim as integer a = 10

		if a  = a then else CU_FAIL(a  = a should be true)
		if a <= a then else CU_FAIL(a <= a should be true)
		if a >= a then else CU_FAIL(a >= a should be true)

		if a <> a then CU_FAIL(a <> a should be false)
		if a <  a then CU_FAIL(a <  a should be false)
		if a >  a then CU_FAIL(a >  a should be false)

		'' these ops shouldn't be affected
		if a + a then else CU_FAIL(a + a shouldn't be 0 for a=10)
		if a * a then else CU_FAIL(a * a shouldn't be 0 for a=10)
		if a \ a then else CU_FAIL(a \ a shouldn't be 0 for a<>0)
		if a / a then else CU_FAIL(a / a shouldn't be 0 for a<>0)
		if a - a then CU_FAIL(a - a should be 0 for all a)

		'' these ops aren't optimized at time of writing,
		'' but theses tests should (of course) pass in either case
		if a AND a then else CU_FAIL(a AND a shouldn't be 0 for a<>0)
		if a OR  a then else CU_FAIL(a OR  a shouldn't be 0 for a<>0)
		if a IMP a then else CU_FAIL(a IMP a shouldn't be 0 for any a)
		if a EQV a then else CU_FAIL(a EQV a shouldn't be 0 for any a)
		if a XOR a then CU_FAIL(a XOR a should be 0 for all a)

	end sub

	private sub ctor () constructor

		fbcu.add_suite("fbc_tests.optimizations.self_compare")
		fbcu.add_test("Optimizing self-comparisons", @test_self_compare)

	end sub

end namespace
