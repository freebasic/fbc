'' examples/manual/gfx/screen.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreengraphics
'' --------

' Sets fullscreen 640x480 with 32bpp color depth and 4 pages
Screen 18, 32, 4, 1
If ScreenPtr = 0 Then
	Print "Error setting video mode!"
	End
End If
