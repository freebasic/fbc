#include "fbcunit.bi"

SUITE( fbc_tests.overload_.op_constparam )

	type udt
		as integer i
	end type

	operator +(byref a as const udt, byref b as const udt) as udt
		return type<udt>(a.i + b.i)
	end operator

	TEST( all )

		dim as const udt c = (13)
		dim as udt v = (17)

		CU_ASSERT_EQUAL( (c + c).i, (13 + 13) )
		CU_ASSERT_EQUAL( (c + v).i, (13 + 17) )
		CU_ASSERT_EQUAL( (v + c).i, (17 + 13) )
		CU_ASSERT_EQUAL( (v + v).i, (17 + 17) )

	END_TEST

END_SUITE
