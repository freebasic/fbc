'' examples/manual/procs/alias2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAlias
'' --------

Function MultiplyByFive cdecl Alias "MyExportedProc" (ByVal Parameter As Integer) As Integer Export
  Return Parameter * 5
End Function
