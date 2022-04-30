'' examples/manual/fileio/reset.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RESET'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgReset
'' --------

Open "test.txt" For Output As #1
Print #1, "testing 123"
Reset
