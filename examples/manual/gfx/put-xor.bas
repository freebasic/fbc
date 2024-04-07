'' examples/manual/gfx/put-xor.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'XOR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgXorGfx
'' --------

''open a graphics window
ScreenRes 320, 200, 16

''create a sprite containing a circle
Const As Integer r = 32
Dim c As Any Ptr = ImageCreate(r * 2 + 1, r * 2 + 1, 0)
Circle c, (r, r), r, RGBA(255, 255, 255, 0), , , 1, f

''put the three sprites, overlapping each other in the middle
Put (146 - r, 108 - r), c, Xor
Put (174 - r, 108 - r), c, Xor
Put (160 - r,  84 - r), c, Xor

''free the memory used by the sprite
ImageDestroy c

''pause the program before closing
Sleep
