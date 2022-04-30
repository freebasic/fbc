'' examples/manual/datatype/string-constparam.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'STRING'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgString
'' --------

'' Variable-length string as Const parameter

'' Const qualifier preventing string from being modified
Sub silly_print( ByRef printme As Const String )
	Print ".o0( " & printme & " )0o."
	'next line will cause error if uncommented
	'printme = "silly printed"
End Sub

Dim As String status = "OK"

silly_print( "Hello FreeBASIC!" )
silly_print( "Status: " + status )
