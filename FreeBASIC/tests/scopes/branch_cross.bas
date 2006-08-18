
sub test_1
	
	dim as integer z '' no cross
	
	scope
	
		dim as integer y '' no cross
		
		scope
			dim as integer x '' no cross
			
			goto scope2
			
			dim as integer w '' no cross
		end scope
	
		dim as integer v '' no cross
	end scope
	
	dim as integer a '' cross
	
	scope
		dim as integer b	'' cross
		
		scope
			dim as integer c	'' cross

scope2:	

			dim as integer d	'' no cross
		end scope
		
		dim as integer e  '' no cross
	end scope
	
	dim as integer f	'' no cross
	
end sub

sub test_2
	
	dim as integer z '' no cross
	
	scope
	
		dim as integer y '' cross
		
		scope
			dim as integer x '' cross
			
scope2:
			
			dim as integer w '' no cross
		end scope
	
		dim as integer v '' no cross
	end scope
	
	dim as integer a '' no cross
	
	scope
		dim as integer b	'' no cross
		
		scope
			dim as integer c	'' no cross

			goto scope2	

			dim as integer d	'' no cross
		end scope
		
		dim as integer e  '' no cross
	end scope
	
	dim as integer f	'' no cross
	
end sub