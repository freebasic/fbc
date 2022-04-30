'' examples/manual/proguide/arrays/varlen_redim.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Variable-length Arrays'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgVarLenArrays
'' --------

'' Define an empty 1-dimensional variable-length array of SINGLE elements...
Dim array(Any) As Single

'' Resize the array to hold 10 SINGLE elements...
ReDim array(0 To 9) As Single

'' The data type may be omitted when resizing:
ReDim array(10 To 19)
