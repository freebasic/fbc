'' examples/manual/variable/const.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgConst
'' --------

Const Red = RGB(252, 2, 4)
Const Black As UInteger = RGB(0, 0, 0)
Const Text = "This is red text on a black bkgnd."

Locate 1, 1
Color Red, Black
Print Text
Sleep
End
