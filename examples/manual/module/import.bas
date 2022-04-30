'' examples/manual/module/import.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'IMPORT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImport
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
