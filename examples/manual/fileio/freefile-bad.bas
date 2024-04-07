'' examples/manual/fileio/freefile-bad.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FREEFILE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFreefile
'' --------

Dim As Long fr, fs
' The WRONG way:
fr = FreeFile
fs = FreeFile '' fs has taken the same file number as fr

Open "file1" For Input As #fr
Open "file2" For Input As #fs '' error: file number already opened
