'' examples/manual/fileio/reset.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgReset
'' --------

Open "test.txt" For Output As #1
Print #1, "testing 123"
Reset
