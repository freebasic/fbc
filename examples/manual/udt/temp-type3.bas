'' examples/manual/udt/temp-type3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTypeTemp
'' --------

'' Passing a user-defined type to a procedure using temporary types
'' where the type is ambiguous and the name of the type must be specified.

Type S
  As Single x, y
End Type

Type T
  As Integer x, y
End Type

Union U
  As Integer x, y
End Union

'' Overloaded procedure test()
Sub test Overload ( v As S )
  Print "S", v.x, v.y
End Sub

Sub test ( v As T )
  Print "T", v.x, v.y
End Sub

Sub test ( v As U )
  Print "U", v.x, v.y
End Sub

'' Won't work: ambiguous
'' test( type( 1, 2 ) )

'' Specify name of type instead
test( Type<S>( 1, 2 ) )
test( Type<T>( 1, 2 ) )
test( Type<U>( 1 ) )
