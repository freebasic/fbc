'' examples/manual/procs/func-4.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFunction
'' --------

'' The following example demonstrates optional parameters.

Function TestFunc(P As String = "Default") As String
	Return P
End Function

Print TestFunc("Testing:")
Print TestFunc
