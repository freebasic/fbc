

#include "common.bi"

	arr_init()

	CU_ASSERT( lbound(arr_dynamic_int) = TEST_LBOUND )
	CU_ASSERT( ubound(arr_dynamic_int) = TEST_UBOUND )

	CU_ASSERT( lbound(arr_dynamic_int_with_alias) = TEST_LBOUND )
	CU_ASSERT( ubound(arr_dynamic_int_with_alias) = TEST_UBOUND )

	arr_test()