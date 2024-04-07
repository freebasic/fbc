'' examples/manual/proguide/shared-lib/mylib.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Shared Libraries'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgSharedLibraries
'' --------

'' mylib.bas
'' compile with: fbc -dll mylib.bas

'' Add two numbers together and return the result
Public Function Add2( ByVal x As Integer, ByVal y As Integer ) As Integer Export
  Return( x + y )
End Function
