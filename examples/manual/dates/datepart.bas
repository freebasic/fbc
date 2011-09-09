'' examples/manual/dates/datepart.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDatePart
'' --------

#include "vbcompat.bi"

Dim d As Double

d = Now()

Print "Today is day " & DatePart( "y", d );
Print " in week " & DatePart( "ww", d );
Print " of the year " & DatePart( "yyyy", d )
