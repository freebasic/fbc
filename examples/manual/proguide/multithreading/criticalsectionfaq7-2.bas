'' examples/manual/proguide/multithreading/criticalsectionfaq7-2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Type ThreadUDT
	Dim handle As Any Ptr
	Static sync As Any Ptr
	Static quit As Byte
End Type
Dim ThreadUDT.sync As Any Ptr
Dim ThreadUDT.quit As Byte

Function ClockTime () As String
	Return Time
End Function

Function Counter () As Integer
	Static C As Integer
	C = (C + 1) Mod 1000000
	Return C
End Function

Sub ProcedureThread (ByVal param As Any Ptr)
	Dim p0 As Integer = 0
	Dim p1 As Integer = 1
	ScreenSet 1, 0  '' setting to define in each thread
	With *Cast(ThreadUDT Ptr, param)
		Do
			MutexLock(.sync)
			Dim s As String = ClockTime()
			For I As Integer = 1 To 2  '' updating the two screen pages
				Line (544, 0)-(639, 49), 0, BF  '' clear the print area
				Sleep 100, 1
				Locate 2, 71
				Print s;
				ScreenSet p0, p1
				Swap p0, p1
			Next I
			MutexUnlock(.sync)
			Sleep 100, 1
		Loop Until .quit = 1
	End With
End Sub

Screen 12, , 2
Dim p0 As Integer = 0
Dim p1 As Integer = 1
ScreenSet 1, 0  '' setting to define in each thread
For I As Integer = 1 To 2  '' updating the two screen pages
	Locate 30, 2
	Print "<q/Q> : quit";
	ScreenSet p0, p1
	Swap p0, p1
Next I

Dim TTptr As ThreadUDT Ptr = New ThreadUDT
ThreadUDT.sync = MutexCreate
TTptr->handle = ThreadCreate(@ProcedureThread, TTptr)

Dim s As String
Do
	MutexLock(ThreadUDT.sync)
	Dim C As Integer = Counter()
	For I As Integer = 1 To 2  '' updating the two screen pages
		Line (296, 208)-(376, 256), 0, BF  '' clear the print area
		Sleep 100, 1
		Locate 15,40
		Print Using "######"; c;
		ScreenSet p0, p1
		Swap p0, p1
	Next I
	s = Inkey
	MutexUnlock(ThreadUDT.sync)
	Sleep 100, 1
Loop Until LCase(s) = "q"
 
ThreadUDT.quit = 1
ThreadWait(TTptr->handle)
MutexDestroy(ThreadUDT.sync)
Delete TTptr
				
