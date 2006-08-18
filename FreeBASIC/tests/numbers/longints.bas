

#define TEST_SL1 &h7FFFFFFFFFFFFFLL
#define TEST_SL2 &hFFFFLL
#define TEST_UL1 &hFFFFFFFFFFFFFFULL
#define TEST_UL2 &hFFFFFULL

#define TEST_D 65536.0D

sub test_div
	dim as longint v1
	v1 = TEST_SL1
	v1 /= TEST_D
	assert( v1 = cast( longint, TEST_SL1 / TEST_D ) )

	dim as ulongint v2
	v2 = TEST_UL1
	v2 /= TEST_D
	assert( v2 = cast( ulongint, TEST_UL1 / TEST_D ) )
	
end sub

sub test_intdiv
	dim as longint v1
	v1 = TEST_SL1
	v1 \= TEST_SL2
	assert( v1 = TEST_SL1 \ TEST_SL2 )

	dim as ulongint v2
	v2 = TEST_UL1
	v2 \= TEST_UL2
	assert( v2 = TEST_UL1 \ TEST_UL2 )
	
end sub

sub test_shift
	dim as longint v1
	v1 = 2 ^ 34
	v1 shr= 34
	assert( v1 = 1 )

	dim as ulongint v2
	v2 = 2 ^ 34
	v2 shr= 34
	assert( v2 = 1 )
end sub

	test_div
	test_intdiv
	test_shift

