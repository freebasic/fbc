'' examples/manual/proguide/shared-lib/mylib.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgSharedLibraries
'' --------

'' mylib.bas
'' compile with: fbc -dll mylib.bas

'' Add two numbers together and return the result
Public Function Add2( ByVal x As Integer, ByVal y As Integer ) As Integer Export
  Return( x + y )
End Function
