'' examples/manual/array/ubound2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUbound
'' --------

'' determining the size of an array
Dim As Short array(0 To 9)
Dim As Integer arraylen, arraysize

arraylen = UBound(array) - LBound(array) + 1
arraysize = arraylen * SizeOf( Short )

Print "Number of elements in array:", arraylen    '10
Print "Number of bytes used in array:", arraysize '10 * 2 = 20 
