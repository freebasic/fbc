'' examples/manual/proguide/references/byref-return1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Using References'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgReferences
'' --------

Declare Function returnbyref () ByRef As Double  '' declaration for returning by reference

Print returnbyref()
returnbyref() = 4.56
Print returnbyref()

Sleep

Function returnbyref () ByRef As Double  '' declaration for returning by reference
	Static As Double X = 0
	Return X
End Function
		
