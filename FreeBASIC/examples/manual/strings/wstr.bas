'' examples/manual/strings/wstr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWstr
'' --------

#include "windows.bi"
Dim zs As ZString * 20
Dim ws As WString * 20

zs = "Hello World"
ws = WStr(zs)
MessageBox(null, ws, WStr("Unicode 'Hello World'"), MB_OK Or MB_ICONINFORMATION)
