	
	dim array( 0 to 9 ) as integer = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }

	dim pt as integer ptr
	
	pt = @array(1)
	
	cptr(short ptr, pt) += 1
	
	assert( *pt = (array(2) and &hffff) shl 16 or (array(1) shr 16) )
		
