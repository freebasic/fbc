'' examples/manual/proguide/linecontinuation2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgLineContinuation
'' --------

'' Here's an example:

Declare Sub drawRectangle( ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer )

'' which can also be written as:

Declare Sub drawRectangle( ByVal x As Integer, ByVal y As Integer, _
						   ByVal w As Integer, ByVal h As Integer )

'' or:

Declare Sub drawRectangle _
	( _
		ByVal x As Integer, _
		ByVal y As Integer, _
		ByVal w As Integer, _
		ByVal h As Integer _
	)

'' (or any other formatting you like)
