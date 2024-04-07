'' examples/manual/proguide/arrays/fixedlen_constants.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Fixed-length Arrays'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgFixLenArrays
'' --------

Const myLowerBound = -5
Const myUpperBound = 10

'' Declares a one-dimensional fixed-length array, holding myUpperBound - myLowerBound + 1 String objects.
Dim arrayOfStrings(myLowerBound To myUpperBound) As String

'' Declares a one-dimensional fixed-length array of bytes,
'' big enough to hold an INTEGER.
Dim arrayOfBytes(0 To SizeOf(Integer) - 1) As Byte
		
