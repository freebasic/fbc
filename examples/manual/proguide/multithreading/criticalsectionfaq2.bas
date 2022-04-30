'' examples/manual/proguide/multithreading/criticalsectionfaq2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

#define while_loop_on_predicate

Dim As Any Ptr handle
Dim Shared As Any Ptr mutex
Dim Shared As Any Ptr cond
Dim As Integer sleep0
Dim As Integer sleep1
#ifdef while_loop_on_predicate
Dim Shared As Integer ready
#endif


Sub Thread1 (ByVal param As Any Ptr)
	Sleep *Cast(Integer Ptr, param), 1
	MutexLock(mutex)
	Color 11 : Print "        Thread#1 locks the mutex"
	Color 11 : Print "        Thread#1 executes code with exclusion"
	#ifdef while_loop_on_predicate
	ready = 1
	#endif
	Color 11 : Print "        Thread#1 is signaling"
	CondSignal(cond)
	Color 11 : Print "        Thread#1 executes post-code with exclusion"
	Color 11 : Print "        Thread#1 unlocks the mutex"
	MutexUnlock(mutex)
End Sub

Sub Thread0 (ByVal param As Any Ptr)
	Sleep *Cast(Integer Ptr, param), 1
	MutexLock(mutex)
	Color 10 : Print "    Thread#0 locks the mutex"
	Color 10 : Print "    Thread#0 executes pre-code with exclusion"
	#ifdef while_loop_on_predicate
	While ready <> 1
	#endif
		Color 10 : Print "    Thread#0 is waiting"
		CondWait(cond, mutex)
		Color 10 : Print "    Thread#0 is waked"
	#ifdef while_loop_on_predicate
	Wend
	#endif
	Color 10 : Print "    Thread#0 executes code with exclusion"
	#ifdef while_loop_on_predicate
	ready = 0
	#endif
	Color 10 : Print "    Thread#0 unlocks the mutex"
	MutexUnlock(mutex)
End Sub


mutex = MutexCreate
cond = CondCreate

sleep0 = 0
sleep1 = 1000
Color 7 : Print "Chronology for Thread#1 signaling while Thread#0 is waiting:"
handle = ThreadCreate(@Thread1, @sleep1)
Thread0(@sleep0)
ThreadWait(handle)
Color 7 : Print "Thread#1 finished": Print
Sleep 1000, 1

sleep0 = 1000
sleep1 = 0
Color 7 : Print "Chronology for Thread#1 signaling before Thread#0 is waiting:"
handle = ThreadCreate(@Thread1, @sleep1)
Thread0(@sleep0)
ThreadWait(handle)
Color 7 : Print "Thread#1 finished": Print


MutexDestroy(mutex)
CondDestroy(cond)
Sleep
			
