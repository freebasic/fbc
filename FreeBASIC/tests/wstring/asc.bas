option explicit

const TEST_A = asc( wstr( "abc" ), 1 )
const TEST_B = asc( wstr( "abc" ), 2 )
const TEST_C = asc( wstr( "abc" ), 3 )
const TEST_D = asc( wstr( "abc" ), 4 )

	assert( TEST_A = asc( wstr( "a" ) ) )
	
	assert( TEST_B = asc( wstr( "b" ) ) )
	
	assert( TEST_C = asc( wstr( "c" ) ) )
	
	assert( TEST_D = 0 )
	
	
	
