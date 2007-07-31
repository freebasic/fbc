'' examples/manual/fileio/print.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPrintPp
'' --------

Open "bleh.dat"  For Output As #1
	
	Print #1, "abc def"
	Print #1, 1234, 5678.901, "xyz zzz"
	
	Close #1
