declare sub doinput( byref file as string )

	open "bleh.dat"  for output as #1
	
	print #1, "abc def"
	print #1, 1234, 5678.901, "xyz zzz"
	
	close #1
	
	doinput "bleh.dat"

	
	open "bleh2.dat"  for output as #1
	
	write #1, "abc def"
	write #1, 1234, 5678.901, "xyz zzz"
	
	close #1
	
	doinput "bleh2.dat"
	

sub doinput( byref file as string )
	dim as integer i = 1234
	dim as double f = 5678.901
	dim as string s = "xyz zzz"
	
	open file for input as #1
	
	input #1, s
	print s
	
	input #1, i, f, s
	
	print i, f, s
	
	close #1
end sub
