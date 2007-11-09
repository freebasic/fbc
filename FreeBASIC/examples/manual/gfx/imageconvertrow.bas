'' examples/manual/gfx/imageconvertrow.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImageConvertRow
'' --------

#include "fbgfx.bi"
Using FB

Const As Integer w = 64, h = 64
Dim As IMAGE Ptr img8, img32
Dim As Integer i, y

'' create a 32-bit image, size w*h:
ScreenRes 320, 200, 32, , GFX_NULL
img32 = ImageCreate(w, h)

If img32 = 0 Then Print "Imagecreate failed on img32!": Sleep: End
If img32->Type <> PUT_HEADER_NEW Then Print "img32 wrong format!": ImageDestroy img32: Sleep: End

'' create an 8-bit image, size w*h:
ScreenRes 320, 200, 8, , GFX_NULL
img8 = ImageCreate(w, h)

If img8 = 0 Then Print "Imagecreate failed on img8!": Sleep: End
If img8->Type <> PUT_HEADER_NEW Then Print "img8 wrong format!": ImageDestroy img8: Sleep: End

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
Dim As UByte Ptr p8 = CPtr(UByte Ptr, img8) + SizeOf(IMAGE)
Dim As UByte Ptr p32 = CPtr(UByte Ptr, img32) + SizeOf(IMAGE)
Dim As UInteger pitch8 = img8->pitch, pitch32 = img32->pitch
For y = 0 To h - 1
	ImageConvertRow(p8  + y * pitch8 ,  8, _
	                p32 + y * pitch32, 32, _
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
