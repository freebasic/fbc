'' examples/manual/procs/mydll.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LIB'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLib
'' --------

'' mydll.bas
'' compile with:
''   fbc -dll mydll.bas

Public Function GetValue() As Integer Export
  Function = &h1234
End Function
