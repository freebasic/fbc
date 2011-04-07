'' examples/manual/fileio/for-append.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAppend
'' --------

Dim i As Integer
For i = 1 To 10
	Open "test.txt" For Append As #1
	Print #1, "extending test.txt"
	Close #1
Next
