'' examples/manual/proguide/multithreading/criticalsectionfaq5.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Function threadInput (ByVal row As Integer, ByVal column As Integer, ByRef prompt As String = "", _
					  ByVal sleeptime As Integer = 15, ByVal blank As Integer = 0, ByVal mutex As Any Ptr = 0 _
					  ) As String
	Dim As String inputchr
	Dim As String inputline
	Dim As Integer cursor
	Dim As Integer cursor0
	Dim As Integer r
	Dim As Integer c

 
	MutexLock(mutex)
	r = CsrLin()
	c = Pos()
	Locate row, column
	Print prompt & " _";
	cursor0 = Pos() - 1
	Locate r, c
	MutexUnlock(mutex)

	Do
		MutexLock(mutex)
		r = CsrLin()
		c = Pos()
		inputchr = Inkey
		If inputchr <> "" Then
			If inputchr >= Chr(32) And inputchr < Chr(255) Then
				inputline = Left(inputline, cursor) & inputchr & Mid(inputline, cursor + 1)
				cursor += 1
			ElseIf inputchr = Chr(08) And Cursor > 0 Then                         'BkSp
				cursor -= 1
				inputline = Left(inputline, cursor) & Mid(inputline, cursor + 2)
			ElseIf inputchr = Chr(255) & "S" And Cursor < Len(inputline) Then     'Del
				inputline = Left(inputline, cursor) & Mid(inputline, cursor + 2)
			ElseIf inputchr = Chr(255) + "M" And Cursor < Len(inputline) Then     'Right
				Cursor += 1
			ElseIf inputchr = Chr(255) + "K" And Cursor > 0 Then                  'Left
				Cursor -= 1
			End If
			If inputchr = Chr(27) Then                                            'Esc
				Locate row, cursor0
				Print Space(Len(inputline) + 1);
				inputline = ""
				cursor = 0
			End If
			Locate row, cursor0
			Print Left(inputline, cursor) & Chr(95) & Mid(inputline, cursor + 1) & " ";
		End If
		Locate r, c
		MutexUnlock(mutex)
		Sleep sleeptime, 1
	Loop Until inputchr = Chr(13)

	If blank <> 0 Then
		MutexLock(mutex)
		r = CsrLin()
		c = Pos()
		Locate row, cursor0
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
Loop Until LCase(threadInput(8, 1, """quit"" for exit?", 10, 1, UDT.pMutex)) = "quit"

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
					
