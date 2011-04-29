'' examples/manual/control/if-then.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgIfthen
'' --------

'' Here is a simple "guess the number" game using if...then for a decision.

Dim As Integer num, guess

Randomize
num = Int(Rnd * 10) + 1 'Create a random number between 1 and 10...
	            
Print "guess the number between 1 and 10"

Do 'Start a loop

	Input "Guess"; guess 'Input a number from the user

	If guess > 10 OrElse guess < 1 Then  'The user's guess is out of range
		Print "The number can't be greater then 10 or less than 1!"
	ElseIf guess > num Then  'The user's guess is too low
		Print "Too low"
	ElseIf guess < num Then  'The user's guess is too high
		Print "Too high"
	ElseIf guess = num Then  'The user guessed the right number!
		Print "Correct!"
		Exit Do   'Exit the loop
	End If

Loop 'Go back to the start of the loop
