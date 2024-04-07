'' examples/manual/proguide/static-lib/mylib.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Static Libraries'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgStaticLibraries
'' --------

'' mylib.bas
'' compile with: fbc -lib mylib.bas

'' Add two numbers together and return the result
Public Function Add2( ByVal x As Integer, ByVal y As Integer ) As Integer
  Return( x + y )
End Function
		
