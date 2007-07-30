'' examples/manual/switches/option-escape3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionescape
'' --------

' compile with -lang deprecated
#include "crt.bi"
Option Escape
Dim As Integer a = 2, b = 3
printf("%d * %d = %d\r\n", a, b, a * b)
