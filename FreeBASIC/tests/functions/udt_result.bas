 

const TEST_X = 1234
const TEST_Y = 5678

type i_xy 
    x as integer 
    y as integer 
end type 

type d_xy 
    x as double
    y as double
end type 

function i_decxy1 ( byref udt as i_xy ) as i_xy
    
    udt.x -= 1 
    udt.y -= 1 
    
    function = udt
    
end function 

function i_decxy2 ( byref udt as i_xy ) as i_xy
    
    udt.x -= 1 
    udt.y -= 1 
    
    function = type( udt.x, udt.y )
    
end function 

function d_decxy1 ( byref udt as d_xy ) as d_xy
    
    udt.x -= 1 
    udt.y -= 1 
    
    function = udt
    
end function 

function d_decxy2 ( byref udt as d_xy ) as d_xy
    
    udt.x -= 1 
    udt.y -= 1 
    
    function = type( udt.x, udt.y )
    
end function 

	dim as i_xy i_array( 0 to 9 )

	i_array(0).x = TEST_X
	i_array(0).y = TEST_Y
	i_array(0) = i_decxy1( i_array(0) )
	assert( i_array(0).x = TEST_X - 1 )
	assert( i_array(0).y = TEST_Y - 1 )
	
	i_array(0).x = TEST_X
	i_array(0).y = TEST_Y
	i_array(0) = i_decxy2( i_array(0) )
	assert( i_array(0).x = TEST_X - 1 )
	assert( i_array(0).y = TEST_Y - 1 )
	
	dim as d_xy d_array( 0 to 9 )
	
	d_array(0).x = TEST_X
	d_array(0).y = TEST_Y
	d_array(0) = d_decxy1( d_array(0) )
	assert( d_array(0).x = TEST_X - 1 )
	assert( d_array(0).y = TEST_Y - 1 )
	
	d_array(0).x = TEST_X
	d_array(0).y = TEST_Y
	d_array(0) = d_decxy2( d_array(0) )
	assert( d_array(0).x = TEST_X - 1 )
	assert( d_array(0).y = TEST_Y - 1 )
	