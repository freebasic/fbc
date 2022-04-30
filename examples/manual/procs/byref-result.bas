'' examples/manual/procs/byref-result.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BYREF (function results)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByrefFunction
'' --------

Function f( ) ByRef As Const ZString
	'' This string literal (because statically allocated in memory) will be returned by reference, no copy will be created.
	Function = "abcd"
End Function

Print f( )
