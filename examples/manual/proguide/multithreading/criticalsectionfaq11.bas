'' examples/manual/proguide/multithreading/criticalsectionfaq11.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

#include Once "fbthread.bi"
Type threadUDT Extends Object
	Public:
		Declare Sub ThreadCreate ()
		Declare Sub ThreadWait ()
		Declare Sub ThreadDetach ()
		Declare Static Sub MutexCreate ()
		Declare Static Sub MutexLock ()
		Declare Static Sub MutexUnlock ()
		Declare Static Sub MutexDestroy ()
		Declare Static Sub CondCreate ()
		Declare Static Sub CondWait ()
		Declare Static Sub CondSignal ()
		Declare Static Sub CondBroadcast ()
		Declare Static Sub CondDestroy ()
	Private:
		Declare Abstract Sub thread ()
		Dim As Any Ptr pThread
		Static As Any Ptr pMutex
		Static As Any Ptr pCond
End Type
Dim As Any Ptr threadUDT.pMutex
Dim As Any Ptr threadUDT.pCond

Sub threadUDT.threadCreate ()
	If This.pThread = 0 Then
	  This.pThread = .ThreadCreate(Cast(Any Ptr Ptr Ptr, @This)[0][0], @This)
	End If
End Sub

Sub threadUDT.threadWait ()
	If This.pThread > 0 Then
		.ThreadWait(This.pThread)
		This.pThread = 0
	End If
End Sub

Sub threadUDT.threadDetach ()
	If This.pThread > 0 Then
		.ThreadDetach(This.pThread)
		This.pThread = 0
	End If
End Sub
  
Sub threadUDT.mutexCreate ()
	If threadUDT.pMutex = 0 Then
		threadUDT.pMutex = .MutexCreate
	End If
End Sub
  
Sub threadUDT.mutexLock ()
	If threadUDT.pMutex > 0 Then
		.MutexLock(threadUDT.pMutex)
	End If
End Sub

Sub threadUDT.mutexUnlock ()
	If threadUDT.pMutex > 0 Then
		.MutexUnlock(threadUDT.pMutex)
	End If
End Sub

Sub threadUDT.mutexDestroy ()
	If threadUDT.pMutex > 0 Then
		.MutexDestroy(threadUDT.pMutex)
		threadUDT.pMutex = 0
	End If
End Sub

Sub threadUDT.condCreate ()
	If threadUDT.pCond = 0 Then
		threadUDT.pCond = .CondCreate
	End If
End Sub

Sub threadUDT.condWait ()
	If threadUDT.pCond > 0 And threadUDT.pMutex > 0 Then
		.CondWait(threadUDT.pCond, threadUDT.pMutex)
	End If
End Sub

Sub threadUDT.condSignal ()
	If threadUDT.pCond > 0 And threadUDT.pMutex > 0 Then
		.CondSignal(threadUDT.pCond)
	End If
End Sub

Sub threadUDT.condBroadcast ()
	If threadUDT.pCond > 0 And threadUDT.pMutex > 0 Then
		.CondBroadcast(threadUDT.pCond)
	End If
End Sub

Sub threadUDT.condDestroy ()
	If threadUDT.pCond > 0 Then
		.CondDestroy(threadUDT.pCond)
		threadUDT.pCond = 0
	End If
End Sub

'------------------------------------------------------------------------------

Type UDT Extends threadUDT
	Declare Sub counter ()
	Declare Sub thread ()
	Dim As Integer number
	Dim As Integer tempo
	Dim As ULongInt count
	Static As Integer threadPriorityNumber
	Static As Integer numberMax
	Static As Integer quit
End Type
Dim As Integer UDT.threadPriorityNumber
Dim As Integer UDT.numberMax
Dim As Integer UDT.quit

Sub UDT.counter ()
	Locate This.number, This.number, 0
	Sleep 5, 1
	This.count += 1
	Print This.count;
	Locate This.number, 30 + This.number, 0
End Sub

Sub UDT.Thread ()
	Dim As Integer myquit
	Do
		This.mutexLock()
		While UDT.threadPriorityNumber <> This.number  '' synchronous condwait for expected condition
			This.condWait()
		Wend
		This.counter()
		myquit = UDT.quit
		UDT.threadPriorityNumber = (UDT.threadPriorityNumber + 1) Mod (UDT.numberMax + 1)
		This.condBroadcast()
		This.mutexUnlock()
		Sleep This.tempo, 1
	Loop Until myquit = 1
End Sub


UDT.numberMax = 6
Dim As UDT u(0 To UDT.numberMax)
For I As Integer = 0 To UDT.numberMax
	u(I).number = i
	u(I).tempo = 100 + 15 * I - 95 * Sgn(I)
Next I
UDT.mutexCreate()
UDT.condCreate()

Dim As Single t = Timer
For I As Integer = 1 To UDT.numberMax
	u(I).ThreadCreate()
Next I

Dim As String s
Do
	UDT.mutexLock()
	While UDT.threadPriorityNumber <> u(0).number
		UDT.condWait()
	Wend
	s = Inkey
	If s <> "" Then
		UDT.quit = 1
	End If
	UDT.threadPriorityNumber = (UDT.threadPriorityNumber + 1) Mod (UDT.numberMax + 1)
	UDT.condBroadcast()
	UDT.mutexUnlock()
	Sleep u(0).tempo, 1
Loop Until s <> ""

For I As Integer = 1 To UDT.numberMax
	u(I).ThreadWait()
Next I
t = Timer - t

UDT.mutexDestroy()
UDT.condDestroy()
Dim As ULongInt c
For I As Integer = 1 To UDT.numberMax
	c += u(I).count
Next I
Locate UDT.numberMax+2, 1
Print CULngInt(c / t) & " increments per second"

Sleep
				
