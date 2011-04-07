'' examples/manual/fileio/opencons.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpenCons
'' --------

Dim a As String

Open Cons For Input As #1
Open Cons For Output As #2

Print #2,"Please write something and press ENTER"
Line Input #1,a
Print #2, "You wrote : ";a

Close
Sleep
