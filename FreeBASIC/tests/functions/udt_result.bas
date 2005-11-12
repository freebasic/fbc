option explicit 

const TEST_X = 1234
const TEST_Y = 5678

type xy 
    x as integer 
    y as integer 
end type 

function decxy ( byref udt as xy ) as xy
    
    udt.x -= 1 
    udt.y -= 1 
    
    return udt
    
end function 

	dim as xy array( 0 to 9 )

	array(0).x = TEST_X
	array(0).y = TEST_Y
	
	array(0) = decxy( array(0) )
	
	assert( array(0).x = TEST_X - 1 )
	assert( array(0).y = TEST_Y - 1 )