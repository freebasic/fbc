
sub test_f
	dim as single v1, v2
	v1 = 1.234567F
	v2 = val( "1.234567" )
	assert( v1 = v2 )
end sub
		
sub test_d	
	dim as single v1, v2
	v1 = 1.234567890123456D
	v2 = val( "1.234567890123456" )
	assert( v1 = v2 )
end sub

	test_f
	test_d
	
