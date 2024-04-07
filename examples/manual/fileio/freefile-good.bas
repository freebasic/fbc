'' examples/manual/fileio/freefile-good.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FREEFILE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFreefile
'' --------

Dim As Long fr, fs
' The CORRECT way:
fr = FreeFile
Open "File1" For Input As #fr

fs = FreeFile
Open "File2" For Input As #fs
