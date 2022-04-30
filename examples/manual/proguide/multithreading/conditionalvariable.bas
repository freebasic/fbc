'' examples/manual/proguide/multithreading/conditionalvariable.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Conditional Variables'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtConditionalVariables
'' --------

Declare Sub thread (ByVal userdata As Any Ptr)

Dim As Any Ptr threadID             '' declaration of an 'Any Ptr' thread-ID of the child thread
Dim Shared As Any Ptr mutID         '' declaration of a global 'Any Ptr' mutex-ID
	mutID = MutexCreate             '' creation of the mutex
Dim Shared As Boolean boolM, boolC  '' declaration of 2 global 'Boolean' boolM and boolC as predicates
Dim Shared As Any Ptr condID        '' declaration of a global 'Any Ptr' conditional-ID
	condID = CondCreate             '' creation of the conditional


Print """[M]"": from 'Main' thread"
Print """(C)"": from 'Child' thread"
Print

threadID = ThreadCreate(@thread)  '' creation of the child thread from the main thread

For I As Integer = 1 To 10       '' 'For' loop of the main thread
	MutexLock(mutID)             '' set mutex locked at the beginning of the exclusive section
	Print "[";
	Sleep 50, 1
	Print "M";
	Sleep 50, 1
	Print "]";
	boolC = True                 '' set to 'True' the predicate for the child thread
	CondSignal(condID)           '' signal to the child thread
	While boolM <> True          '' test predicate from the child thread
		CondWait(condID, mutID)  '' wait for signal from the child thread
	Wend
	boolM = False                '' reset the predicate from the child thread
	MutexUnlock(mutID)           '' set mutex unlocked at the end of the exclusive section
	Sleep 50, 1
Next I

ThreadWait(threadID)  '' waiting for the child thread termination
Print
Print "'Child' thread finished"

MutexDestroy(mutID)  '' destruction of the mutex
CondDestroy(condID)  '' destruction of the conditional

Sleep


Sub thread (ByVal userdata As Any Ptr)  '' sub executed by the child thread
	For I As Integer = 1 To 10          '' 'For' loop of the child thread
		MutexLock(mutID)                '' set mutex locked at the beginning of the exclusive section
		While boolC <> True             '' test predicate from the main thread
			CondWait(condID, mutID)     '' wait for signal from the main thread
		Wend
		boolC = False                   '' reset the predicate from the main thread
		Print "(";
		Sleep 50, 1
		Print "C";
		Sleep 50, 1
		Print ")";
		boolM = True                    '' set to 'True' the predicate for the main thread
		CondSignal(condID)              '' signal to the child thread
		MutexUnlock(mutID)              '' set mutex unlocked at the end of the exclusive section
		Sleep 250, 1
	Next I
End Sub
		
