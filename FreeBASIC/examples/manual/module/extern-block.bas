'' examples/manual/module/extern-block.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExternBlock
'' --------

Extern "C"
	'' This procedure uses the CDECL convention and is seen externally
	'' as "SomeProcedure".
	Declare Sub SomeProcedure ( ByVal As Integer )
End Extern

Extern "C++"
	'' This procedure uses the CDECL convention and its name is mangled
	'' compatible to that of g++-4.x.
	Declare Function AnotherProcedure ( ByVal As Integer ) As Integer
End Extern

Extern "Windows"
	'' This procedure uses the STDCALL convention and is seen externally
	'' as "YetAnotherProcedure@4" on Windows, and
	'' "YetAnotherProcedure" on Linux, *BSD and DOS.
	Declare Function YetAnotherProcedure ( ByVal As Integer ) As Integer
End Extern

Extern "Windows-MS"
	'' This procedure uses the STDCALL convention and is seen externally
	'' as "YetAnotherProcedure".
	Declare Function YetAnotherProcedure ( ByVal As Integer ) As Integer
End Extern
