'' examples/manual/math/acos.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAcos
'' --------

Dim h As Double
Dim a As Double
Input "Please enter the length of the hypotenuse of a triangle: ", h
Input "Please enter the length of the adjacent side of the triangle: ", a
Print ""
Print "The angle between the sides is"; Acos ( a / h )
Sleep
