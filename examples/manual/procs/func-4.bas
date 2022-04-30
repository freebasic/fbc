'' examples/manual/procs/func-4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FUNCTION'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFunction
'' --------

'' The following example demonstrates optional parameters.

Function TestFunc(P As String = "Default") As String
	Return P
End Function

Print TestFunc("Testing:")
Print TestFunc
