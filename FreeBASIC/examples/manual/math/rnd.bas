'' examples/manual/math/rnd.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRnd
'' --------

'' Function to a random number in the range [first, last), or {first <= x < last}.
Function rnd_range (first As Double, last As Double) As Double
	Function = Rnd * (last - first) + first
End Function

'' seed the random number generator, so the sequence is not the same each time
Randomize

'' prints a random number in the range [0, 1), or {0 <= x < 1}.
Print Rnd

'' prints a random number in the range [0, 10), or  {0 <= x < 10}.
Print Rnd * 10

'' prints a random integral number in the range [1, 11), or  {1 <= x < 11}.
'' with integers, this is equivalent to [1, 10], or {1 <= n <= 10}.
Print Int(Rnd * 10) + 1

'' prints a random integral number in the range [69, 421), or {69 <= x < 421}.
'' this is equivalent to [69, 420], or {69 <= n <= 420}.
Print Int(rnd_range(69, 421))
