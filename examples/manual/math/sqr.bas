'' examples/manual/math/sqr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
