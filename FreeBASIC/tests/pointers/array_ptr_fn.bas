const TEST_VAL = &hdeadbeef

type fn as function(byval as integer, byval as integer, byval as integer) as integer ptr
	
function func(byval a as integer, byval b as integer, byval c as integer) as integer ptr

	static test as integer = TEST_VAL
	function = @test

end function
	
	dim fnarray(10) as fn ptr

	i = 5
	j = 3
	fnarray(i) = allocate((j+1) * len( fn ptr ))
	
	fnarray(i)[j] = @func
	
	assert( *fnarray(i)[j]( 1, 2, 3 ) = TEST_VAL )
	