'' examples/manual/udt/this.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgThis
'' --------

Type sometype
	Declare Sub MyCall()
	value As Integer
End Type

Dim example As sometype

'' Set element test to 0
example.value = 0
Print example.value

example.MyCall()

'' Output should now be 10
Print example.value

End 0

Sub sometype.MyCall()
	This.value = 10
End Sub
