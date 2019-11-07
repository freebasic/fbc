'' examples/manual/proguide/references/byref-param.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
		
