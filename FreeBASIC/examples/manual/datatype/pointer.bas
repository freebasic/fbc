'' examples/manual/datatype/pointer.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPointer
'' --------

Dim p As ZString Pointer
Dim text As String
text = "Hello World!"
p = StrPtr(text) + 6
Print text
Print *p

'' Output:
'' Hello World!
'' World!
