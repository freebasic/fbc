'' examples/manual/dates/weekday.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WEEKDAY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWeekday
'' --------

#include "vbcompat.bi"

Dim a As Double = DateSerial (2005, 11, 28) + TimeSerial(7, 30, 50)

Print Format(a, "yyyy/mm/dd hh:mm:ss "); Weekday(a)
