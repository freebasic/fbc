'' examples/manual/control/if-then.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgIfthen
'' --------

'e.g. here is a simple "guess the number" game using if...then for a decision.
Dim x As Integer, y As Integer

Randomize Timer 
x = Rnd * 11    'Create a random number between 0 and 10.999...
	            
Print "guess the number between 0 and 10"

Do 'Start a loop
	Input "guess"; y 'Input a number from the user
	If x = y Then
		Print "right!" 'He/she guessed the right number!
		Exit Do
	ElseIf y > 10 Then 'The number is higher then 10
		Print "The number cant be greater then 10! Use the force!"
	ElseIf x > y Then 
		Print "too low" 'The users guess is to low
	ElseIf x < y Then
		Print "too high" 'The users guess is to high
	End If
Loop 'Go back to the start of the loop
