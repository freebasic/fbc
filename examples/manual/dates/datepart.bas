'' examples/manual/dates/datepart.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DatePart'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDatePart
'' --------

#include "vbcompat.bi"

Dim d As Double

d = Now()

Print "Today is day " & DatePart( "y", d );
Print " in week " & DatePart( "ww", d );
Print " of the year " & DatePart( "yyyy", d )
