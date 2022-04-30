'' examples/manual/console/winput.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WINPUT()'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWinput
'' --------

Dim char As WString * 2

Dim filename As String, enc As String
Dim f As Long

Line Input "Please enter a file name: ", filename
Line Input "Please enter an encoding type (optional): ", enc
If enc = "" Then enc = "ascii"

f = FreeFile
If Open(filename For Input Encoding enc As #f) = 0 Then
	
	Print "Press space to read a character from the file, or escape to exit."
	
	Do
		
		Select Case Input(1)
		
		Case " " 'Space
			
			If EOF(f) Then
				
				Print "You have reached the end of the file."
				Exit Do
				
			End If
			
			char = WInput(1, f)
			Print char & " (char no " & Asc(char) & ")"
			
		Case Chr(27) 'Escape
			
			Exit Do
			
		End Select
		
	Loop
	
	Close #f
	
Else
	
	Print "There was an error opening the file."
	
End If
