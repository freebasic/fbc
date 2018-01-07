'' examples/manual/dates/timevalue.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTimeValue
'' --------

#include "vbcompat.bi"

Dim ds As Double = TimeValue("07:12:28AM")

Print Format(ds, "hh:mm:ss")
