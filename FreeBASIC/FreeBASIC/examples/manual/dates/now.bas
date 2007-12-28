'' examples/manual/dates/now.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgNow
'' --------

#include "vbcompat.bi"

Dim a As Double = Now()

Print Format(a, "yyyy/mm/dd hh:mm:ss") 
