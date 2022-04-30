'' examples/manual/control/exit2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'EXIT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExit
'' --------

Dim As Integer i, j
For i = 1 To 10
	
	For j = 1 To 10
		
		Exit For, For
		
	Next j
	
	Print "I will never be shown"
	
Next i
