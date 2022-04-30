'' examples/manual/proguide/multithreading/criticalsectionfaq7-1.bas
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
	ScreenSet 1, 0  '' setting to define in each thread
	With *Cast(ThreadUDT Ptr, param)
		Do
			MutexLock(.sync)
			Line (544, 0)-(639, 49), 0, BF  '' clear the print area
			Sleep 100, 1
			Locate 2, 71
			Print ClockTime();
			ScreenCopy
			MutexUnlock(.sync)
			Sleep 100, 1
		Loop Until .quit = 1
	End With
End Sub

Screen 12, , 2
ScreenSet 1, 0  '' setting to define in each thread
Locate 30, 2
Print "<q/Q> : quit";
ScreenCopy

Dim TTptr As ThreadUDT Ptr = New ThreadUDT
ThreadUDT.sync = MutexCreate
TTptr->handle = ThreadCreate(@ProcedureThread, TTptr)

Dim s As String
Do
	MutexLock(ThreadUDT.sync)
	Line (296, 208)-(376, 256), 0, BF  '' clear the print area
	Sleep 100, 1
	Locate 15,40
	Print Using "######"; Counter();
	ScreenCopy
	s = Inkey
	MutexUnlock(ThreadUDT.sync)
	Sleep 100, 1
Loop Until LCase(s) = "q"
 
ThreadUDT.quit = 1
ThreadWait(TTptr->handle)
MutexDestroy(ThreadUDT.sync)
Delete TTptr
				
