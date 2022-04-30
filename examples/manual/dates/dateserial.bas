'' examples/manual/dates/dateserial.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DATESERIAL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDateSerial
'' --------

#include "vbcompat.bi"

Dim a As Long = DateSerial(2005, 11, 28)

Print Format(a, "yyyy/mm/dd hh:mm:ss") 
