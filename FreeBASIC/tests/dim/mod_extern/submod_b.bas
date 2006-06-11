option explicit

#include "common.bi"

	redim shared arr_dynamic_int() as integer

sub arr_init()
	redim arr_dynamic_int(TEST_LBOUND to TEST_UBOUND)
end sub

sub arr_test()
	assert( lbound(arr_dynamic_int) = TEST_LBOUND )
	assert( ubound(arr_dynamic_int) = TEST_UBOUND )
end sub