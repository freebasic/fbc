'' examples/manual/dates/dateserial.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDateSerial
'' --------

#include "vbcompat.bi"

Dim a As Double = DateSerial(2005, 11, 28)

Print Format(a, "yyyy/mm/dd hh:mm:ss") 
