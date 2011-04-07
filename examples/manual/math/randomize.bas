'' examples/manual/math/randomize.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRandomize
'' --------

'' Seed the RNG to the method using C's rand()
Randomize , 1

'' Print a sequence of random numbers
For i As Integer = 1 To 10
	Print Rnd
Next
