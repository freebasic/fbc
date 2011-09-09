'' examples/manual/dates/month.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMonth
'' --------

#include "vbcompat.bi"

Dim a As Double = DateSerial(2005,11,28) + TimeSerial(7,30,50)

Print Format(a, "yyyy/mm/dd hh:mm:ss "); Month(a)
