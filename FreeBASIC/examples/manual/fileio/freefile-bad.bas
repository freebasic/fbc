'' examples/manual/fileio/freefile-bad.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFreefile
'' --------

Dim fr As Integer, fs As Integer
' The WRONG way:
fr = FreeFile
fs = FreeFile '' fs has taken the same file number as fr

Open "file1" For Input As #fr
Open "file2" For Input As #fs '' error: file number already opened
