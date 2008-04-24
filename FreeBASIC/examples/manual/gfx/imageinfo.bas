'' examples/manual/gfx/imageinfo.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImageInfo
'' --------

Dim img As Any Ptr, pixdata As Any Ptr, pitch As Integer

'' Create 32-bit screen and image buffer
ScreenRes 320, 200, 32
img = ImageCreate(64, 64)


'' get pitch and pixel data pointer of image
ImageInfo img, ,,, pitch, pixdata

'' draw pattern directly into the image memory
For y As Integer = 0 To 63
	Dim As UInteger Ptr p = pixdata + y * pitch
   
	For x As Integer = 0 To 63
	    p[x] = RGB(x * 4, y * 4, (x Xor y) * 4)
	Next x
Next y


'' Put the image to screen
Put (10, 10), img

'' Free the image memory
ImageDestroy img

'' Wait for a keypress before closing
Sleep
