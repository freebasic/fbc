'' examples/manual/gfx/pmap.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPmap
'' --------

ScreenRes 640, 480
Window Screen (0, 0)-(100, 100)
Print "Logical x=50, Physical x="; PMap(50, 0)   '' 320
Print "Logical y=50, Physical y="; PMap(50, 1)   '' 240
Print "Physical x=160, Logical x="; PMap(160, 2) '' 25
Print "Physical y=60, Logical y="; PMap(60, 3)   '' 12.5
Sleep
