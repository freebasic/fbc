'' examples/manual/control/for-next3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFornext
'' --------

For ub As UByte = 240 To 255 '' Infinite loop because the end criterion value (255+1=256) can never be reached by the UByte iterator
	Print ub
	If Inkey <> "" Then Exit For
	Sleep 10
Next ub
