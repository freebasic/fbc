'' examples/manual/proguide/arrays/fixedlen_bounds.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgFixLenArrays
'' --------

Dim a(1) As Integer  '' 1-dimensional, 2 elements (0 and 1)
Dim b(0 To 1) As Integer  '' 1-dimensional, 2 elements (0 and 1)
Dim c(5 To 10) As Integer  '' 1-dimensional, 5 elements (5, 6, 7, 8, 9 and 10)

Dim d(1 To 2, 1 To 2) As Integer  '' 2-dimensional, 4 elements: (1,1), (1,2), (2,1), (2,2)
Dim e(99, 99, 99, 99) As Integer '' 4-dimensional, 100 * 100 * 100 * 100 elements
