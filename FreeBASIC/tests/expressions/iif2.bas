option explicit

sub test1
	dim as integer value = 0, test = -1
	
	if( test > 0 ) then
		value += iif( test < 5, 10, -10 )
	else
		value += iif( test > -5, 10, -10 )
	end if
	
	assert( value = 10 )
	
end sub

	test1
