'' examples/manual/udt/temp-type.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Type (Temporary)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTypeTemp
'' --------

Type Example
	As Integer field1
	As Integer field2
End Type

Dim myexample As Example

'' Filling the type by setting each field
myexample.field1 = 1
myexample.field2 = 2

'' Filling the type by setting each field using WITH
With myexample
	.field1 = 1
	.field2 = 2
End With

'' Fill the variable's fields with a  temporary type
myexample = Type( 1, 2 )
