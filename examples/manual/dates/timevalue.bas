'' examples/manual/dates/timevalue.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TIMEVALUE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTimeValue
'' --------

#include "vbcompat.bi"

Dim ds As Double = TimeValue("07:12:28AM")

Print Format(ds, "hh:mm:ss")
