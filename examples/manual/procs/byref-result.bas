'' examples/manual/procs/byref-result.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByrefFunction
'' --------

Function f( ) ByRef As Const ZString
	'' This string will be returned by reference, no copy will be created.
	Function = "abcd"
End Function

Print f( )
