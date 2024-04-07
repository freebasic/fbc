'' examples/manual/proguide/graphics/anti-flickering.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Graphics Mode Refresh and Anti-Flickering'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgAntiFlickering
'' --------

Declare Sub Draw_circle_recursion (ByVal x As Integer, ByVal y As Integer, ByVal r As Integer, ByVal rmin As Integer)

Dim I As Integer = 0
Dim Inc As Integer
Dim Key As String
Dim Code As Integer = 1
Dim Tempo As Integer = 3
Dim T As Single = Tempo
Dim p0 As Integer = 0
Dim p1 As Integer = 1


Screen 19, , 2

Do
	If Code = 4 Or Code = 5 Then
		ScreenSet 1, 0
	Else
		ScreenSet 0, 0
	End If
	Do
		Select Case Code
		Case 2
			ScreenSync
		Case 3
			ScreenLock
		End Select
		Cls
		Draw_circle_recursion(10 + I, 300, 9 + I * I / 29 / 29, 10)
		Locate 1, 1
		Select Case Code
		Case 1
			Print "1. Draw/Print loop to screen with raw coding:"
			Print
			Print "   SCREEN 19, , 2 'to enable double-paging"
			Print "   SCREENSET 0, 0 'to cancel double-paging"
			Print
			Print " " & Chr(218) & Chr(196) & Chr(16) & " CLS"
			Print " " & Chr(179) & " " & " " & " Drawing"
			Print " " & Chr(179) & " " & " " & " Printing"
			Print " " & Chr(192) & Chr(196) & Chr(196) & " Temporizing"; T; " ms";
		Case 2
			Print "2. Draw/Print loop to screen with synchronizing:"
			Print
			Print "   SCREEN 19, , 2 'to enable double-paging"
			Print "   SCREENSET 0, 0 'to cancel double-paging"
			Print
			Print " " & Chr(218) & Chr(196) & Chr(16) & " SCREENSYNC"
			Print " " & Chr(179) & " " & " " & " CLS"
			Print " " & Chr(179) & " " & " " & " Drawing"
			Print " " & Chr(179) & " " & " " & " Printing"
			Print " " & Chr(192) & Chr(196) & Chr(196) & " Temporizing"; T; " ms";
		Case 3
			Print "3. Draw/Print loop to screen with locking:"
			Print
			Print "   SCREEN 19, , 2 'to enable double-paging"
			Print "   SCREENSET 0, 0 'to cancel double-paging"
			Print
			Print " " & Chr(218) & Chr(196) & Chr(16) & " SCREENLOCK"
			Print " " & Chr(179) & " " & " " & " CLS"
			Print " " & Chr(179) & " " & " " & " Drawing"
			Print " " & Chr(179) & " " & " " & " Printing"
			Print " " & Chr(179) & " " & " " & " SCREENUNLOCK"
			Print " " & Chr(192) & Chr(196) & Chr(196) & " Temporizing"; T; " ms";
		Case 4
			Print "4. Draw/Print loop to screen with double buffering:"
			Print
			Print "   SCREEN 19, , 2 'to enable double-paging"
			Print "   SCREENSET 1, 0 'to activate double-paging"
			Print
			Print " " & Chr(218) & Chr(196) & Chr(16) & " CLS"
			Print " " & Chr(179) & " " & " " & " Drawing"
			Print " " & Chr(179) & " " & " " & " Printing"
			Print " " & Chr(179) & " " & " " & " SCREENCOPY"
			Print " " & Chr(192) & Chr(196) & Chr(196) & " Temporizing"; T; " ms";
		Case 5
			Print "5. Draw/Print loop to screen with page flipping:"
			Print
			Print "   SCREEN 19, , 2 'to enable double-paging"
			Print "   SCREENSET 1, 0 'to activate double-paging"
			Print "   p0=0 : p1=1    'to initialize flipping"
			Print
			Print " " & Chr(218) & Chr(196) & Chr(16) & " CLS"
			Print " " & Chr(179) & " " & " " & " Drawing"
			Print " " & Chr(179) & " " & " " & " Printing"
			Print " " & Chr(179) & " " & " " & " SCREENSET p0, p1"
			Print " " & Chr(179) & " " & " " & " SWAP p0, p1"
			Print " " & Chr(192) & Chr(196) & Chr(196) & " Temporizing"; T; " ms";
		End Select
		Locate 30, 1
		Print "<1>: Draw/Print with raw coding"
		Print "<2>: Draw/Print with synchronizing"
		Print "<3>: Draw/Print with locking"
		Print "<4>: Draw/Print with double buffering"
		Print "<5>: Draw/Print with page flipping"
		Print "<+/->: Tempo setting (+/-)"
		Print
		Print "<Escape> or click [X]: Quit";
		Select Case Code
		Case 3
			ScreenUnlock
		Case 4
			ScreenCopy
		Case 5
			ScreenSet p0, p1
			Swap p0, p1
		End Select
		If I = 0 Then
			Inc = +1
		ElseIf I = 480 Then
			Inc = -1
		End If
		I = I + Inc
		Key = Inkey
		If Key = "+" And Tempo < 10 Then
			Tempo = Tempo + 1
		ElseIf Key = "-" And Tempo > 0 Then
			Tempo = Tempo - 1
		End If
		If Tempo > 0 Then
			T = Tempo
		Else
			T = 0.5
		End If
		Static As Integer K
		K += 1
		If K >= 25 / T Then
			Sleep 25
			K = 0
		End If
	Loop While Key <> "1" And Key <> "2" And Key <> "3" And Key <> "4" And Key <> "5" And Key <> Chr(27) And Key <> Chr(255) & "k"
	Code = Val(Key)
Loop Until Key = Chr(27) Or Key = Chr(255) & "k"


Sub Draw_circle_recursion ( ByVal x As Integer, ByVal y As Integer, ByVal r As Integer, ByVal rmin As Integer )
	Circle (x, y), r, r Shr 1
	If r > rmin Then
		Draw_circle_recursion(x + r Shr 1, y, r Shr 1, rmin)
		Draw_circle_recursion(x - r Shr 1, y, r Shr 1, rmin)
		Draw_circle_recursion(x, y + r Shr 1, r Shr 1, rmin)
		Draw_circle_recursion(x, y - r Shr 1, r Shr 1, rmin)
		Draw_circle_recursion(x + r Shr 1, y + r Shr 1, r Shr 2, rmin)
		Draw_circle_recursion(x - r Shr 1, y + r Shr 1, r Shr 2, rmin)
		Draw_circle_recursion(x + r Shr 1, y - r Shr 1, r Shr 2, rmin)
		Draw_circle_recursion(x - r Shr 1, y - r Shr 1, r Shr 2, rmin)
	End If
End Sub
					
