'' examples/manual/gfx/custom.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CUSTOM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCustomgfx
'' --------

Function dither ( ByVal source_pixel As ULong, ByVal destination_pixel As ULong, ByVal parameter As Any Ptr ) As ULong
	
	''either returns the source pixel or the destination pixel, depending on the outcome of rnd
	
	Dim threshold As Single = 0.5
	If parameter <> 0 Then threshold = *CPtr(Single Ptr, parameter)
	
	If Rnd() < threshold Then
		Return source_pixel
	Else
		Return destination_pixel
	End If
	
End Function


Dim img As Any Ptr, threshold As Single

'' set up a screen
ScreenRes 320, 200, 16, 2
ScreenSet 0, 1

'' create an image
img = ImageCreate(32, 32)
Line img, ( 0,  0)-(15,  15), RGB(255,   0,   0), bf
Line img, (16,  0)-(31,  15), RGB(  0,   0, 255), bf
Line img, ( 0, 16)-(15,  31), RGB(  0, 255,   0), bf
Line img, (16, 16)-(31,  31), RGB(255,   0, 255), bf

'' dither the image with varying thresholds
Do Until Len(Inkey)
	
	Cls
	
	threshold = 0.2
	Put ( 80 - 16, 100 - 16), img, Custom, @dither, @threshold
	
	'' default threshold = 0.5
	Put (160 - 16, 100 - 16), img, Custom, @dither
	
	threshold = 0.8
	Put (240 - 16, 100 - 16), img, Custom, @dither, @threshold
	
	ScreenCopy
	Sleep 25
	
Loop

'' free the image memory
ImageDestroy img
