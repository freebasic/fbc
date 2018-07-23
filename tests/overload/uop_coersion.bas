#include "fbcunit.bi"

SUITE( fbc_tests.overload_.uop_coersion )

	type udt
		value as integer
		declare operator cast as integer
	end type

	operator udt.cast as integer
		operator = value
	end operator

	const TEST_VAL = 1234

	TEST( simple )
		dim as udt v = ( TEST_VAL )
		
		'' auto-coercion from UDT to integer using the op ovl
		CU_ASSERT_EQUAL( -v, -TEST_VAL )

		'' ditto
		CU_ASSERT_EQUAL( not v, not TEST_VAL )

	END_TEST

END_SUITE
