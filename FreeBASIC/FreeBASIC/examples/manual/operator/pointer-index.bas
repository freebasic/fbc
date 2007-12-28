'' examples/manual/operator/pointer-index.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPtrIndex
'' --------

'' initialize a 5-element array
Dim array(4) As Integer = { 0, 1, 2, 3, 4 }

'' point to the first element
Dim p As Integer Ptr = @array(0)

'' use pointer indexing to output array elements
For index As Integer = 0 To 4
	Print p[index]
Next
