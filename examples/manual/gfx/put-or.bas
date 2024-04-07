'' examples/manual/gfx/put-or.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOrGfx
'' --------

''open a graphics window
ScreenRes 320, 200, 16

''create 3 sprites containing red, green and blue circles
Const As Long r = 32
Dim As Any Ptr cr, cg, cb
cr = ImageCreate(r * 2 + 1, r * 2 + 1, RGBA(0, 0, 0, 0))
cg = ImageCreate(r * 2 + 1, r * 2 + 1, RGBA(0, 0, 0, 0))
cb = ImageCreate(r * 2 + 1, r * 2 + 1, RGBA(0, 0, 0, 0))
Circle cr, (r, r), r, RGB(255, 0, 0), , , 1, f
Circle cg, (r, r), r, RGB(0, 255, 0), , , 1, f
Circle cb, (r, r), r, RGB(0, 0, 255), , , 1, f

''put the sprite at three different multipier
''levels, overlapping each other in the middle
Put (146 - r, 108 - r), cr, Or
Put (174 - r, 108 - r), cg, Or
Put (160 - r,  84 - r), cb, Or

''free the memory used by the sprites
ImageDestroy cr
ImageDestroy cg
ImageDestroy cb

''pause the program before closing
Sleep
