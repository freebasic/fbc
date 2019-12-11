'' examples/manual/proguide/multithreading/criticalsectionfaq5.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Function threadInput (ByVal row As Integer, ByVal column As Integer, ByRef prompt As String = "", _
					  ByVal sleeptime As Integer = 15, ByVal blank As Integer = 0, ByVal mutex As Any Ptr = 0 _
					  ) As String
	Dim As Integer r
	Dim As Integer c
	Dim As String inputchr
	Dim As String inputline
 
	MutexLock(mutex)
	r = CsrLin()
	c = Pos()
	Locate row, column
	Print prompt & "? _";
	Locate r, c
	MutexUnlock(mutex)

	Do
		MutexLock(mutex)
		r = CsrLin()
		c = Pos()
		Locate row, column + Len(inputline) + Len(prompt) + 2
		inputchr = Inkey
		If Len(inputchr) = 1 Then
			If Asc(inputchr) >= 32 Then
				Print inputchr & Chr(95);
				Locate , Pos - 1
				inputline &= inputchr
			ElseIf Asc(inputchr) = 08 And Len(inputline) > 0 Then
				Locate , Pos - 1
				Print Chr(95) & " ";
				Locate , Pos() - 2
				inputline = Left(inputline, Len(inputline) - 1)
			End If
		End If
		Locate r, c
		MutexUnlock(mutex)
		Sleep sleeptime, 1
	Loop Until inputchr = Chr(13)

	If blank <> 0 Then
		MutexLock(mutex)
		r = CsrLin()
		c = Pos()
		Locate row, column + Len(prompt) + 2
		Print Space(Len(inputline) + 1);
		Locate r, c
		MutexUnlock(mutex)
	End If

	Return inputline
End Function

'------------------------------------------------------------------------------

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


Screen 12
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

Do
Loop Until LCase(threadInput(8, 1, """quit"" for exit", 10, 1, UDT.pMutex)) = "quit"

UDT.quit = 1

For I As Integer = 1 To UDT.numberMax
	ThreadWait(u(I).pThread)
Next I
t = Timer - t

MutexDestroy(UDT.pMutex)
Dim As ULongInt c
For I As Integer = 1 To UDT.numberMax
	c += u(I).count
Next I
Locate UDT.numberMax + 4, 1
Print CULngInt(c / t) & " increments per second"

Sleep
					
