#include "fbcunit.bi"

SUITE( fbc_tests.overload_.integer_width )

	function hexa overload ( byval l as any ptr ) as integer
		function = 1
	end function

	function hexa( byval l as longint ) as integer
		function = 2
	end function

	TEST( all )
		CU_ASSERT_EQUAL( hexa(0ull), 2 )
		CU_ASSERT_EQUAL( hexa(1ull), 2 )
		CU_ASSERT_EQUAL( hexa(&hFFFFFFFFull), 2 )
		CU_ASSERT_EQUAL( hexa(&hFFFFFFFF00000000ull), 2 )
		CU_ASSERT_EQUAL( hexa(&hFFFFFFFFFFFFFFFFull), 2 )
		CU_ASSERT_EQUAL( hexa(1ull shl 32), 2 )
	END_TEST

END_SUITE
