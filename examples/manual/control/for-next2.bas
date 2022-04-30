'' examples/manual/control/for-next2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FOR...NEXT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFornext
'' --------

Dim As Integer i, j, k, toTemp, stepTemp
j = 9: k = 1

For i = 0 To j Step k
	
	j = 0: k = 0 '' Changing j and k has no effect on the current loop.
	Print i;
	
Next i
Print

' Internally, this is what the above example does:
j = 9: k = 1

i = 0: toTemp = j: stepTemp = k
Do While IIf(stepTemp >= 0, i <= toTemp, i >= toTemp)
	
	j = 0: k = 0 '' Changing j and k has no effect on the current loop.
	Print i;
	
	i += stepTemp
Loop
Print
