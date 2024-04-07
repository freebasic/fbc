'' examples/manual/dates/day.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DAY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDay
'' --------

#include "vbcompat.bi"

Dim ds As Long = DateSerial(2005, 11, 28)

Print Format(ds, "yyyy/mm/dd "); Day(ds)
