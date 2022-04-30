'' examples/manual/gfx/screenptr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREENPTR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenptr
'' --------

Const SCREEN_WIDTH = 640, SCREEN_HEIGHT = 480
Dim As Long w, h, bypp, pitch

'' Make 8-bit screen.
ScreenRes SCREEN_WIDTH, SCREEN_HEIGHT, 8

'' Get screen info (w and h should match the constants above, bypp should be 1)
ScreenInfo w, h, , bypp, pitch

'' Get the address of the frame buffer. An Any Ptr 
'' is used here to allow simple pointer arithmetic
Dim buffer As Any Ptr = ScreenPtr()
If (buffer = 0) Then
	Print "Error: graphics screen not initialized."
	Sleep
	End -1
End If

'' Lock the screen to allow direct frame buffer access
ScreenLock()
	
	'' Find the address of the pixel in the centre of the screen
	'' It's an 8-bit pixel, so use a UByte Ptr.
	Dim As Integer x = w \ 2, y = h \ 2
	Dim As UByte Ptr pixel = buffer + (y * pitch) + (x * bypp)
	
	
	'' Set the center pixel color to 10 (light green).
	*pixel = 10

'' Unlock the screen.
ScreenUnlock()

'' Wait for the user to press a key before closing the program
Sleep
