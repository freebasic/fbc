'' examples/manual/math/acos.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ACOS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAcos
'' --------

Dim h As Double
Dim a As Double
Input "Please enter the length of the hypotenuse of a triangle: ", h
Input "Please enter the length of the adjacent side of the triangle: ", a
Print ""
Print "The angle between the sides is"; Acos ( a / h )
Sleep
