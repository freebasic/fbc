'' examples/manual/udt/with-2bis.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WITH'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWith
'' --------

Type rect_type
	x As Single
	y As Single
	Declare Constructor()
	Declare Constructor(ByVal x0 As Single, ByVal y0 As Single)
End Type

Constructor rect_type()
End Constructor

Constructor rect_type(ByVal x0 As Single, ByVal y0 As Single)
	This.x = x0
	This.y = y0
End Constructor

Dim the_rectangle As rect_type

With rect_type(1, 2)  '' temporary instance created here held up to 'End With'
	the_rectangle.x = .x + .y  '' 1 + 2 = 3
	the_rectangle.y = .x - .y  '' 1 - 2 = -1
End With
