'' examples/manual/threads/mutexlock2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'MUTEXLOCK'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMutexLock
'' --------

' 'Threadcreate' launches one time the user-defined Sub in a separate execution thread
'    (which runs simultaneously with the rest of the main code).
' If you want obtain a periodically display from the thread,
'    you must put (into the thread) a [Do...Loop] block with a 'Sleep x, 1' to adjust the display period
'    and a flag to exit the loop (and terminate the thread).
'
' Warning:
' - Each thread has not its own memory of cursor position, so for that and other reasons, it is mandatory
'      to apply an exclusion between displaying from the main code (main thread) and displaying from the user thread,
'      by using a 'Mutex' ([Mutexlock...Mutexunlock] block).
'   At beginning of each display block both into main thread and user thread,
'      the initial cursor position must also be re-initialized.
' - The input keywords (like keyboard, mouse) cannot be safely run when the screen is locked,
'      therefore a such keyword must be outside of any [Screenlock...Screenunlock] block (outside this block in its own thread,
'      and protected of block of another thread by a 'Mutex').
'
' See below a rustic program, but showing all these constraints:


Dim Shared As Any Ptr sync   '' pointer to Mutex
Dim Shared As Byte quit = 0  '' flag to end user thread
Dim As Any Ptr handle        '' pointer to thread handle

Sub ProcedureThread (ByVal param As Any Ptr)  '' param not used in thread body
	Do
		MutexLock(sync)       '' Mutex for exclusion of displaying
			ScreenLock        '' keyword after Mutexlock
				Locate 1, 70  '' re-initialize cursor position
				Print Date
				Locate , 71
				Print Time;
			ScreenUnlock      '' keyword before Mutexunlock
		MutexUnlock(sync)     '' end exclusion
		Sleep 100, 1          '' ajust display period
	Loop Until quit <> 0      '' test for exit thread
End Sub


Screen 12
Locate 1, 62
Print "Date:"
Locate , 62
Print "Time:";
Locate 15, 20
Print "Mouse (position):"
Locate , 20
Print "Mouse (buttons) :";
Locate 30, 2
Print "<any_key> or <click on window close button>: exit";

sync = MutexCreate                          '' create Mutex (before Threadcreate)
handle = ThreadCreate(@ProcedureThread, 0)  '' launch thread

Dim As String s
Do
	MutexLock(sync)                     '' Mutex for exclusion of displaying
		Dim As Long x, y, b
		GetMouse x, y , , b             '' keyword outside [Screenlock...Screenunlock] and protected by Mutex
		ScreenLock                      '' keyword after Mutexlock
			Locate 15, 37               '' re-initialize cursor position
			Print Using "######"; x; y
			Locate , 43
			Print Using "##"; b;
		ScreenUnlock                    '' Keyword before Mutexunlock
		s = Inkey                       '' keyword outside [Screenlock...Screenunlock] and protected by Mutex
	MutexUnlock(sync)                   '' end exclusion
	Sleep 10, 1                         '' ajust display period
Loop Until s <> ""
 
quit = Not quit     '' order thread end
ThreadWait(handle)  '' wait for thread end
MutexDestroy(sync)  '' free Mutex
