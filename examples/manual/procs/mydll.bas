'' examples/manual/procs/mydll.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLib
'' --------

'' mydll.bas
'' compile with:
''   fbc -dll mydll.bas

Public Function GetValue() As Integer Export
  Function = &h1234
End Function
