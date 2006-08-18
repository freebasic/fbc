

const FALSE = 0
const TRUE = -1


sub test1
const TEST_1 = 1234
const TEST_2 = 5678

	dim as integer res
	
	res = (TEST_1 xor iif( TRUE, TEST_1, TEST_2 )) or (iif( FALSE, TEST_2, TEST_1 ) xor TEST_1)
	
	assert( res = 0 )
	
	res = (TEST_2 xor iif( FALSE, TEST_1, TEST_2 )) or (iif( TRUE, TEST_2, TEST_1 ) xor TEST_2)
	
	assert( res = 0 )	
	
end sub

sub test2
const TEST_1 = 1234.0
const TEST_2 = 5678.0

	dim as double res

	res = iif( TRUE, TEST_1, 0.0 ) * iif( FALSE, 0.0, TEST_2 )
	
	assert( res = TEST_1 * TEST_2 )
	
end sub

	test1
	test2