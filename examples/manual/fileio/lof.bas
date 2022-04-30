'' examples/manual/fileio/lof.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LOF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLof
'' --------

Dim f As Long
f = FreeFile
Open "file.ext" For Binary As #f
Print LOF(f)
Close #f
