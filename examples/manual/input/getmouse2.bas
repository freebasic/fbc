'' examples/manual/input/getmouse2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'GETMOUSE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGetmouse
'' --------

'Example 2: type-union-type structure
Type mouse
	As Long res
	As Long x, y, wheel, clip
	Union
		buttons As Long
		Type
			Left:1 As Long
			Right:1 As Long
			middle:1 As Long
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
