'' examples/manual/datatype/subptr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SUB Pointer'
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
