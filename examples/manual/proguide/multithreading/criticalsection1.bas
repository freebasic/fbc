'' examples/manual/proguide/multithreading/criticalsection1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSections
'' --------

Type UDT
	Dim As Integer number
	Dim As Integer tempo
	Dim As Any Ptr pThread
	Dim As ULongInt count
	Static As Any Ptr pMutex
	Static As Integer numberMax
	Static As Integer quit
End Type
Dim As Any Ptr UDT.pMutex
Dim As Integer UDT.numberMax
Dim As Integer UDT.quit

Sub Counter (ByVal pt As UDT Ptr)
	With *pt
		Locate .number, .number, 0
		Sleep 5, 1
		.count += 1
		Print .count;
		Locate .number, 30 + .number, 0
	End With
End Sub

Sub Thread (ByVal p As Any Ptr)
	Dim As Integer myquit
	Dim As UDT Ptr pUDT = p
	With *pUDT
		Do
			MutexLock(.pMutex)
			Counter(pUDT)
			myquit = .quit
			MutexUnlock(.pMutex)
			Sleep .tempo, 1
		Loop Until myquit = 1
	End With
End Sub


UDT.numberMax = 6
Dim As UDT u(0 To UDT.numberMax)
For I As Integer = 0 To UDT.numberMax
	u(I).number = i
	u(I).tempo = 100 + 15 * I - 95 * Sgn(I)
Next I
UDT.pMutex = MutexCreate

Dim As Single t = Timer
For I As Integer = 1 To UDT.numberMax
	u(I).pThread = ThreadCreate(@Thread, @u(I))
Next I

Dim As String s
Do
	MutexLock(UDT.pMutex)
	s = Inkey
	If s <> "" Then
		UDT.quit = 1
	End If
	MutexUnlock(UDT.pMutex)
	Sleep u(0).tempo, 1
Loop Until s <> ""

For I As Integer = 1 To UDT.numberMax
	ThreadWait(u(I).pThread)
Next I
t = Timer - t

MutexDestroy(UDT.pMutex)
Dim As ULongInt c
For I As Integer = 1 To UDT.numberMax
	c += u(I).count
Next I
Locate UDT.numberMax+2, 1
Print CULngInt(c / t) & " increments per second"

Sleep
		
