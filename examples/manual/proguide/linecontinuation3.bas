'' examples/manual/proguide/linecontinuation3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Line Continuation'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgLineContinuation
'' --------

'' Declare variable "a_"
'' (no line continuation happening, because the '_' character is part of
'' the "a_" identifier)
Dim As Integer a_

'' Declare variable "a" and initialize to value 5
'' (line continuation happening, because the '_' character
'' was separated from the identifier "a" with a space character)
Dim As Integer a _
= 5
		
