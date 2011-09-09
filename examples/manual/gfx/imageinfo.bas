'' examples/manual/gfx/imageinfo.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImageInfo
'' --------

'' Create 32-bit graphics screen and image.
ScreenRes 320, 200, 32
Dim image As Any Ptr = ImageCreate( 64, 64 )

Dim pitch As Integer
Dim pixels As Any Ptr

'' Get enough information to iterate through the pixel data.
If 0 <> ImageInfo( image, ,,, pitch, pixels ) Then
	Print "unable to retrieve image information."
	Sleep
	End
End If

'' Draw a pattern on the image by directly manipulating pixel memory.
For y As Integer = 0 To 63
	Dim row As UInteger Ptr = pixels + y * pitch
	
	For x As Integer = 0 To 63
		row[x] = RGB(x * 4, y * 4, (x Xor y) * 4)
	Next x
Next y

'' Draw the image onto the screen.
Put (10, 10), image

ImageDestroy( image )

Sleep
