
	open command for input as #1
	open command + ".txt" for output as #2

	dim as string ln
	
	do until( eof(1) )
		
		line input #1, ln
		print ln
		print #2, ln
	
	loop
	
	close #2
	close #1
