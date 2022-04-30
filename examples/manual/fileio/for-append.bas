'' examples/manual/fileio/for-append.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'APPEND'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAppend
'' --------

Dim i As Integer
For i = 1 To 10
	Open "test.txt" For Append As #1
	Print #1, "extending test.txt"
	Close #1
Next
