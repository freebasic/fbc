'' examples/manual/proguide/arrays/array3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Arrays'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgArrays
'' --------

' Creates a fixed-length array that holds 5 single elements.
Const totalSingles = 5
Dim flarray(1 To totalSingles) As Single

' Creates an empty variable-length array that holds integer values.
Dim vlarray() As Integer

' Resizes the array to 10 elements.
ReDim vlarray(1 To 10)
	
