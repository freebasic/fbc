'' examples/manual/gfx/bload2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BLOAD'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBload
'' --------

'Load a 48x48 bitmap into an image
ScreenRes 320, 200, 32
Dim myImage As Any Ptr = ImageCreate( 48, 48 )
BLoad "picture.bmp", myImage
Put (10,10), myImage
ImageDestroy( myImage )
Sleep
