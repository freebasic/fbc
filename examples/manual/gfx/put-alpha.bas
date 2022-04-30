'' examples/manual/gfx/put-alpha.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ALPHA'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAlphaGfx
'' --------

'' Set up a 32-bit screen
ScreenRes 320, 200, 32

'' Draw checkered background
For y As Integer = 0 To 199
	For x As Integer = 0 To 319
		PSet (x, y), IIf((x Shr 2 Xor y Shr 2) And 1, RGB(160, 160, 160), RGB(128, 128, 128))
	Next x
Next y

'' Make image sprite for Putting
Dim img As Any Ptr = ImageCreate(32, 32, RGBA(0, 0, 0, 0))
For y As Single = -15.5 To 15.5
	For x As Single = -15.5 To 15.5
		Dim As Integer r, g, b, a
		If y <= 0 Then
			If x <= 0 Then
				r = 255: g = 0: b = 0   '' red
			Else
				r = 0: g = 0: b = 255   '' blue
			End If
		Else
			If x <= 0 Then
				r = 0: g = 255: b = 0   '' green
			Else
				r = 255: g = 0: b = 255 '' magenta (transparent mask color)
			End If
		End If
		a = 255 - (x ^ 2 + y ^ 2)
		If a < 0 Then a = 0': r = 255: g = 0: b = 255
		PSet img, (15.5 + x, 15.5 - y), RGBA(r, g, b, a)
	Next x
Next y

'' Put with single Alpha value, Trans for comparison
Draw String (32, 10), "Single alpha"
Put (80 - 16,  50 - 16), img, Alpha, 64
Put (80 - 16, 100 - 16), img, Alpha, 192
Put (80 - 16, 150 - 16), img, Trans

'' Put with full Alpha channel
Draw String (200, 10), "Full alpha"
Put (240 - 16, 100 - 16), img, Alpha

'' Free the image memory
ImageDestroy img

'' Wait for a keypress
Sleep
