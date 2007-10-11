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

'' First method of filling the type
ex.field1 = 1
ex.field2 = 2

'' Second method
With ex
	.field1 = 1
	.field2 = 2
End With

'' Third method, using temporary types
ex = Type( 1, 2 )
