'' examples/manual/gfx/paint2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PAINT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPaint
'' --------

' draws a circle and fills it with a checkered pattern

'' choose the bit depth for the Screen
'' try setting this to other values: 8, 16 or 32

Const bit_depth = 8

'' function for returning a pixel color, represented as a string
'' returns a the string in the appropriate format for the current bit depth
Function paint_pixel( ByVal c As ULong, ByVal bit_depth_ As Integer ) As String
	
	If bit_depth_ <= 8 Then '' 8-bit:
		Function =  Chr( CUByte(c) )
		
	ElseIf bit_depth_ <= 16 Then '' 16-bit:
		Function = MKShort( c Shr 3 And &h1f Or _
							c Shr 5 And &h7e0 Or _
							c Shr 8 And &hf800 )
		
	ElseIf bit_depth_ <= 32 Then '' 32-bit:
		Function = MKL(c)
		
	End If
	
End Function


'' open a graphics window at the chosen bit depth
ScreenRes 320, 200, bit_depth

'' declare variables for holding colors
Dim As ULong c, c1, c2, cb

'' declare string variable for holding the pattern used in Paint
Dim As String paint_pattern = ""

'' set colors
If bit_depth <= 8 Then
	c1 = 7  ''pattern color 1
	c2 = 8  ''pattern color 2
	cb = 15 ''border color
Else
	c1 = RGB(192, 192, 192) '' pattern color 1
	c2 = RGB(128, 128, 128) '' pattern color 2
	cb = RGB(255, 255, 255) '' border color
End If

'' make the pattern to be used in Paint
For y As UInteger = 0 To 7
	For x As UInteger = 0 To 7
		
		'' choose the color of the pixel (c)
		If (x \ 4 + y \ 4) Mod 2 > 0 Then
			c = c1
		Else
			c = c2
		End If
		
		'' add the pixel to the pattern
		paint_pattern = paint_pattern + paint_pixel(c, bit_depth)
		
		'' the following line can be used if you want to draw the 
		'' pattern tile in the top left hand corner of the screen:
		
		' pset (x, y), c
		
	Next x
Next y

'' draw a circle with the border color
Circle (160, 100), 50, cb, , , 1.0

'' paint the circle region with paint_pattern, stopping at the border color
Paint (160, 100), paint_pattern, cb

'' pause before ending the program
Sleep
