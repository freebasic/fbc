option explicit

#include "common.bi"

	arr_init()

	assert( lbound(arr_dynamic_int) = TEST_LBOUND )
	assert( ubound(arr_dynamic_int) = TEST_UBOUND )

	arr_test()