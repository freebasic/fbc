'' examples/manual/fileio/seek-statment.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSeekset
'' --------

' e.g. if you want to skip to the 100th byte in the file for reading/writing:

Dim f As Integer

f = FreeFile
Open "file.ext" For Binary As #f

Seek f, 100

Close #f
