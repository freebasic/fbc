

sub test1
	static as integer array(0 to 3) = { 0, 1, 2, 3 }
	
	dim as integer i
	for i = 0 to 3
		assert( array(i) = i )
	next
	
end sub

sub test2 static
	dim as integer array(0 to 3) = { 0, 1, 2, 3 }
	
	dim as integer i
	for i = 0 to 3
		assert( array(i) = i )
	next
	
end sub

sub test3
	static as integer array()
	
	redim array(0 to 3)

	dim as integer i
	for i = 0 to 3
		array(i) = i
	next
	
	for i = 0 to 3
		assert( array(i) = i )
	next
	
end sub

sub test4 static
	dim as integer array()
	
	redim array(0 to 3)

	dim as integer i
	for i = 0 to 3
		array(i) = i
	next
	
	for i = 0 to 3
		assert( array(i) = i )
	next
	
end sub


	test1
	test2
	test3
	test4