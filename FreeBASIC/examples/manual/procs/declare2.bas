'' examples/manual/procs/declare2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDeclare
'' --------

Type my_type
	my_data As Integer
	Declare Sub increment_data( )
End Type

Sub my_type.increment_data( )
	my_data += 1
End Sub

Dim As my_type an_instance

an_instance.my_data = 68

an_instance.increment_data( )

Print an_instance.my_data
