''
'' freeBASIC threads example, using CRTDLL's beginthread routine
''
'' note: beginthread(ex) and endthread routines must be used instead of kernel32's CreateThread(ex) and ExitThread,
''       because the C run-time library has to preserve its context when any of its functions are called from
''		 a thread. Using CreateThread would leak memory or cause strange behaviors.
''
''		 Thread routines must be declared as CDECL (C calling convention), as that's what beginthread(ex)
''		 expects (with CreateThread(ex), the convention must be STDCALL)
''		
''

defint a-z
option explicit

'$include: 'win\kernel32.bi'
'$include: 'win\crtdll.bi'

const THREADS   = 5
const SECS 		= 3

declare sub mythread cdecl ( byval num as integer )

	dim shared threadsRunning as integer
	
	dim i as integer

	'' create and call the threads
	threadsRunning = 0
	for i = 0 to THREADS-1
		if( beginthread( @mythread, 0, byval i ) <> -1 ) then
			threadsRunning = threadsRunning + 1
		end if
	next i
	
	'' wait all threads to finish
	do while( threadsRunning > 0 )
		Sleep 100
	loop
	
	
'':::::	
sub mythread cdecl ( byval num as integer )
	dim i as integer
	
	for i = 0 to SECS-1
		print "Hello from thread: " + str$( num ) + " (" + str$( SECS-i ) + " sec(s) left)"
		Sleep 1000
	next i
	
	threadsRunning = threadsRunning - 1

end sub