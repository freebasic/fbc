#ifdef __FB_LINUX__
const SHELL_COMMAND = "ls *"
#else
const SHELL_COMMAND = "dir *.*"
#endif

dim inpline as string

open pipe SHELL_COMMAND for input as #1

print string( 60, "-" )

do while( not eof(1 ) )
	line input #1, inpline
	print inpline
loop

print string( 60, "-" )

close #1
