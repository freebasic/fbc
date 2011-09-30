'' examples/manual/gfx/pmap.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPmap
'' --------

Screen 12
Window Screen (0, 0)-(100, 100)
Print "Logical x=50, Physical x="; PMap(50, 0)
Print "Logical y=50, Physical y="; PMap(50, 1)
Print "Physical x=160, Logical x="; PMap(160, 2)
Print "Physical y=60, Logical y="; PMap(60, 3)
Sleep
