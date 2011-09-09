'' examples/manual/math/asin.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAsin
'' --------

Dim h As Double
Dim o As Double
Input "Please enter the length of the hypotenuse of a triangle: ", h
Input "Please enter the length of the opposite side of the triangle: ", o
Print ""
Print "The angle between the sides is"; Asin ( o / h )
Sleep
