'' examples/manual/datatype/subptr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSubPtr
'' --------

	Sub Hello()
		Print "Hello"
	End Sub

	Sub Goodbye()
		Print "Goodbye"
	End Sub

	Dim x As Sub() = ProcPtr( Hello )

	x()

	x = @Goodbye  '' or procptr(Goodbye)

	x()
