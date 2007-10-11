'' examples/manual/proguide/typalias/builtin.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeAliases
'' --------

Type float As Single

Declare Function add (a As float, b As float) As float

Dim foo As float = 1.23
Dim bar As float = -4.56
		
