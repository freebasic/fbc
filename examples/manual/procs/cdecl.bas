'' examples/manual/procs/cdecl.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CDECL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCdecl
'' --------

' declaring 'strcpy' from the standard C library
Declare Function strcpy cdecl Alias "strcpy" (ByVal dest As ZString Ptr, ByVal src As ZString Ptr) As ZString Ptr
