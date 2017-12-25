'' examples/manual/proguide/arrays/varlen_redim.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgVarLenArrays
'' --------

'' Define an empty 1-dimensional variable-length array of SINGLE elements...
Dim array(Any) As Single

'' Resize the array to hold 10 SINGLE elements...
ReDim array(0 To 9) As Single

'' The data type may be omitted when resizing:
ReDim array(10 To 19)
