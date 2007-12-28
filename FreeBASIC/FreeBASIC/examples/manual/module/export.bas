'' examples/manual/module/export.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExport
'' --------

'' create a function pointer, arguments must be the same type
'' as in the original function

Dim AddNumbers As Function ( ByVal As Integer, ByVal As Integer ) As Integer
Dim hndl As Any Ptr

hndl=DyLibLoad("mydll.dll")

'' find the proc address (case matters!)
AddNumbers = DyLibSymbol( hndl, "AddNumbers" )

'' then call it ...
Print "1 + 2 = " & AddNumbers( 1, 2 )

Sleep
