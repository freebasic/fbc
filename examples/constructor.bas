'' Global constructor/destructor for module initialization/clean up

	print "main: application running"

sub on_init( ) constructor
	print "starting: before main"
end sub

sub on_exit( ) destructor
	print "exiting: bye!"
	sleep
end sub
