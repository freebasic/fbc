const TEST_1 = 3
const TEST_2 = -3

	dim shared as integer sint
	dim shared as uinteger uint
	dim shared as integer div = 2
	
sub test1
	sint = TEST_1
	uint = TEST_1
	
	assert( sint \ 2 = 1 )
	assert( uint \ 2 = 1 )
	
	assert( sint \ div = 1 )
	assert( uint \ div = 1 )
end sub

sub test2
	sint = TEST_2
	uint = TEST_2
	
	assert( sint \ 2 = -1 )
	assert( uint \ 2 = &h7FFFFFFE )
	
	assert( sint \ div = -1 )
	assert( uint \ div = &h7FFFFFFE )
end sub

	test1
	test2