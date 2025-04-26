'' examples/manual/proguide/multithreading/criticalsectionfaq13-1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Dim Shared As Any Ptr mutex0, mutex1, mutex2, mutex, cond1, cond2, pt
Dim Shared As Integer flag1, flag2
Dim As Double t

'----------------------------------------------------------------------------------

#if defined(__FB_WIN32__)
Declare Function _setTimer Lib "winmm" Alias "timeBeginPeriod"(ByVal As ULong = 1) As Long
Declare Function _resetTimer Lib "winmm" Alias "timeEndPeriod"(ByVal As ULong = 1) As Long
#endif

Sub ThreadFlag(ByVal p As Any Ptr)
	MutexUnlock(mutex0)  '' unlock mutex for main thread
	For I As Integer = 1 To 100
		While flag1 = 0
			Sleep 1, 1
		Wend
		flag1 = 0
		' only child thread code runs (location for example)
		flag2 = 1
	Next I
End Sub

mutex0 = MutexCreate()
MutexLock(mutex0)

pt = ThreadCreate(@ThreadFlag)
MutexLock(mutex0)  '' wait for thread launch (mutex unlock from child thread)
Print "Thread synchronization latency by simple flags:"
#if defined(__FB_WIN32__)
	_setTimer()
	Print "(in high resolution OS cycle period)"
#else
	Print "(in normal resolution OS cycle period)"
#endif
t = Timer
For I As Integer = 1 To 100
	flag1 = 1
	While flag2 = 0
		Sleep 1, 1
	Wend
	flag2 = 0
	' only main thread code runs (location for example)
Next I
t = Timer - t
#if defined(__FB_WIN32__)
	_resetTimer()
#endif
ThreadWait(pt)
Print Using "####.## milliseconds per double synchronization (round trip)"; t * 10
Print

MutexDestroy(mutex0)

'----------------------------------------------------------------------------------

Sub ThreadMutex(ByVal p As Any Ptr)
	MutexUnlock(mutex0)  '' unlock mutex for main thread
	For I As Integer = 1 To 100000
		MutexLock(mutex1)    '' wait for mutex unlock from main thread
		' only child thread code runs
		MutexUnlock(mutex2)  '' unlock mutex for main thread
	Next I
End Sub

mutex0 = MutexCreate()
mutex1 = MutexCreate()
mutex2 = MutexCreate()
MutexLock(mutex0)
MutexLock(mutex1)
MutexLock(mutex2)

pt = ThreadCreate(@ThreadMutex)
MutexLock(mutex0)  '' wait for thread launch (mutex unlock from child thread)
Print "Thread synchronization latency by mutual exclusions:"
t = Timer
For I As Integer = 1 To 100000
	MutexUnlock(mutex1)  '' mutex unlock for child thread
	MutexLock(mutex2)    '' wait for mutex unlock from child thread
	' only main thread code runs
Next I
t = Timer - t
ThreadWait(pt)
Print Using "####.## microseconds per double synchronization (round trip)"; t * 10
Print

MutexDestroy(mutex0)
MutexDestroy(mutex1)
MutexDestroy(mutex2)

'----------------------------------------------------------------------------------

Sub ThreadCondVar(ByVal p As Any Ptr)
	MutexUnlock(mutex0)  '' unlock mutex for main thread
	For I As Integer = 1 To 100000
		MutexLock(mutex)
		While flag1 = 0
			CondWait(cond1, mutex)  '' wait for conditional signal from main thread
		Wend
		flag1 = 0
		' only child thread code runs (location for example)
		flag2 = 1
		CondSignal(cond2)  '' send conditional signal to main thread
		MutexUnlock(mutex)
	Next I
End Sub

mutex0 = MutexCreate()
mutex = MutexCreate()
MutexLock(mutex0)
cond1 = CondCreate()
cond2 = CondCreate()

pt = ThreadCreate(@ThreadCondVar)
MutexLock(mutex0)  '' wait for thread launch (mutex unlock from child thread)
Print "Thread synchronization latency by conditional variables:"
t = Timer
For I As Integer = 1 To 100000
	MutexLock(mutex)
	flag1 = 1
	CondSignal(cond1)  '' send conditional signal to main thread
	While flag2 = 0
		CondWait(Cond2, mutex)  '' wait for conditional signal from child thread
	Wend
	flag2 = 0
	' only child thread code runs (location for example)
	MutexUnlock(mutex)
Next I
t = Timer - t
ThreadWait(pt)
Print Using "####.## microseconds per double synchronization (round trip)"; t * 10
Print

MutexDestroy(mutex0)
MutexDestroy(mutex)
CondDestroy(cond1)
CondDestroy(cond2)

'----------------------------------------------------------------------------------

Sleep
