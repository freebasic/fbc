option explicit

const TEST_VAL = 1234

sub test1
	dim as integer value = TEST_VAL, test = -1
	
	if( test > 0 ) then
		value += iif( test > 5, 10, -10 ) + iif( test < 5, 10, -10 )
	else
		value += iif( test > -5, 10, -10 ) + iif( test < -5, 10, -10 )
	end if
	
	assert( value = TEST_VAL )
	
end sub

	test1
