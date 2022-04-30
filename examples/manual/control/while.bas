'' examples/manual/control/while.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WHILE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWhile
'' --------

Dim a As Integer

a = 0
Do While a < 10
	Print "hello"
a = a + 1
Loop

'This will continue to print "hello" on the screen while the condition (a < 10) is met.
	
