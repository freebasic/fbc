'' examples/manual/module/mydll2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDylibsymbol
'' --------

'' mydll.dll

'' in the DLL the function must be declared as CDECL and export

Function AddNumbers cdecl Alias "AddNumbers" _
  ( _
	ByVal operand1 As Integer, ByVal operand2 As Integer _
  ) As Integer Export

   AddNumbers = operand1 + operand2

End Function
