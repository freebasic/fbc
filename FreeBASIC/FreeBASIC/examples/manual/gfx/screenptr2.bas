'' examples/manual/gfx/screenptr2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenptr
'' --------

Const w As Integer = 800
Const h As Integer = 600

ScreenRes w, h, 32 ' 32-bit screen.

' Get the address of the 32 bit/pixel frame buffer. A
' uinteger ptr is used to simplify 32-bit pointer arithmetic.
Dim buffer As UInteger Ptr = ScreenPtr()
If (buffer = 0) Then
	Print "error: graphics screen not initialized."
	End -1
End If

' Lock the screen to allow direct framebuffer access.
ScreenLock()

' Plot a green pixel at (400, 300).
buffer[400 + w * 300] = RGB(0, 255, 0)

' Unlock the screen.
ScreenUnlock()

Sleep
