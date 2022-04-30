'' examples/manual/module/extern-block.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'EXTERN...END EXTERN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExternBlock
'' --------

'' This procedure uses the default calling convention for the system, which is
'' STDCALL on Win32 and CDECL on Linux/DOS/*BSD, and is seen externally as
'' "MYTEST1@4" on Win32 and "MYTEST1" on Linux/DOS/*BSD (following FB's default
'' ALL-UPPER-CASE name mangling).
Sub MyTest1 ( ByVal i As Integer )
End Sub

Extern "C"
	'' This procedure uses the CDECL convention and is seen externally
	'' as "MyTest2".
	Sub MyTest2 ( ByVal i As Integer )
	End Sub
End Extern

Extern "C++"
	'' This procedure uses the CDECL convention and its name is mangled
	'' compatible to g++-4.x, specifically: "_Z7MyTest3i"
	Sub MyTest3 ( ByVal i As Integer )
	End Sub
End Extern

Extern "Windows"
	'' This procedure uses the STDCALL convention and is seen externally
	'' as "MyTest4@4" on Windows, and "MyTest4" on Linux, *BSD and DOS.
	Sub MyTest4 ( ByVal i As Integer )
	End Sub
End Extern

Extern "Windows-MS"
	'' This procedure uses the STDCALL convention and is seen externally
	'' as "MyTest5".
	Sub MyTest5 ( ByVal i As Integer )
	End Sub
End Extern

MyTest1( 0 )
MyTest2( 0 )
MyTest3( 0 )
MyTest4( 0 )
