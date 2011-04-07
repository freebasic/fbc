'' examples/manual/control/until.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUntil
'' --------

Dim a As Integer

a = 1
Do
	Print "hello"
a = a + 1
Loop Until a > 10

'This will continue to print "hello" on the screen until the condition (a > 10) is met. 
