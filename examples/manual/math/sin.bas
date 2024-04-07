'' examples/manual/math/sin.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SIN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSin
'' --------

Const PI As Double = 3.1415926535897932
Dim a As Double
Dim r As Double
Input "Please enter an angle in degrees: ", a
r = a * PI / 180	'Convert the degrees to Radians
Print ""
Print "The sine of a" ; a; " degree angle is"; Sin ( r ) 
Sleep
