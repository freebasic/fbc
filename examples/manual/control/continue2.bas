'' examples/manual/control/continue2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONTINUE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgContinue
'' --------

 '' simple prime number finder

Print "Here are the prime numbers between 1 and 20!"
Print

Dim n As Integer, d As Integer

For n = 2 To 20
	
	For d = 2 To Int(Sqr(n))
		
		If ( n Mod d ) = 0 Then ' d divides n
			
			Continue For, For ' n is not prime, so try next n
			
		End If
		
	Next d
	
	Print n
	
Next n
