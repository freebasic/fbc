'' examples/manual/proguide/typalias/overload.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Type Aliases'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeAliases
'' --------

Type float As Single

Declare Sub f Overload (a As Single)

'' If following line is uncommented, this will generate a duplicated definition error
'' Declare Sub f (a As float)
