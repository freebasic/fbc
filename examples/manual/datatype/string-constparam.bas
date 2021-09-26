'' examples/manual/datatype/string-constparam.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
