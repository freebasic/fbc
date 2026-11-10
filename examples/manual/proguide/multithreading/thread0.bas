'' examples/manual/proguide/multithreading/thread0.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Threads'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtThreads
'' --------

Sub thread(ByVal p As Any Ptr)
	Do
		Static As String t
		Draw String (0, 16), t, 0
		t = Time
		Draw String (0, 16), t
		Do
			If *Cast(String Ptr, p) = "quit" Then Exit Sub
			Sleep 100, 1
		Loop Until Time <> t  ' to limit flickering
	Loop
End Sub

Dim As String s
Dim As Any Ptr pThread

Screen 12
Print "Time is updated by thread even while 'Line Input' is waiting for characters:";
Locate 4, 1
Print "Enter any character line to test, or 'quit' to finish:"
pThread = ThreadCreate(@thread, @s)
Do
	Locate 5, 1
	Print Space(Len(s));
	Locate 5, 1
	Line Input s
Loop Until s = "quit"
ThreadWait(pThread)
