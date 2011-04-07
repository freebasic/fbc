''
'' threads example
''

const THREADS   = 5
const SECS 		= 3

declare sub mythread ( byval num as any ptr )

	dim as any ptr thread(0 to THREADS-1)
	dim as integer i 
	
	'' create and call the threads
	for i = 0 to THREADS-1
		thread(i) = threadcreate( @mythread, cast(any ptr, i) )
		if( thread(i) = 0 ) then
			print "Error creating thread! Exiting..."
			end 1
		end if
	next
	
	'' wait all threads to finish
	for i = 0 to THREADS-1
		threadwait( thread(i) )
	next
	
'':::::	
sub mythread ( byval num as any ptr )
	dim as integer i
	
	for i = 0 to SECS-1
		print "Hello from thread: " & cint(num) & " (" & SECS-i & " sec(s) left)"
		sleep( 1000 )
	next

end sub
