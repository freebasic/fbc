'' examples/manual/proguide/constant_expressions.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constant Expressions'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgConstantExpressions
'' --------

#define pi 4 * Atn(1)

Dim Shared As Double d = Sqr(2)

Type pt
	Dim As Integer x = 300 * Cos(pi / 6)
	Dim As Integer y = 300 * Sin(pi / 6)
End Type

Dim As pt p

Print pi        ''  3.14159...
Print d         ''  1.41421...
Print p.x, p.y  ''  260           150

Sleep
		
