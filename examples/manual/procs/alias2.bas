'' examples/manual/procs/alias2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ALIAS (Name)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAlias
'' --------

Function MultiplyByFive cdecl Alias "MyExportedProc" (ByVal Parameter As Integer) As Integer Export
  Return Parameter * 5
End Function
