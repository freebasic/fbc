'' examples/manual/operator/pointer-index.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator [] (Pointer index)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPtrIndex
'' --------

'' initialize a 5-element array
Dim array(4) As Integer = { 0, 1, 2, 3, 4 }

'' point to the first element
Dim p As Integer Ptr = @array(0)

'' use pointer indexing to output array elements
For index As Integer = 0 To 4
	Print p[index];
Next
Print
