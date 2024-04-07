'' examples/manual/math/asin.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ASIN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAsin
'' --------

Dim h As Double
Dim o As Double
Input "Please enter the length of the hypotenuse of a triangle: ", h
Input "Please enter the length of the opposite side of the triangle: ", o
Print ""
Print "The angle between the sides is"; Asin ( o / h )
Sleep
