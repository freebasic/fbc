'' examples/manual/math/sqr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSqr
'' --------

Dim a As Single
Dim b As Single

Input "Please enter one side of a right triangle: ",a
Input "Please enter another side of a right triangle: ",b
Print ""
Print "The hypotenuse of the triangle has a length of"; Sqr ( a * a + b * b )

Sleep
