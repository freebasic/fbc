'' examples/manual/proguide/opovld/iif.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgOperatorOverloading
'' --------

Dim i As Integer = 420
Dim p As Integer Ptr = @i

Dim result As Integer = IIf( p, *p, cint( 20 / 4 ) )
