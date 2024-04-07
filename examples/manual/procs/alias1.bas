'' examples/manual/procs/alias1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ALIAS (Name)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAlias
'' --------

Declare Function myfunction Alias "MyFunctioninLib" (ByVal As Long, ByVal As Long, ByVal As ZString Ptr) As Integer
