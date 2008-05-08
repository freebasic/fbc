'' examples/manual/gfx/imagecreate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImagecreate
'' --------

Dim image_buffer As Any Ptr
Const NULL As Any Ptr = 0

'' set screen mode (this must be done before trying to create an image)
ScreenRes 320, 200, 32

'' allocate an image buffer with a darkish green background
image_buffer = ImageCreate(64, 64, RGB(0, 128, 0))

'' check that image creation succeeded
If image_buffer = NULL Then
	Print "Image creation failed!"
	Sleep
	End
End If

'' draw a semi-transparent, red circle to the image buffer
Circle image_buffer, (32, 32), 28, RGBA(255, 0, 0, 128),,, 1.0, F

'' blit image buffer to screen
Put (120, 60), image_buffer, PSet
Put (140, 80), image_buffer, Alpha

Sleep

'' free image buffer memory
ImageDestroy image_buffer
