'' examples/manual/dates/hour.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'HOUR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgHour
'' --------

#include "vbcompat.bi"

Dim ds As Double = DateSerial(2005, 11, 28) + TimeSerial(7, 30, 50)

Print Format(ds, "yyyy/mm/dd hh:mm:ss "); Hour(ds)
