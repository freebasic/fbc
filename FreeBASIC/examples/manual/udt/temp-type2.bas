'' examples/manual/udt/temp-type2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTypeTemp
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
