'' examples/manual/fileio/lof.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLof
'' --------

Dim f As Integer
f = FreeFile
Open "file.ext" For Binary As #f
Print LOF(f)
Close #f
