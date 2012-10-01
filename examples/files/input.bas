'' This example demonstrates how the Input statement can be used to parse and
'' retrieve data from a file.

sub doinput( byref file as string )
	dim as integer i
	dim as double f
	dim as string s

	open file for input as #1

	input #1, s
	print s

	input #1, i, f, s
	print i, f, s

	close #1
end sub

'' Create a test data file...
open "test.dat" for output as #1
print #1, "abc def"
print #1, 1234, 5678.901, "xyz zzz"
close #1

'' Read it in
doinput "test.dat"
