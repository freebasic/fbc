'' examples/manual/module/mydll.c
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgImport
'' --------

/* mydll.c :
	compile With
	  gcc -shared -Wl,--strip-all -o mydll.dll mydll.c
*/
__declspec( dllexport ) int MyDll_Data = 0x1234;
