'' examples/manual/procs/cdecl.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCdecl
'' --------

' declaring 'strcpy' from the standard C library
Declare Function strcpy cdecl Alias "strcpy" (ByVal dest As ZString Ptr, ByVal src As ZString Ptr) As ZString Ptr
