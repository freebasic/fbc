'' examples/manual/gfx/imageconvertrow.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImageConvertRow
'' --------

Const As Integer w = 64, h = 64
Dim As Any Ptr img8, img32
Dim As Integer i, y

'' create a 32-bit image, size w*h:
ScreenRes 320, 200, 32, , -1
img32 = ImageCreate(w, h)

'' create an 8-bit image, size w*h:
ScreenRes 320, 200, 8, , -1
img8 = ImageCreate(w, h)

'' spatter some random dots into the image:
For i = 1 To 1000
	PSet img8, ( Int(Rnd * w), Int(Rnd * h) ), Int(Rnd * 256)
Next i

'' open a graphics window in 8-bit mode, and PUT the image into it:
ScreenRes 320, 200, 8
WindowTitle "8-bit color mode"
Put (10, 10), img8

Sleep

'' copy the image data into a 32-bit image
For y = 0 To h - 1
	ImageConvertRow(img8  + (4 + y * w    ),  8, _
	                img32 + (4 + y * w * 4), 32, _
	                w)
Next y

'' open a graphics window in 32-bit mode and PUT the image into it:
ScreenRes 320, 200, 32
WindowTitle "32-bit color mode"
Put (10, 10), img32

Sleep

'' remove the images from memory:
ImageDestroy img8
ImageDestroy img32
