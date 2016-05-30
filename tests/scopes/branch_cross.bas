# include "fbcu.bi"

namespace fbc_tests.scopes.branch_cross

sub test_1 cdecl ()
	
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
	
end sub

sub test_2 cdecl ()
	
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

sub ctor () constructor

	fbcu.add_suite("fbc_tests.scopes.branch_cross")
	fbcu.add_test("test 1", @test_1)
'	fbcu.add_test("test 2", @test_2)

end sub

end namespace
