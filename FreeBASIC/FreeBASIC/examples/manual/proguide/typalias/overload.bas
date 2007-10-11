'' examples/manual/proguide/typalias/overload.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeAliases
'' --------

Type float As Single

Declare Sub f Overload (a As Single)

'' If uncommented, this will generate a duplicated definition error
'' Declare Sub f (a As float)
