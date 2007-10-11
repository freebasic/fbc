'' examples/manual/dates/day.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDay
'' --------

#include "vbcompat.bi"

Dim ds As Double = DateSerial(2005, 11, 28)

Print Format(ds, "yyyy/mm/dd "); Day(ds)
