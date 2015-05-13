' TEST_MODE : MULTI_MODULE_TEST

#include "common.bi"

	redim shared arr_dynamic_int() as integer
	redim shared arr_dynamic_int_with_alias( ) as integer

sub arr_init()
	redim arr_dynamic_int(TEST_LBOUND to TEST_UBOUND)
	redim arr_dynamic_int_with_alias(TEST_LBOUND to TEST_UBOUND)
end sub

sub arr_test()
  ASSERT( lbound(arr_dynamic_int) = TEST_LBOUND )
  ASSERT( lbound(arr_dynamic_int) = TEST_LBOUND )
  ASSERT( ubound(arr_dynamic_int_with_alias) = TEST_UBOUND )
  ASSERT( ubound(arr_dynamic_int_with_alias) = TEST_UBOUND )
end sub
