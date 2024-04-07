'' examples/manual/variable/const.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgConst
'' --------

Const Red = RGB(252, 2, 4)
Const Black As UInteger = RGB(0, 0, 0)
Const Text = "This is red text on a black bkgnd."

Locate 1, 1
Color Red, Black
Print Text
Sleep
End
