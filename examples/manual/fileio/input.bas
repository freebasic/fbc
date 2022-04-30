'' examples/manual/fileio/input.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'INPUT #'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInputPp
'' --------

Dim a As Integer
Dim b As String
Dim c As Single

Open "myfile.txt" For Output As #1
Write #1, 1, "Hello, World", 34.5
Close #1

Open "myfile.txt" For Input As #1
Input #1, a, b, c
Close #1
Print a, b, c
