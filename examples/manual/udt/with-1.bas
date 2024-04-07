'' examples/manual/udt/with-1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WITH'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWith
'' --------

Type rect_type
	x As Single
	y As Single
End Type

Dim the_rectangle As rect_type
Dim As Integer temp, t

With the_rectangle
	temp = .x
	.x = 234 * t + 48 + .y
	.y = 321 * t + 2
End With
