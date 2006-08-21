

#include "common.bi"

	redim shared arr_dynamic_int() as integer
	redim shared arr_dynamic_int_with_alias( )

sub arr_init()
	redim arr_dynamic_int(TEST_LBOUND to TEST_UBOUND)
	redim arr_dynamic_int_with_alias(TEST_LBOUND to TEST_UBOUND)
end sub

sub arr_test()
	CU_ASSERT( lbound(arr_dynamic_int) = TEST_LBOUND )
	CU_ASSERT( lbound(arr_dynamic_int) = TEST_LBOUND )
	CU_ASSERT( ubound(arr_dynamic_int_with_alias) = TEST_UBOUND )
	CU_ASSERT( ubound(arr_dynamic_int_with_alias) = TEST_UBOUND )
end sub