#ifdef __FB_LINUX__
const ls = "ls *"
#else
const ls = "dir *.*"
#endif
	
	dim inpline as string
	
	OPEN PIPE ls for input as #1
	
	print string( 60, "-" )
	
	do while( not eof(1 ) )
		line input #1, inpline
		print inpline
	loop
	
	print string( 60, "-" )
	
	close #1
