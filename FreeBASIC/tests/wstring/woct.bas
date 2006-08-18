

sub test_long
	const TEST_VAL = &o1777777777777777777777ULL
	
	dim as ulongint n = TEST_VAL, digmax = 8
	dim as integer i
		
	assert( valulng( "&o" + woct( n ) ) = TEST_VAL )
	
	for i = 1 to ((len( n ) * 8) \ 3) + 0
	    assert( valulng( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
	    digmax *= 8
	next
	
	assert( valulng( "&o" + woct( n, i ) ) = TEST_VAL )
	
end sub
	
sub test_int
	const TEST_VAL = &o17777777777
	
	dim as uinteger n = TEST_VAL, digmax = 8
	dim as integer i
		
	assert( valuint( "&o" + woct( n ) ) = TEST_VAL )
	
	for i = 1 to ((len( n ) * 8) \ 3) + 0
	    assert( valuint( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
	    digmax *= 8
	next
	
	assert( valuint( "&o" + woct( n, i ) ) = TEST_VAL )
	
end sub

sub test_short
	const TEST_VAL = &o177777
	
	dim as ushort n = TEST_VAL, digmax = 8
	dim as integer i
		
	assert( valuint( "&o" + woct( n ) ) = TEST_VAL )
	
	for i = 1 to ((len( n ) * 8) \ 3) + 0
	    assert( valuint( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
	    digmax *= 8
	next
	
	assert( valuint( "&o" + woct( n, i ) ) = TEST_VAL )
	
end sub

sub test_byte
	const TEST_VAL = &o377
	
	dim as ubyte n = TEST_VAL, digmax = 8
	dim as integer i
		
	assert( valuint( "&o" + woct( n ) ) = TEST_VAL )
	
	for i = 1 to ((len( n ) * 8) \ 3) + 0
	    assert( valuint( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
	    digmax *= 8
	next
	
	assert( valuint( "&o" + woct( n, i ) ) = TEST_VAL )
	
end sub

	test_long
	test_int
	test_short
	test_byte
