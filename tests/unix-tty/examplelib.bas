function get123() as integer
	return 123
end function

sub print_hello()
	print "hello ";
	var oldcolors = color(1)
	print "hello ";
	color(loword(oldcolors))
	print "hello ";
end sub
