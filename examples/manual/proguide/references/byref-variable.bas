'' examples/manual/proguide/references/byref-variable.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgReferences
'' --------

Dim As Double X = 0

Dim ByRef As Double refX = X  '' declaration for defining a reference
Print X
refX = 7.89
Print X

Sleep
		
