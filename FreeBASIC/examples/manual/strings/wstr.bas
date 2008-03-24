'' examples/manual/strings/wstr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWstr
'' --------

#if defined( __FB_WIN32__ )
#include "windows.bi"
#endif

Dim zs As ZString * 20
Dim ws As WString * 20

zs = "Hello World"
ws = WStr(zs)

#if defined( __FB_WIN32__ )

MessageBox(null, ws, WStr("Unicode 'Hello World'"), MB_OK Or MB_ICONINFORMATION)

#else

print ws
print WStr("Unicode 'Hello World'")

#endif
