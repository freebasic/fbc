''
'' threads example
''

const THREADS = 5
const SECONDS = 3

sub mythread( byval num as any ptr )
	for i as integer = 0 to SECONDS-1
		print "Hello from thread " & cint(num) & " (" & SECONDS-i & " second(s) left) " & string(cint(num), "*")
		sleep( 1000 )
	next
end sub

dim as any ptr thread(0 to THREADS-1)

'' create and call the threads
for i as integer = 0 to THREADS-1
	thread(i) = threadcreate( @mythread, cast(any ptr, i) )
next

'' wait for all threads to finish
for i as integer = 0 to THREADS-1
	threadwait( thread(i) )
next
