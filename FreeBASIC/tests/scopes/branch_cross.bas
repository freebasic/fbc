
sub test_1
	
	dim z '' no cross
	
	scope
	
		dim y '' no cross
		
		scope
			dim x '' no cross
			
			goto scope2
			
			dim w '' no cross
		end scope
	
		dim v '' no cross
	end scope
	
	dim a '' cross
	
	scope
		dim b	'' cross
		
		scope
			dim c	'' cross

scope2:	

			dim d	'' no cross
		end scope
		
		dim e  '' no cross
	end scope
	
	dim f	'' no cross
	
end sub

sub test_2
	
	dim z '' no cross
	
	scope
	
		dim y '' cross
		
		scope
			dim x '' cross
			
scope2:
			
			dim w '' no cross
		end scope
	
		dim v '' no cross
	end scope
	
	dim a '' no cross
	
	scope
		dim b	'' no cross
		
		scope
			dim c	'' no cross

			goto scope2	

			dim d	'' no cross
		end scope
		
		dim e  '' no cross
	end scope
	
	dim f	'' no cross
	
end sub