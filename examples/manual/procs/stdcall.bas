'' examples/manual/procs/stdcall.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'STDCALL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgStdcall
'' --------

Declare Function Example stdcall (param1 As Integer, param2 As Integer) As Integer
Declare Function Example2 cdecl (param1 As Integer, param2 As Integer) As Integer

Function Example stdcall (param1 As Integer, param2 As Integer) As Integer
	' This is an STDCALL function, the first parameter on the stack is param2, since it was pushed last.
	Print param1, param2
	Return param1 Mod param2
End Function

Function Example2 cdecl (param1 As Integer, param2 As Integer) As Integer
	' This is a CDECL function, the first parameter on the stack is param1, since it was pushed last.
	Print param1, param2
	Return param1 Mod param2
End Function
