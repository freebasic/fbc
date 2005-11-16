
const TEST_VAL = &hDeadBeef
	
	dim i as integer, v as integer
	dim p as integer ptr
	dim pp as integer ptr ptr
	
	pp = @p
	p = @v
	v = TEST_VAL
	
	i = 0
	
	assert( pp[i][i] = TEST_VAL )
	assert( **pp = TEST_VAL )
	assert( **(pp+i) = TEST_VAL )
	assert( *(pp+i)[i] = TEST_VAL )
	
	