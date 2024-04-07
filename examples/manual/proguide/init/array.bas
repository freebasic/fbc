'' examples/manual/proguide/init/array.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Variable Initializers'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgInitialization
'' --------

Dim array(0 To 4) As String = {"array(0)", "array(1)", "array(2)", "array(3)", "array(4)"}

For I As Integer = 0 To 4
	Print array(I),
Next I
Print

Sleep
		
