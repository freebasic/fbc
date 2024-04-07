'' examples/manual/math/sqr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SQR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSqr
'' --------

'' Example of Sqr function: Pythagorean theorem 
Dim As Single a, b

Print "Pythagorean theorem, right-angled triangle"
Print
Input "Please enter one leg side length: ", a
Input "Please enter the other leg side length: ", b
Print 
Print "The hypotenuse has a length of: " & Sqr( a * a + b * b )
