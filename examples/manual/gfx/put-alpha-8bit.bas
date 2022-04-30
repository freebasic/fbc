'' examples/manual/gfx/put-alpha-8bit.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ALPHA'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAlphaGfx
'' --------

Dim As Any Ptr img8, img32
Dim As Integer x, y, i

'' Set up an 8-bit graphics screen
ScreenRes 320, 200, 8
For i = 0 To 255
	Palette i,  i, i, i
Next i
Color 255, 0

'' Create an 8-bit image
img8 = ImageCreate(64, 64, 0,  8)
For y = 0 To 63
	For x = 0 To 63
		Dim As Single x2 = x - 31.5, y2 = y - 31.5
		Dim As Single t = Sqr(x2 ^ 2 + y2 ^ 2) / 5
		PSet img8, (x, y), Sin(t) ^ 2 * 255
	Next x
Next y

Draw String (16, 4), "8-bit Alpha sprite"
Put (16, 16), img8
Sleep


'' Set up a 32-bit graphics screen
ScreenRes 320, 200, 32
For y = 0 To 199
	For x = 0 To 319
		PSet (x, y), IIf(x - y And 3, RGB(160, 160, 160), RGB(128, 128, 128))
	Next x
Next y

'' Create a 32-bit, fully opaque sprite
img32 = ImageCreate(64, 64, 0, 32)
For y = 0 To 63
	For x = 0 To 63
		PSet img32, (x, y), RGB(x * 4, y * 4, 128)
	Next x
Next y

Draw String (16, 4), "Original Alpha channel"
Put (16, 16), img32, Alpha

'' Put a new alpha channel using the 8-bit image
Put img32, (0, 0), img8, Alpha

Draw String (16, 104), "New Alpha channel"
Put (16, 116), img32, Alpha

''Free the memory for the two images
ImageDestroy img8
ImageDestroy img32

Sleep
