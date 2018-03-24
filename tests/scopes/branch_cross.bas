#include "fbcunit.bi"

SUITE( fbc_tests.scopes.branch_cross )

	TEST( test1 )
		
		dim z as integer '' no cross
		
		scope
		
			dim y as integer '' no cross
			
			scope
				dim x as integer '' no cross
				
				# print 3 warning follow ...
				goto scope2
				
				dim w as integer '' no cross
			end scope
		
			dim v as integer '' no cross
		end scope
		
		dim a as integer '' cross
		
		scope
			dim b	as integer '' cross
			
			scope
				dim c	as integer '' cross

	scope2:	

				dim d	as integer '' no cross
			end scope
			
			dim e as integer '' no cross
		end scope
		
		dim f	as integer '' no cross
		
	END_TEST

	'' !!! TODO !!! - this test causes an infinite loop
	'' what is actually being tested here?  needs rewrite
	sub test2
		
		dim z as integer '' no cross
		
		scope
		
			dim y as integer '' cross
			
			scope
				dim x as integer '' cross
				
	scope2:
				
				dim w as integer '' no cross
			end scope
		
			dim v as integer '' no cross
		end scope
		
		dim a as integer '' no cross
		
		scope
			dim b	as integer '' no cross
			
			scope
				dim c	as integer '' no cross

				# print 2 warnings follow ...
				goto scope2	

				dim d	as integer '' no cross
			end scope
			
			dim e as integer '' no cross
		end scope
		
		dim f	as integer '' no cross
		
	end sub

END_SUITE
