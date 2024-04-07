'' examples/manual/control/goto.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'GOTO'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGoto
'' --------

	Goto there

backagain:
	End

there:
	Print "Welcome!"
	Goto backagain
