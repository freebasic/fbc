'' examples/manual/proguide/opovld/iif.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Overloading'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgOperatorOverloading
'' --------

Dim i As Integer = 420
Dim p As Integer Ptr = @i

Dim result As Integer = IIf( p, *p, CInt( 20 / 4 ) )
		
