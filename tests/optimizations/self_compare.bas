#include "fbcunit.bi"

#define CHECK_TRUE(e, failtext)  if (e) then else CU_FAIL(e failtext)
#define CHECK_FALSE(e, failtext) if (e) then      CU_FAIL(e failtext)

SUITE( fbc_tests.optimizations.self_compare )

	function counter() as integer
		static a as integer = 0
		a += 1
		return a
	end function

	TEST( bop )

		dim as integer a = 10

		CHECK_TRUE( a  = a, should be true)
		CHECK_TRUE( a <= a, should be true)
		CHECK_TRUE( a >= a, should be true)

		CHECK_FALSE( a <> a, should be false)
		CHECK_FALSE( a <  a, should be false)
		CHECK_FALSE( a >  a, should be false)

		'' these ops shouldn't be affected
		CHECK_TRUE(  a + a, shouldn't be 0 for a=10)
		CHECK_TRUE(  a * a, shouldn't be 0 for a=10)
		CHECK_TRUE(  a \ a, shouldn't be 0 for a<>0)
		CHECK_TRUE(  a / a, shouldn't be 0 for a<>0)
		CHECK_FALSE( a - a, should be 0 for all a)

		'' these ops aren't optimized at time of writing,
		'' but these tests should (of course) pass in either case
		CHECK_TRUE(  a AND a, shouldn't be 0 for a<>0)
		CHECK_TRUE(  a OR  a, shouldn't be 0 for a<>0)
		CHECK_TRUE(  a IMP a, shouldn't be 0 for any a)
		CHECK_TRUE(  a EQV a, shouldn't be 0 for any a)
		CHECK_FALSE( a XOR a, should be 0 for all a)

	END_TEST

	'' test for trees that are nearly identical but shouldn't match
	TEST( nearly_identical_tree )

		'' test float consts in tree comparisons (no epsilion, need to be strict)

		dim as double a = 1e+100
		#define e1 (a * 1e-100) '' 1.0
		#define e2 (a * 2e-100) '' 2.0

		CU_ASSERT( e1 > 0.0 )

		CHECK_FALSE( e1 = e2, should be false for large enough a )

		'' make sure trees with function calls aren't equal
		CU_ASSERT_EQUAL( counter(), 1 )
		CHECK_FALSE( counter() = counter(), should always be false (2=3) )
		CU_ASSERT_EQUAL( counter(), 4 )

	END_TEST

END_SUITE
