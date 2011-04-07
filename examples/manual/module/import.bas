'' examples/manual/module/import.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImport
'' --------

/'  import.bas :
	Compile with
	  fbc import.bas
'/
#inclib "mydll"

Extern Import MyDll_Data Alias "MyDll_Data" As Integer

Print "&h" + Hex( MyDll_Data )

' Output:
' &h1234
