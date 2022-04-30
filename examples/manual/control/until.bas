'' examples/manual/control/until.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'UNTIL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUntil
'' --------

Dim a As Integer

a = 1
Do
	Print "hello"
a = a + 1
Loop Until a > 10

'This will continue to print "hello" on the screen until the condition (a > 10) is met. 
