

sub test_1

	dim as integer array(0 to 9) = { 0, 1, 2, 3, 4 }
	
	dim as integer i
	for i = 0 to 4
		assert( array(i) = i )
	next

	for i = 5 to 9
		assert( array(i) = 0 )
	next

end sub

type tudt
	as integer f0, f1, f2, f3, f4, f5
end type

sub test_2

	dim as tudt udt = ( 0, 1, 2 )
	
	with udt
		assert( .f0 = 0 )
		assert( .f1 = 1 )
		assert( .f2 = 2 )
		assert( .f3 = 0 )
		assert( .f4 = 0 )
		assert( .f5 = 0 )
	end with


end sub

	test_1
	test_2