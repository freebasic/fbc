'' examples/manual/input/getkey.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'GETKEY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGetkey
'' --------

Dim As Long foo
Do
	foo = GetKey
	Print "total return: " & foo
	
	If( foo > 255 ) Then
		Print "extended code: " & (foo And &hff)
		Print "regular code: " & (foo Shr 8)
	Else
		Print "regular code: " & (foo And &hff)
	End If
	Print 
Loop Until foo = 27
