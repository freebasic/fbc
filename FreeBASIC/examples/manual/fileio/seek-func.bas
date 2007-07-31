'' examples/manual/fileio/seek-func.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSeekreturn
'' --------

Dim f As Integer, position As Integer

f = FreeFile
Open "file.ext" For Binary As #f

position = Seek(f)

Close #f
