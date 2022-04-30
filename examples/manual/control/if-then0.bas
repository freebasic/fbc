'' examples/manual/control/if-then0.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'IF...THEN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgIfthen
'' --------

'' Here is a simple "compute the square root" code using a single-line if...then for the decision,
'' but with multiple statements extended with colons (:)

Dim As Double d , r
r = -1
d = 2
'd = -3

If d > 0 Then r = Sqr(d) : Print "square root computed:" Else r = 0 : Print "square root not computed:"
Print r

Sleep
	
