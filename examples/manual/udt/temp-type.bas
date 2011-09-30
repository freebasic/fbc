'' examples/manual/udt/temp-type.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTypeTemp
'' --------

Type Example
	As Integer field1
	As Integer field2
End Type

Dim ex As Example

'' Filling the type by setting each field
ex.field1 = 1
ex.field2 = 2

'' Filling the type by setting each field using WITH
With ex
	.field1 = 1
	.field2 = 2
End With

'' Fill the variable's fields with a  temporary type
ex = Type( 1, 2 )
