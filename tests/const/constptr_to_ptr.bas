' TEST_MODE : COMPILE_ONLY_FAIL

	sub c( byval x as integer ptr )
		*x = 69
	end sub
	
	dim as const integer pp = 0
	
	c( @pp )
