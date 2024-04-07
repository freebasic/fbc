'' examples/manual/proguide/multithreading/criticalsection2.bas
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
	Static As Integer threadPriorityNumber
	Static As Any Ptr pMutex
	Static As Any Ptr pCond
	Static As Integer numberMax
	Static As Integer quit
End Type
Dim As Integer UDT.threadPriorityNumber
Dim As Any Ptr UDT.pMutex
Dim As Any Ptr UDT.pCond
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
			While .threadPriorityNumber <> .number  '' synchronous condwait for expected condition
				CondWait(.pCond, .pMutex)
			Wend
			Counter(pUDT)
			myquit = .quit
			.threadPriorityNumber = (.threadPriorityNumber + 1) Mod (.numberMax + 1)
			CondBroadcast(.pCond)
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
UDT.PCond = CondCreate

Dim As Single t = Timer
For I As Integer = 1 To UDT.numberMax
	u(I).pThread = ThreadCreate(@Thread, @u(I))
Next I

Dim As String s
Do
	MutexLock(UDT.pMutex)
	While UDT.threadPriorityNumber <> u(0).number
		CondWait(UDT.pCond, UDT.pMutex)
	Wend
	s = Inkey
	If s <> "" Then
		UDT.quit = 1
	End If
	UDT.threadPriorityNumber = (UDT.threadPriorityNumber + 1) Mod (UDT.numberMax + 1)
	CondBroadcast(UDT.pCond)
	MutexUnlock(UDT.pMutex)
	Sleep u(0).tempo, 1
Loop Until s <> ""

For I As Integer = 1 To UDT.numberMax
	ThreadWait(u(I).pThread)
Next I
t = Timer - t

MutexDestroy(UDT.pMutex)
CondDestroy(UDT.pCond)
Dim As ULongInt c
For I As Integer = 1 To UDT.numberMax
	c += u(I).count
Next I
Locate UDT.numberMax+2, 1
Print CULngInt(c / t) & " increments per second"

Sleep
		
