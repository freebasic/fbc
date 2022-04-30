'' examples/manual/gfx/put-and.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'AND'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAndGfx
'' --------

''open a graphics window
ScreenRes 320, 200, 16
Line (0, 0)-(319, 199), RGB(255, 255, 255), bf

''create 3 sprites containing cyan, magenta and yellow circles
Const As Integer r = 32
Dim As Any Ptr cc, cm, cy
cc = ImageCreate(r * 2 + 1, r * 2 + 1, RGBA(255, 255, 255, 255))
cm = ImageCreate(r * 2 + 1, r * 2 + 1, RGBA(255, 255, 255, 255))
cy = ImageCreate(r * 2 + 1, r * 2 + 1, RGBA(255, 255, 255, 255))
Circle cc, (r, r), r, RGB(0, 255, 255), , , 1, f
Circle cm, (r, r), r, RGB(255, 0, 255), , , 1, f
Circle cy, (r, r), r, RGB(255, 255, 0), , , 1, f

''put the three sprites, overlapping each other in the middle
Put (146 - r, 108 - r), cc, And
Put (174 - r, 108 - r), cm, And
Put (160 - r,  84 - r), cy, And

''free the memory used by the sprites
ImageDestroy cc
ImageDestroy cm
ImageDestroy cy

''pause the program before closing
Sleep
