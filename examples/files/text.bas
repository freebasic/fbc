'' Write out text file:
open "test.txt" for output as #1

print #1, "Hello,"
print #1, ""
print #1, "this is an example text file,"
print #1, "generated with the help of FreeBASIC."

close #1

'' ---
'' Display text file line by line:

open "test.txt" for input as #1

dim as string ln

do until( eof(1) )
	line input #1, ln
	print ln
loop

close #1
