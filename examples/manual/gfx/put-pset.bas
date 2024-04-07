'' examples/manual/gfx/put-pset.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PSET'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPsetGfx
'' --------

'' set up a screen: 320 * 200, 16 bits per pixel
ScreenRes 320, 200, 16
Line (0, 0)-(319, 199), RGB(0, 128, 255), bf

'' set up an image with the mask color as the background.
Dim img As Any Ptr = ImageCreate( 33, 33, RGB(255, 0, 255) )
Circle img, (16, 16), 15, RGB(255, 255, 0),     ,     , 1, f
Circle img, (10, 10), 3,  RGB(  0,   0, 0),     ,     , 2, f
Circle img, (23, 10), 3,  RGB(  0,   0, 0),     ,     , 2, f
Circle img, (16, 18), 10, RGB(  0,   0, 0), 3.14, 6.28

Dim As Integer x = 160 - 16, y = 100 - 16

'' Put the image with PSET
Put (x, y), img, PSet

'' free the image memory
ImageDestroy img

'' wait for a keypress
Sleep
