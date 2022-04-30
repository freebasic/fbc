'' examples/manual/proguide/references/byref-variable.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Using References'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgReferences
'' --------

Dim As Double X = 0

Dim ByRef As Double refX = X  '' declaration for defining a reference
Print X
refX = 7.89
Print X

Sleep
		
