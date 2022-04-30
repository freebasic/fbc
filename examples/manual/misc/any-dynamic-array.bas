'' examples/manual/misc/any-dynamic-array.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ANY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAny
'' --------

Dim a(Any) As Integer ' 1-dimensional dynamic array
Dim b(Any, Any) As Integer ' 2-dimensional dynamic array
Dim c(Any, Any, Any) As Integer ' 3-dimensional dynamic array
' etc.

' Further Redims or array accesses must have a matching amount of dimensions
ReDim a(0 To 1)
ReDim b(1 To 10, 2 To 5)
ReDim c(0 To 9, 0 To 5, 0 To 1)
