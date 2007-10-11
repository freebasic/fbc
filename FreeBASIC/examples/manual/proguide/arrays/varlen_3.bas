'' examples/manual/proguide/arrays/varlen_3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgVarLenArrays
'' --------

'' Define an empty variable-length array of SINGLE elements..
Dim array() As Single

'' Resize the array to hold ten (10) SINGLE elements..
ReDim array(9) As Single
