'' examples/manual/proguide/dates.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgDates
'' --------

#include "vbcompat.bi"
Dim a As Double, b As Double

a = 0
Print "The origin of the date serials is:"
Print Format(a, "yyyy/mm/dd hh:mm:ss")
Print

a = Now
Print "The time now is: "
Print Format(a, "yyyy/mm/dd hh:mm:ss")
Print

b = DateSerial(2000,1,1)
Print Int(a-b) & " days have passed since 2000/01/01"
