'' examples/manual/control/for-next.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFornext
'' --------

Print "counting from 3 to 0, with a step of -0.5"
For i As Single = 3 To 0 Step -0.5
	Print "i is " & i
Next i
