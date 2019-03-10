'' examples/manual/procs/cva_list2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaList
'' --------

'' pass the args list to a function taking an cva_list type argument
#include "crt/stdio.bi"

Sub myprintf cdecl( fmt As ZString Ptr, ... )
	Dim args As cva_list
	cva_start( args, fmt )
	vprintf( fmt, args )
	cva_end( args )
End Sub

Dim As String s = "bar"

myprintf( !"integer=%i, longint=%lli float=%f\n", _
	1, 1ll Shl 32, 3.3 )

myprintf( !"string=%s, string=%s\n", "foo", s )
