'' examples/manual/module/dylibsymbol.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDylibsymbol
'' --------

'' create a function pointer, arguments must be the same
'' as in the original function

Dim AddNumbers As Function ( ByVal operand1 As Integer, ByVal operand2 As Integer ) As Integer

Dim hndl As Any Ptr

hndl=DyLibLoad("mydll.dll")

'' find the procedure address (case matters!)
AddNumbers = DyLibSymbol( hndl, "AddNumbers" )

'' then call it..
Print "1 + 2 ="; AddNumbers( 1, 2 )

DyLibFree hndl

Sleep
