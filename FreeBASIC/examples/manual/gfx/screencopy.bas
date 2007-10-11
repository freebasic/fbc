'' examples/manual/gfx/screencopy.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreencopy
'' --------

'' 320x200x8, with 3 pages
Screen 13,,3

'' image for page #1
ScreenSet 1, 0
Cls
Circle( 160, 100 ), 90, 1 ,,,, f
Circle( 160, 100 ), 90, 15
Print "Press 2 to copy page #2 to visible page"
Print "Press escape to exit"

'' image for page #2
ScreenSet 2, 0
Cls
Line( 50, 50 )-( 270, 150 ), 2, bf
Line( 50, 50 )-( 270, 150 ), 15, b
Print "Press 1 to copy page #1 to visible page"
Print "Press escape to exit"

'' page #0 is the visible page
ScreenSet 0, 0
Cls
Print "Press 1 to copy page #1 to visible page"
Print "Press 2 to copy page #2 to visible page"
Print "Press escape to exit"

Dim k As String

Do
  k = Inkey
  Select Case k
  Case Chr(27)
	Exit Do
  Case "1"
	ScreenCopy 1, 0
  Case "2"
	ScreenCopy 2, 0
  End Select

  Sleep 25
Loop
