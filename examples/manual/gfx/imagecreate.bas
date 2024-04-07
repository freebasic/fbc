'' examples/manual/gfx/imagecreate.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'IMAGECREATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImagecreate
'' --------

'' Create a graphics screen.
ScreenRes 320, 200, 32

'' Create a 64x64 pixel image with a darkish green background.
Dim image As Any Ptr = ImageCreate( 64, 64, RGB(0, 128, 0) )

If image = 0 Then
	Print "Failed to create image."
	Sleep
	End -1
End If

'' Draw a semi-transparent, red circle in the center of the image.
Circle image, (32, 32), 28, RGBA(255, 0, 0, 128),,, 1.0, f

'' Draw the image onto the screen using various blitting methods.
Put (120, 60), image, PSet
Put (140, 80), image, Alpha

'' Destroy the image.
ImageDestroy image

Sleep
