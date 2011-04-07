'' examples/manual/control/goto.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGoto
'' --------

	Goto there

backagain:
	End

there:
	Print "Welcome!"
	Goto backagain
