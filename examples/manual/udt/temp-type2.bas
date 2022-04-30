'' examples/manual/udt/temp-type2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Temporary Types'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTypeTemp
'' --------

'' Passing a user-defined types to a procedure using a temporary type
'' where the type can be inferred.

Type S
  As Single x, y
End Type

Sub test ( v As S )
  Print "S", v.x, v.y
End Sub

test( Type( 1, 2 ) )
