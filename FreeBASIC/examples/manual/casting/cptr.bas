'' examples/manual/casting/cptr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCptr
'' --------

Dim intval As Integer
Dim intptr As Integer Ptr
intval = &h0080
intptr = @intval
'' will print -128 and 128, as the first expression will be "seen" as an signed byte
Print *CPtr( Byte Ptr, intptr ), *intptr
