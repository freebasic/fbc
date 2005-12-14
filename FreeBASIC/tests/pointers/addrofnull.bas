option explicit

	dim as integer ptr i1, i2, p
	dim as integer i

	i = 0
	i1 = @i
	i2 = i1
	
	assert( @p[*i1 + *i2] = 0 )