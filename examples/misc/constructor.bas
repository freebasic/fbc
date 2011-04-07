	dim shared v as string

	print "Application start"

sub do_init constructor
	print "Before main"
	v = "from_ctor"
end sub

sub do_exit destructor
	print "Bye !"
	sleep
end sub

	ASSERT( v = "from_ctor" )
