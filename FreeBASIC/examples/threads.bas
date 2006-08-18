''
'' freeBASIC threads example
''

const THREADS   = 5
const SECS 		= 3

declare sub mythread ( byval num as integer )

	dim thread(THREADS) as integer
	dim i as integer
	
	'' create and call the threads
	for i = 0 to THREADS-1
		thread(i) = threadcreate( @mythread, i )
		if( thread(i) = 0 ) then
			print "Error creating thread! Exiting..."
			end 1
		end if
	next i
	
	'' wait all threads to finish
	for i = 0 to THREADS-1
		threadwait( thread(i) )
	next i
	
'':::::	
sub mythread ( byval num as integer )
	dim i as integer, k as string
	
	for i = 0 to SECS-1
		print "Hello from thread: " & num & " (" & SECS-i & " sec(s) left)"
		sleep( 1000 )
	next

end sub