'' examples/manual/operator/arrayindex.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpArrayIndex
'' --------

Dim array(4) As Integer = { 0, 1, 2, 3, 4 }

For index As Integer = 0 To 4
	Print array(index)
Next
