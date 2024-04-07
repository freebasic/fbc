'' examples/manual/dates/timeserial.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TIMESERIAL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTimeserial
'' --------

#include "vbcompat.bi"

Dim ds As Double = DateSerial(2005, 11, 28) + TimeSerial(7, 30, 50)

Print Format(ds, "yyyy/mm/dd hh:mm:ss")
