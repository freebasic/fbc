'' examples/manual/gfx/pixelptr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'IMAGEINFO'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImageInfo
'' --------

'' pixelptr(): use imageinfo() to find the pointer to a pixel in the image
'' returns null on error or x,y out of bounds
Function pixelptr(ByVal img As Any Ptr, ByVal x As Integer, ByVal y As Integer) As Any Ptr

	Dim As Long w, h, bypp, pitch
	Dim As Any Ptr pixdata
	Dim As Long success
	
	success = (ImageInfo(img, w, h, bypp, pitch, pixdata) = 0)
	
	If success Then
		If x < 0 Or x >= w Then Return 0
		If y < 0 Or y >= h Then Return 0
		Return pixdata + y * pitch + x * bypp
	Else
		Return 0
	End If
	
End Function

'' usage example:

'' 320*200 graphics screen, 8 bits per pixel
ScreenRes 320, 200, 8

Dim As Any Ptr ip '' image pointer

Dim As Byte Ptr pp '' pixel pointer (use byte for 8 bits per pixel)

ip = ImageCreate(32, 32) '' create an image (32*32, 8 bits per pixel)

If ip <> 0 Then

	'' draw a pattern on the image
	For y As Integer = 0 To 31

		For x As Integer = y - 5 To y + 5 Step 5

			'' find the pointer to pixel at x,y position
			'' note: this is inefficient to do for every pixel!
			pp = pixelptr(ip, x, y)

			'' if success, plot a value at the pixel
			If (pp <> 0) Then *pp = 15

		Next x

	Next y

	'' put the image and draw a border around it
	Put (10, 10), ip, PSet
	Line (9, 9)-Step(33, 33), 4, b

	'' destroy the image to reclaim memory
	ImageDestroy ip

Else
	Print "Error creating image!"
End If

Sleep
	
