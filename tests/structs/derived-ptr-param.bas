#include "fbcunit.bi"

SUITE( fbc_tests.structs.derived_ptr_param )

	type Parent
		i as integer
	end type

	type Child extends Parent
	end type

	function fbyvalparentptr( byval pp as Parent ptr ) as integer
		function = pp->i
	end function

	function fbyrefparentptr( byref pp as Parent ptr ) as integer
		function = pp->i
	end function

	function fbyvalchildptr( byval pc as Child ptr ) as integer
		function = pc->i
	end function

	function fbyrefchildptr( byref pc as Child ptr ) as integer
		function = pc->i
	end function

	TEST( all )
		dim pc as Child ptr = new Child
		pc->i = 123

		CU_ASSERT( fbyvalparentptr( pc ) = 123 )
		CU_ASSERT( fbyrefparentptr( pc ) = 123 )
		CU_ASSERT( fbyvalchildptr( pc ) = 123 )
		CU_ASSERT( fbyrefchildptr( pc ) = 123 )

		delete pc
	END_TEST

END_SUITE
