' TEST_MODE : MULTI_MODULE_TEST

#include "common.bi"

	arr_init()

  ASSERT( lbound(arr_dynamic_int) = TEST_LBOUND )
  ASSERT( ubound(arr_dynamic_int) = TEST_UBOUND )

  ASSERT( lbound(arr_dynamic_int_with_alias) = TEST_LBOUND )
  ASSERT( ubound(arr_dynamic_int_with_alias) = TEST_UBOUND )

	arr_test()
