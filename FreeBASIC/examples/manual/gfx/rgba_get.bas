'' examples/manual/gfx/rgba_get.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRgba
'' --------

'' setting and retrieving Red, Green, Blue and Alpha values

#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

Dim As UInteger r, g, b, a

Dim As UInteger col = RGBA(255, 192, 64, 128)

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
