'' examples/manual/switches/option-escape.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPTION ESCAPE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionescape
'' --------

'' Compile with the "-lang fblite" compiler switch

#lang "fblite"

Option Escape

Print "Warning \a\t The path is:\r\n c:\\Freebasic\\Examples"
Print $"This string doesn't have expanded escape sequences: \r\n\t"

#include "crt.bi"

Dim As Integer a = 2, b = 3
printf("%d * %d = %d\r\n", a, b, a * b)
