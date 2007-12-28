'' examples/manual/input/getmouse.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGetmouse
'' --------


' Set video mode and enter loop
Dim x As Integer, y As Integer, buttons As Integer
Dim res As Integer
Screen 13
Do
	' Get mouse x, y and buttons. Discard wheel position.
	res = GetMouse (x, y, , buttons)
	    'buttons
	Locate 1, 1
	If res <> 0 Then
		Print "Mouse not available or not on window"
	Else
		Print Using "Mouse position: ###:###  Buttons: "; x; y;
		If buttons And 1 Then Print "L";
		If buttons And 2 Then Print "R";
		If buttons And 4 Then Print "M";
		Print "   "
	End If
Loop While Inkey = ""
End
