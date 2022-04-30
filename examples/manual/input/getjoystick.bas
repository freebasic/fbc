'' examples/manual/input/getjoystick.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'GETJOYSTICK'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGetjoystick
'' --------

Screen 12

Dim x As Single
Dim y As Single
Dim buttons As Integer
Dim result As Long
Dim a As Integer

Const JoystickID = 0

'This line checks to see if the joystick is ok.

If GetJoystick(JoystickID,buttons,x,y) Then 
	Print "Joystick doesn't exist or joystick error."
	Print
	Print "Press any key to continue."
	Sleep
	End
End If


Do
	result = GetJoystick(JoystickID,buttons,x,y)

	Locate 1,1
	Print ;"result:";result;" x:" ;x;" y:";y;" Buttons:";buttons,"","",""
	
	'This tests to see which buttons from 1 to 27 are pressed. 
	For a = 0 To 26 
		If (buttons And (1 Shl a)) Then 
			Print "Button ";a;" pressed.    "
		Else 
			Print "Button ";a;" not pressed."
		End If
	Next a
Loop
