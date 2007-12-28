'' examples/manual/proguide/arrays/array3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgArrays
'' --------

' Creates a fixed-length array that holds 5 single elements.
Const totalSingles = 5
Dim flarray(1 To totalSingles) As Single

' Creates an empty variable-length array that holds integer values.
Dim vlarray() As Integer

' Resizes the array to 10 elements.
ReDim vlarray(1 To 10) As Integer
