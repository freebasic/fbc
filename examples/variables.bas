'' Global variable, visible to main part and procedures
dim shared global as integer

sub foo( number as integer, text as string )
	'' Local variables visible only inside this procedure
	dim a as integer

	a = global * 3 + number / 2
	print a, text
	global = 555
end sub

	'' Local variables visible only to main part of FB program
	dim a as integer
	dim s as string

	a = 5
	a = a * 2

	s = "hello"
	s += ", there!"

	print a, s

	global = 100
	print "global: "; global
	foo( a, s )
	print "global: "; global

	sleep
