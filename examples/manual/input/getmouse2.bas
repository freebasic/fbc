'' examples/manual/input/getmouse2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGetmouse
'' --------

'Example 2: type-union-type structure
Type mouse
	As Integer res
	As Integer x, y, wheel, clip
	Union
	    buttons As Integer
	    Type
	        Left:1 As Integer
	        Right:1 As Integer
	        middle:1 As Integer
	    End Type
	End Union
End Type
 
Screen 11
Dim As mouse m

Do
	m.res = GetMouse( m.x, m.y, m.wheel, m.buttons, m.clip )
	ScreenLock
	Cls
	Print Using "res = #"; m.res
	Print Using "x = ###; y = ###; wheel = +###; clip = ##"; m.x; m.y; m.wheel; m.clip
	Print Using "buttons = ##; left = #; middle = #; right = #"; m.buttons; m.left; m.middle; m.right
	ScreenUnlock
	Sleep 10, 1
Loop While Inkey = ""
