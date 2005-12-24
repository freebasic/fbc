#define TEST_SI &hFFFFFFFF
#define TEST_UI &hFFFFFFFFU
#define TEST_SL &hFFFFFFFFFFFFFFFFLL
#define TEST_UL &hFFFFFFFFFFFFFFFFULL
#define TEST_S  123456.7! 
#define TEST_D  12345678901234.5#

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
	v = TEST_F
	assert( v = cast( longint, TEST_F ) )
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
	v = TEST_F
	assert( v = cast( ulongint, TEST_F ) )
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
	assert( v = TEST_SL )
	v = TEST_UL
	assert( v = TEST_UL )
	v = TEST_F
	assert( v = cast( integer, TEST_F ) )
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
	assert( v = TEST_SL )
	v = TEST_UL
	assert( v = TEST_UL )
	v = TEST_F
	assert( v = cast( uinteger, TEST_F ) )
	v = TEST_D
	assert( v = cast( uinteger, TEST_D ) )
end sub

	test1
	test2
	test3
	test4