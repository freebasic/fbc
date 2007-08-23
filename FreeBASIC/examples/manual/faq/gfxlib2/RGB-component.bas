'' examples/manual/faq/gfxlib2/RGB-component.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=FaqPggfxlib2
'' --------

#define rgb_a(x) ((x) Shr 24)
#define rgb_r(x) ((x) Shr 16 And 255)
#define rgb_g(x) ((x) Shr 8 And 255)
#define rgb_b(x) ((x) And 255)

dim as uinteger c
dim as integer x, y
dim as ubyte red, green, blue, alpha

'' Assume a 16, 24, or 32 bit screen mode has been set
c = Point(x, y)
red = rgb_r(c)
green = rgb_g(c)
blue = rgb_b(c)
Alpha = rgb_a(c)
