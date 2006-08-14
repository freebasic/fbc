	
	open ".\wstring\lineinput.txt" for input encoding "utf-16" as #1

	dim s as wstring * 32 
	dim i as integer = 0

	do until eof( 1 )
		line input #1, s
		assert( left( s, 2 ) = wstr( i ) )
		i += 1
	loop 

	close #1