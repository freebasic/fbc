'' examples/manual/input/inkey.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'INKEY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInkey
'' --------

Print "press q to quit"
Do
	Sleep 1, 1
Loop Until Inkey = "q"
