'' examples/manual/check/KeyPgScreenevent_1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenevent
'' --------

Type EVENT Field = 1
	Type As Integer
	Union
		Type
			scancode As Integer
			ascii As Integer
		End Type
		Type
			x As Integer
			y As Integer
			dx As Integer
			dy As Integer
		End Type
		button As Integer
		z As Integer
	End Union
End Type
