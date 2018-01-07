'' examples/manual/check/KeyPgScreenevent_1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgEvent
'' --------

Type Event Field = 1
	Type As Long
	Union
		Type
			scancode As Long
			ascii As Long
		End Type
		Type
			x As Long
			y As Long
			dx As Long
			dy As Long
		End Type
		button As Long
		z As Long
		w As Long
	End Union
End Type
