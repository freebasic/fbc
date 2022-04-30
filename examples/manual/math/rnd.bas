'' examples/manual/math/rnd.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RND'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRnd
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

'' prints a random integral number in the range  [1, 10], or {1 <= n <= 10}.
''     (because: 0 <= Rnd * 10 < 10)
Print Int(Rnd * 10) + 1

'' prints a random integral number in the range [69, 420], or {69 <= n <= 420}.
''     (because: 69 <= rnd_range(69, 421) < 421)
Print Int(rnd_range(69, 421))
	
