'' examples/manual/proguide/dates.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Date Serials'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgDates
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
