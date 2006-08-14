
const filename = ".\file\text_in2.txt"

sub test_lineinp
	
	dim as integer lines = 0
	dim as string ln
	
	open filename for input as #1 
	
	do while not eof(1) 
		line input #1, ln
		lines += 1
	loop 
	
	close #1 

	assert( lines = 2 )
	
end sub

sub test_input
	
	dim as integer lines = 0, int_
	
	open filename for input as #1 
	
	do while not eof(1) 
		input #1, int_
		lines += 1
	loop 
	
	close #1 

	assert( lines = 2 )
	
end sub

	test_lineinp
	test_input