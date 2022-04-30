'' examples/manual/input/stick.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'STICK'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgStick
'' --------

'' Compile with -lang qb

'$lang: "qb"

Screen 12

Do
	Locate 1, 1
	Print "Joystick A-X position : "; Stick(0); "   "
	Print "Joystick A-Y position : "; Stick(1); "   "
	Print "Joystick B-X position : "; Stick(2); "   "
	Print "Joystick B-Y position : "; Stick(3); "   "
	Print
	Print "Button A1 was pressed : "; Strig(0); "  "
	Print "Button A1 is pressed  : "; Strig(1); "  "
	Print "Button B1 was pressed : "; Strig(2); "  "
	Print "Button B1 is pressed  : "; Strig(3); "  "
	Print "Button A2 was pressed : "; Strig(4); "  "
	Print "Button A2 is pressed  : "; Strig(5); "  "
	Print "Button B2 was pressed : "; Strig(6); "  "
	Print "Button B2 is pressed  : "; Strig(7); "  "
	Print
	Print "Press ESC to Quit"

	If Inkey$ = Chr$(27) Then
		Exit Do
	End If

	Sleep 1

Loop
