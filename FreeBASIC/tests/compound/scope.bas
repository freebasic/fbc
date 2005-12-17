option explicit

const TEST_A = -1
const TEST_B = -2
const TEST_C = -3
const TEST_D = -4
	
declare sub foo	

	dim shared c = TEST_C
	dim shared d = TEST_D
	
	scope
		dim a = TEST_A
		scope 
			dim b = TEST_B
			assert( a = TEST_A )
			scope
				assert( b = TEST_B )
			end scope
		end scope

	end scope
	
	scope
		dim a = 1234
		assert( a = 1234 )
		scope
			assert( c = TEST_C )
			scope
				dim d = 5678
				assert( d = 5678 )
			end scope
		end scope
	end scope
	
	foo
	
	assert( c = TEST_C )
	assert( d = TEST_D )
	
''::::
sub foo

	scope
		dim a = TEST_A
		scope 
			dim b = TEST_B
			assert( a = TEST_A )
			scope
				assert( b = TEST_B )
			end scope
		end scope
	end scope
	
	scope
		dim a = 1234
		assert( a = 1234 )
		scope
			assert( c = TEST_C )
			scope
				dim d = 5678
				assert( d = 5678 )
			end scope
		end scope
	end scope
	
	assert( c = TEST_C )
	assert( d = TEST_D )

end sub	