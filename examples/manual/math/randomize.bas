'' examples/manual/math/randomize.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RANDOMIZE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRandomize
'' --------

'' Seed the RNG to the method using C's rand()
Randomize , 1

'' Print a sequence of random numbers
For i As Integer = 1 To 10
	Print Rnd
Next
	
