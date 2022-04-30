'' examples/manual/variable/byref1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BYREF (variables)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByrefVariables
'' --------

'' Comparison between:
''   - a copy ('ci') of a variable ('i')
''   - a reference ('ri') to a variable ('i')


Dim As Integer i = 12
Print @i, i

Dim As Integer ci = i  '' or Var ci = i
Print @ci, ci

Dim ByRef As Integer ri = i  '' or Var Byref ri = i
Print @ri, ri

Print

Print i, ci, ri
i = 34
Print i, ci, ri
ci = 56
Print i, ci, ri
ri = 78
Print i, ci, ri

Sleep
	
