'' examples/manual/proguide/arrays/fixedlen_constants.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgFixLenArrays
'' --------

Const myLowerBound = -5
Const myUpperBound = 10

'' Declares a one-dimensional fixed-length array, holding myUpperBound - myLowerBound + 1 String objects.
Dim arrayOfStrings(myLowerBound To myUpperBound) As String

'' Declares a one-dimensional fixed-length array of bytes,
'' big enough to hold an INTEGER.
Dim arrayOfBytes(0 To SizeOf(Integer) - 1) As Byte
