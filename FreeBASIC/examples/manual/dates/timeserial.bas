'' examples/manual/dates/timeserial.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTimeserial
'' --------

#include "vbcompat.bi"

Dim ds As Double = DateSerial(2005, 11, 28) + TimeSerial(7, 30, 50)

Print Format(ds, "yyyy/mm/dd hh:mm:ss")
