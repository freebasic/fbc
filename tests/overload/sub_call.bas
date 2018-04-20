#include "fbcunit.bi"

SUITE( fbc_tests.overload_.sub_call )

	const TEST_VAL = 1234

	type udt : __ as byte : end type 

	function proc overload (byval udt as udt) as udt 
		CU_FAIL_FATAL("")
		return udt
	end function 

	sub proc overload (byval i as integer) 
		CU_ASSERT_EQUAL( i, TEST_VAL )
	end sub 

	TEST( simple )
		proc( TEST_VAL )
	END_TEST

END_SUITE
