'' examples/manual/fileio/freefile-good.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFreefile
'' --------

Dim fr As Integer, fs As Integer
' The CORRECT way:
fr = FreeFile
Open "File1" For Input As #fr

fs = FreeFile
Open "File2" For Input As #fs
