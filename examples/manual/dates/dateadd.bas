'' examples/manual/dates/dateadd.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DateAdd'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDateAdd
'' --------

#include "vbcompat.bi"

Const fmt = "ddddd ttttt"
Dim d As Double
d = Now()

Print "1 hour from now is ";
Print Format( DateAdd( "h", 1, d ), fmt )

Print "1 day from now is ";
Print Format( DateAdd( "d", 1, d ), fmt )

Print "1 week from now is ";
Print Format( DateAdd( "ww", 1, d ), fmt )

Print "1 month from now is ";
Print Format( DateAdd( "m", 1, d ), fmt )
