sub threadProcedure( byval userdata as any ptr )
	for i as integer = 0 to 4
		print i
		sleep 500, 1
	next
end sub

print "starting thread..."
dim as any ptr threadid = threadcreate( @threadProcedure, 0 )

print "waiting for thread to finish..."
threadwait( threadid )

print "finished"
sleep
