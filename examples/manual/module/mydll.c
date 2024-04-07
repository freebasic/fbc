'' examples/manual/module/mydll.c
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'IMPORT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImport
'' --------

/* mydll.c :
	compile with
	  gcc -shared -Wl,--strip-all -o mydll.dll mydll.c
*/
__declspec( dllexport ) int MyDll_Data = 0x1234;
