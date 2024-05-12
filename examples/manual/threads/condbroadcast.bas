'' examples/manual/threads/condbroadcast.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONDBROADCAST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCondBroadcast
'' --------

'' How can all threads wait for each other before continuing to execute their concomitant sections of code ?
''
'' This is the main code that manages the synchronization of concomitant sections of code:
''    - Each thread signals to main code that it is waiting for synchronization.
''    - The main code waits for each of all threads, then sends the synchronization signal to all threads.
''
'' The synchronization uses the following keywords from threading:
''   - In each thread : 'Condsignal' (to send signal to main code) then 'Condwait' (to wait signal from main code).
''   - In main code : 'Condwait' (to wait signal from each thread) then 'Condbroadcast' (to send signal to all threads).
'' With the associated mutexes and conditional variables and flags.
''
'' Test example highlighting the structure of threads and their behaviors, when synchronizing all threads to execute their concomitant sections of code:

Dim threadnumber As Integer = 4

'' global data for all threads
	Dim Shared restart As Integer = 0
	Dim Shared threadcount As Integer = 0
   
	Dim Shared hmutexrestart As Any Ptr
	Dim Shared hcondrestart As Any Ptr
	Dim Shared hmutexready As Any Ptr
	Dim Shared hcondready As Any Ptr

Sub mythread(ByVal p As Any Ptr)
   
	Dim id As Integer = Cast(Integer, p)
   
	'' for visualizing thread status
		Print "   Thread #" & id & " is started..."
	   
	'' instead of starting user code
		Sleep id * 40, 1
	   
	'' for visualizing thread status
		Print "      Thread #" & id & " is running..."
		Sleep id * 20, 1  '' just to well visualize thread interlacing
		Print "   Thread #" & id & " is waiting for synchronization..."
	   
	'' for sending signal to main code
		MutexLock hmutexready
		threadcount += 1
		CondSignal hcondready
		MutexUnlock hmutexready
	   
	'' for waiting signal from main code
		MutexLock hmutexrestart
		Do While restart = 0  
			CondWait hcondrestart, hmutexrestart
		Loop
		MutexUnlock hmutexrestart
	   
	'' for visualizing thread status
		Print "   Thread #" & id & " is reactivated..."
	   
	'' instead of synchronized user code
		Sleep id * 40, 1
	   
	'' for visualizing thread status
		Print "      Thread #" & id & " is continuing..."
		Sleep id * 20, 1  '' just to well visualize thread interlacing
		Print "   Thread #" & id & " is finishing execution..."
   
End Sub


Dim threads(1 To threadnumber) As Any Ptr

hcondrestart = CondCreate()
hmutexrestart = MutexCreate()
hcondready = CondCreate()
hmutexready = MutexCreate()

'' for visualizing main code status
	Print "Start all threads from main code :"
	   
'' for starting all threads
	For i As Integer = 1 To threadnumber
		threads(i) = ThreadCreate(@mythread, Cast(Any Ptr, i))
	Next i

'' for waiting for all threads waiting for synchronisation
	MutexLock hmutexready
	Do Until threadcount = threadnumber
		CondWait(hcondready, hmutexready)
	Loop
	MutexUnlock hmutexready

'' for visualizing main code status
	Print "All thread seen waiting from main code"
	Print
	Print "Reactivate all threads from main code :"
	   
'' for reactivating all threads
	MutexLock hmutexrestart
	restart = 1
	CondBroadcast hcondrestart
	MutexUnlock hmutexrestart

'' for waiting for all threads to be completed
	For i As Integer = 1 To threadnumber
		If threads(i) <> 0 Then
			ThreadWait threads(i)
		End If
	Next i
   
'' for visualizing main code status
	Print "All thread seen completed from main code"

MutexDestroy hmutexready
CondDestroy hcondready
MutexDestroy hmutexrestart
CondDestroy hcondrestart

Sleep
