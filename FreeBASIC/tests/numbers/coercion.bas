

#define TEST_SI &hFFFFFFFF
#define TEST_UI &hFFFFFFFFU
#define TEST_SL &hFFFFFFFFFFFFFFFFLL
#define TEST_UL &hFFFFFFFFFFFFFFFFULL
#define TEST_S  123456.7F
#define TEST_D  12345678901234.5D

sub test1
	dim as longint v
	v = TEST_SI
	assert( v = TEST_SI )
	v = TEST_UI
	assert( v = TEST_UI )
	v = TEST_SL
	assert( v = TEST_SL )
	v = TEST_UL
	assert( v = TEST_UL )
	v = TEST_S
	assert( v = cast( longint, TEST_S ) )
	v = TEST_D
	assert( v = cast( longint, TEST_D ) )
end sub

sub test2
	dim as ulongint v
	v = TEST_SI
	assert( v = TEST_SI )
	v = TEST_UI
	assert( v = TEST_UI )
	v = TEST_SL
	assert( v = TEST_SL )
	v = TEST_UL
	assert( v = TEST_UL )
	v = TEST_S
	assert( v = cast( ulongint, TEST_S ) )
	v = TEST_D
	assert( v = cast( ulongint, TEST_D ) )
end sub

sub test3
	dim as integer v
	v = TEST_SI
	assert( v = TEST_SI )
	v = TEST_UI
	assert( v = TEST_UI )
	v = TEST_SL
	assert( v = cast( integer, TEST_SL ) )
	v = TEST_UL
	assert( v = cast( integer, TEST_UL ) )
	v = TEST_S
	assert( v = cast( integer, TEST_S ) )
	v = TEST_D
	assert( v = cast( integer, TEST_D ) )
end sub

sub test4
	dim as uinteger v
	v = TEST_SI
	assert( v = TEST_SI )
	v = TEST_UI
	assert( v = TEST_UI )
	v = TEST_SL
	assert( v = cast( uinteger, TEST_SL ) )
	v = TEST_UL
	assert( v = cast( uinteger, TEST_UL ) )
	v = TEST_S
	assert( v = cast( uinteger, TEST_S ) )
	v = TEST_D
	assert( v = cast( uinteger, TEST_D ) )
end sub

	test1
	test2
	test3
	test4