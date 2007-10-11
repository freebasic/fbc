'' examples/manual/math/rnd.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRnd
'' --------

'' Returns a random number in the range [first, last), or {first <= x < last}.
Declare Function rnd_range (first As Double, last As Double) As Double

'::
Randomize Timer

'' prints a random number in the range [0, 1), or {0 <= x < 1}.
Print Rnd

'' prints a random number in the range [0, 10), or  {0 <= x < 10}.
Print Rnd * 10

'' prints a random integral number in the range [1, 11), or  {1 <= x < 11}.
Print Int(Rnd * 10) + 1

'' prints a random integral number in the range [69, 421), or {69 <= x < 421}
Print Int(rnd_range(69, 421))

'::
Function rnd_range (first As Double, last As Double) As Double
	Function = Rnd * (last - first) + first
End Function
