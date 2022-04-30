'' examples/manual/proguide/references/byref-param.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Using References'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgReferences
'' --------

Declare Sub passbyref (ByRef ref As Double, ByVal value As Double)  '' declaration for passing by reference

Dim As Double X = 0
Print X
passbyref(X, 1.23)
Print X

Sleep

Sub passbyref (ByRef ref As Double, ByVal value As Double)  '' declaration for passing by reference
	ref = value
End Sub
		
