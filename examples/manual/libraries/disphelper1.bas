'' examples/manual/libraries/disphelper1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ExtLibdisphelper
'' --------

'' HTTP GET example, using MSXML2

#define UNICODE
#include "disphelper/disphelper.bi"

DISPATCH_OBJ(objHTTP)

dhInitialize(TRUE)
dhToggleExceptions(TRUE)

dhCreateObject("MSXML2.XMLHTTP.4.0", NULL, @objHTTP)

dhCallMethod(objHTTP, ".Open(%s, %s, %b)", "GET", "http://sourceforge.net", FALSE)
dhCallMethod(objHTTP, ".Send")

Dim As ZString Ptr szResponse
dhGetValue("%s", @szResponse, objHTTP, ".ResponseText")

Print "Response: "; *szResponse
dhFreeString(szResponse)

SAFE_RELEASE(objHTTP)
dhUninitialize(TRUE)
