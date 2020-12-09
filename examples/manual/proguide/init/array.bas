'' examples/manual/proguide/init/array.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgInitialization
'' --------

Dim array(0 To 4) As String = {"array(0)", "array(1)", "array(2)", "array(3)", "array(4)"}

For I As Integer = 0 To 4
	Print array(I),
Next I
Print

Sleep
		
