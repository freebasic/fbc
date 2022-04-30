'' examples/manual/operator/arrayindex.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator () (Array index)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpArrayIndex
'' --------

Dim array(0 To 4) As Integer = { 0, 1, 2, 3, 4 }

For index As Integer = 0 To 4
	Print array(index);
Next
Print
