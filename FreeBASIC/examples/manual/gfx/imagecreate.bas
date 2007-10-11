'' examples/manual/gfx/imagecreate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImagecreate
'' --------

'' set screen mode (400 * 300, 32 bits per pixel)
Screen 15, 32

'' allocate and draw to an image buffer
Dim image_buffer As Any Ptr
image_buffer = ImageCreate( 64, 64, RGBA( 64, 160, 0, 255 ) )
Circle image_buffer, ( 32, 32 ), 28, RGBA( 255, 0, 0, 128 ),,,,F

'' blit image buffer to screen
Put( 160, 120 ), image_buffer, PSet
Put( 180, 140 ), image_buffer, Alpha

Sleep

'' free image buffer memory
ImageDestroy( image_buffer )
