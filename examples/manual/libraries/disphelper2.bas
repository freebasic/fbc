'' examples/manual/libraries/disphelper2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ExtLibdisphelper
'' --------

'' IExplorer example

#define UNICODE
#include "disphelper/disphelper.bi"

Sub navigate(ByRef url As String)
	DISPATCH_OBJ(ieApp)
	dhInitialize(TRUE)
	dhToggleExceptions(TRUE)

	dhCreateObject("InternetExplorer.Application", NULL, @ieApp)
	dhPutValue(ieApp, "Visible = %b", TRUE)
	dhCallMethod(ieApp, ".Navigate(%s)", url)

	SAFE_RELEASE(ieApp)
	dhUninitialize(TRUE)
End Sub

	navigate("www.freebasic.net")
