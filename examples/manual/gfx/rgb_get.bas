'' examples/manual/gfx/rgb_get.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RGB'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRgb
'' --------

'' setting and retrieving Red, Green, Blue and Alpha values

#define RGBA_R( c ) ( CULng( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CULng( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CULng( c )        And 255 )
#define RGBA_A( c ) ( CULng( c ) Shr 24         )

Dim As UByte r, g, b, a

Dim As ULong col = RGB(128, 192, 64)

Print Using "Color: _&H\      \"; Hex(col, 8)

r = RGBA_R( col )
g = RGBA_G( col )
b = RGBA_B( col )
a = RGBA_A( col )

Print
Print Using "Red:         _&H\\ = ###"; Hex(r, 2); r
Print Using "Green:       _&H\\ = ###"; Hex(g, 2); g
Print Using "Blue:        _&H\\ = ###"; Hex(b, 2); b
Print Using "Alpha:       _&H\\ = ###"; Hex(a, 2); a
	
