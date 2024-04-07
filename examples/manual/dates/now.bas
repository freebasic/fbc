'' examples/manual/dates/now.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'NOW'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgNow
'' --------

#include "vbcompat.bi"

Dim a As Double = Now()

Print Format(a, "yyyy/mm/dd hh:mm:ss") 
