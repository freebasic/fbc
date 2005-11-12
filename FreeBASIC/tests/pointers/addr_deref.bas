const TEST_VAL = 12345678
	
	dim as integer a, b
	dim as integer ptr p

	b = TEST_VAL

	a = *@b 
	assert( a = TEST_VAL )
	 
	p = @a
	assert( *p = TEST_VAL )

	p = @(a)
	assert( *p = TEST_VAL )

	p = @*p
	assert( *p = TEST_VAL )

