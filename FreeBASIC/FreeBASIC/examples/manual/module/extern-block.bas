'' examples/manual/module/extern-block.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExternBlock
'' --------

Extern "c++"
	'' This namespace uses C++ mangling
	Namespace Ns1
		Declare Function theFunction( ByVal As Integer ) As UInteger
	End Namespace
End Extern

'' This namespace uses FreeBASIC mangling.
Namespace Ns2
	Declare Function theFunction( ByVal As Integer ) As UInteger
End Namespace

'' Both the functions don't exist, but this demonstrates the point that GNU LD recognizes C++ symbols and reports an understandable name.
'' Compare Ns1::theFunction(int) with _ZN3NS211THEFUNCTIONEi@4.

Print Ns1.theFunction( 1 )
Print Ns2.theFunction( 1 )
