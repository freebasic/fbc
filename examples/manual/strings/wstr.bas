'' examples/manual/strings/wstr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WSTR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWstr
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

Print ws
Print WStr("Unicode 'Hello World'")

#endif
