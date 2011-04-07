
	dim b as byte

	open command for binary as #1
	open command + ".txt" for binary as #2
	
	do until( eof(1) )
		
		get #1, , b
		print chr( b );
		put #2, , b
	
	loop
	
	close #2
	close #1
