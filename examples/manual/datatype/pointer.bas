'' examples/manual/datatype/pointer.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '(POINTER | PTR)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPtr
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
