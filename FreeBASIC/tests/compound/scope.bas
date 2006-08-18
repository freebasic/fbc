

const TEST_A = -1
const TEST_B = -2
const TEST_C = -3
const TEST_D = -4

declare sub foo	

	dim shared c as integer = TEST_C
	dim shared d as integer = TEST_D
	
	dim i as integer
	for i = 1 to 2
	
		scope
			dim a as integer = TEST_A
			scope 
				dim b as integer = TEST_B
				assert( a = TEST_A )
				scope
					assert( b = TEST_B )
				end scope
			end scope
	
		end scope
		
		scope
			dim a as integer = 1234
			assert( a = 1234 )
			scope
				assert( c = TEST_C )
				scope
					dim d as integer = 5678
					assert( d = 5678 )
				end scope
			end scope
		end scope
	
	next
	
	foo
	
	assert( c = TEST_C )
	assert( d = TEST_D )
	
''::::
sub foo

	dim i as integer
	for i = 1 to 2

		scope
			dim a as integer = TEST_A
			scope 
				dim b as integer = TEST_B
				assert( a = TEST_A )
				scope
					assert( b = TEST_B )
				end scope
			end scope
		end scope
		
		scope
			dim a as integer = 1234
			assert( a = 1234 )
			scope
				assert( c = TEST_C )
				scope
					dim d as integer = 5678
					assert( d = 5678 )
				end scope
			end scope
		end scope
		
		assert( c = TEST_C )
		assert( d = TEST_D )
		
	next

end sub	
