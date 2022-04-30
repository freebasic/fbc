'' examples/manual/udt/with-3.bas
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

Dim As rect_type rect1, rect2

'' Nested With blocks
With rect1

	.x = 1
	.y = 2

	With rect2

		.x = 3
		.y = 4

	End With

End With

Print rect1.x, rect1.y '' 1,  2
Print rect2.x, rect2.y '' 3,  4
