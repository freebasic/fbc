'' examples/manual/gfx/put.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PUT (GRAPHICS)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPutgraphics
'' --------

'' set up the screen and fill the background with a color
ScreenRes 320, 200, 32
Paint (0, 0), RGB(64, 128, 255)

'' set up an image and draw something in it
Dim img As Any Ptr = ImageCreate( 32, 32, RGB(255, 0, 255) )
Circle img, (16, 16), 15, RGB(255, 255, 0),     ,     , 1, f
Circle img, (10, 10), 3,  RGB(  0,   0, 0),     ,     , 2, f
Circle img, (23, 10), 3,  RGB(  0,   0, 0),     ,     , 2, f
Circle img, (16, 18), 10, RGB(  0,   0, 0), 3.14, 6.28

'' PUT the image in the center of the screen
Put (160 - 16, 100 - 16), img, Trans

'' free the image memory
ImageDestroy img

'' wait for a keypress
Sleep
