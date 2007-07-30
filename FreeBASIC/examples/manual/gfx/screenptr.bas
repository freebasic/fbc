'' examples/manual/gfx/screenptr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenptr
'' --------

Const w As Integer = 297
Const h As Integer = 210
Dim As Integer x, y

ScreenRes w, h, 8 ' 8-bit screen.

' Get the address of the 8 bit/pixel frame buffer. A
' ubyte ptr is used to simplify 8-bit pointer arithmetic.
Dim buffer As UByte Ptr = ScreenPtr()
If (buffer = 0) Then
	Print "error: graphics screen not initialized."
	End -1
End If

' Lock the screen to allow direct framebuffer access.
ScreenLock()

' Plot a green pixel in the middle of the screen.
x = w \ 2: y = h \ 2
buffer[y * w + x] = 10

' Unlock the screen.
ScreenUnlock()

Sleep
