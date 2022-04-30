'' examples/manual/faq/gfxlib2/RGB-component.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Frequently Asked FreeBASIC Graphics Library Questions'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=FaqPggfxlib2
'' --------

#define rgb_a(x) ((x) Shr 24)
#define rgb_r(x) ((x) Shr 16 And 255)
#define rgb_g(x) ((x) Shr 8 And 255)
#define rgb_b(x) ((x) And 255)

Dim As UInteger c
Dim As Integer x, y
Dim As UByte red, green, blue, Alpha

'' Assume a 16, 24, or 32 bit screen mode has been set
c = Point(x, y)
red = rgb_r(c)
green = rgb_g(c)
blue = rgb_b(c)
Alpha = rgb_a(c)
