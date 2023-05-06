'' examples/manual/udt/with-2.bas
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

Dim the_rectangle As rect_type Ptr

the_rectangle = CAllocate( 5 * Len( rect_type ) )

Dim As Integer loopvar, temp, t

For loopvar = 0 To 4

  With the_rectangle[loopvar]  '' dereferenced pointer

	temp = .x
	.x = 234 * t + 48 + .y
	.y = 321 * t + 2

  End With

Next
