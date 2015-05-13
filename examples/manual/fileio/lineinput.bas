'' examples/manual/fileio/lineinput.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLineinputPp
'' --------

Dim s As String

Open "myfile.txt" For Output As #1
Print #1, "Hello, World"
Close #1

Open "myfile.txt" For Input As #1
Line Input #1, s
Close #1
Print s
