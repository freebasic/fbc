'' examples/manual/control/if-then.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'IF...THEN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgIfthen
'' --------

'' Here is a simple "guess the number" game using a multi-line if...then for a decision.

Dim As Integer num, guess

Randomize
num = Int(Rnd * 10) + 1 'Create a random number between 1 and 10...
				
Print "guess the number between 1 and 10 (or CTRL-C to abort)"

Do 'Start a loop

	Input "Guess"; guess 'Input a number from the user

	If guess > 10 OrElse guess < 1 Then  'The user's guess is out of range
		Print "The number can't be greater then 10 or less than 1!"
	ElseIf guess > num Then  'The user's guess is too high
		Print "Too high"
	ElseIf guess < num Then  'The user's guess is too low
		Print "Too low"
	Else                     'The user guessed the right number!
		Print "Correct!"
		Exit Do   'Exit the loop
	End If

Loop 'Go back to the start of the loop

Sleep
	
