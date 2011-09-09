'' examples/manual/input/inkey.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInkey
'' --------

Print "press q to quit"
Do
	Sleep 1, 1
Loop Until Inkey = "q"
