#include "fbcunit.bi"

SUITE( fbc_tests.overload_.sub_call2 )

	sub foo overload ()
	end sub
 
	function foo overload (byval v as integer) as integer
		function = v
	end function

	TEST( simple )
		CU_ASSERT_EQUAL( foo(1234), 1234 )
	END_TEST

END_SUITE
