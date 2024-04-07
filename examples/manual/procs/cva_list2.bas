'' examples/manual/procs/cva_list2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVA_LIST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaList
'' --------

'' pass the args list to a function taking an cva_list type argument
#include "crt/stdio.bi"

Sub myprintf cdecl( fmt As ZString Ptr, ... )
	Dim args As Cva_List
	Cva_Start( args, fmt )
	vprintf( fmt, args )
	Cva_End( args )
End Sub

Dim As String s = "bar"

myprintf( !"integer=%i, longint=%lli float=%f\n", _
	1, 1ll Shl 32, 3.3 )

myprintf( !"string=%s, string=%s\n", "foo", s )
