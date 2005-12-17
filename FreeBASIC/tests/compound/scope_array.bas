option explicit

const TEST_1 = -1
const TEST_2 = -2
const TEST_3 = -3

type bar
	a as short
	b as integer
	c as single
end type
	
declare sub foo	

	dim shared array(0 to 3) as bar = (TEST_1)
	
	scope		
		scope 
			dim array(0 to 3) as bar = (TEST_2)
			scope
				assert( array(0).a = TEST_2 )
			end scope
		end scope
		assert( array(0).a = TEST_1 )
	end scope
	
	scope		
		scope
			scope
				dim array(0 to 3) as bar = (TEST_3)
			end scope
			assert( array(0).a = TEST_1 )
		end scope
	end scope
	
	foo
	
	assert( array(0).a = TEST_1 )
	
	end 0
	
''::::
sub foo

	scope		
		scope 
			dim array(0 to 3) as bar = (TEST_2)
			scope
				assert( array(0).a = TEST_2 )
			end scope
		end scope
		assert( array(0).a = TEST_1 )
	end scope
	
	scope		
		scope
			scope
				dim array(0 to 3) as bar = (TEST_3)
			end scope
			assert( array(0).a = TEST_1 )
		end scope
	end scope
	
	assert( array(0).a = TEST_1 )

end sub	