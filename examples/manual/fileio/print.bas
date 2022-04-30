'' examples/manual/fileio/print.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '(PRINT | ?) #'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPrintPp
'' --------

Open "bleh.dat"  For Output As #1
	
	Print #1, "abc def"
	Print #1, 1234, 5678.901, "xyz zzz"
	
	Close #1
