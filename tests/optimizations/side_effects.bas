#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.side_effects )

	function modify_a( byref a as integer ) as integer
		a += 1
		return 1
	end function

	TEST( all )

		dim as integer a = 0, b

		b = 0 * modify_a( a )
		b = modify_a( a ) * 0

		b = 0 and modify_a( a )
		b = modify_a( a ) and 0

		b = -1 or modify_a( a )
		b = modify_a( a ) or -1

		b = modify_a( a ) imp -1

		b = modify_a( a ) mod 1
		b = modify_a( a ) mod -1


		CU_ASSERT_EQUAL( a, 9 )

	END_TEST
	
END_SUITE
