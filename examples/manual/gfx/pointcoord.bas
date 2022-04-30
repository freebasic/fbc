'' examples/manual/gfx/pointcoord.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'POINTCOORD'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPointCoord
'' --------

Screen 12

Print "--- Default window coordinate mapping ---"
Print "DRAW pen position, at the default (0,0):"
Print "Physical:", PointCoord( 0 ), PointCoord( 1 )
Print "View:", PointCoord( 2 ), PointCoord( 3 )

Draw "BM 50,50"
Print "DRAW pen position, after being moved to (50,50):"
Print "Physical:", PointCoord( 0 ), PointCoord( 1 )
Print "View:", PointCoord( 2 ), PointCoord( 3 )

Print "--- Changing window coordinate mapping ---"
Window Screen (-100, -100) - (100, 100)

Draw "BM 0,0"
Print "DRAW pen position, after being moved to (0,0):"
Print "Physical:", PointCoord( 0 ), PointCoord( 1 )
Print "View:", PointCoord( 2 ), PointCoord( 3 )

Draw "BM 50,50"
Print "DRAW pen position, after being moved to (50,50):"
Print "Physical:", PointCoord( 0 ), PointCoord( 1 )
Print "View:", PointCoord( 2 ), PointCoord( 3 )

Sleep
