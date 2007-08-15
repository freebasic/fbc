'' examples/manual/proguide/arrays/fixedlen_1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgStaticArrays
'' --------

	Const maxLowerBound As Integer = -5
	Const maxUpperBound As Integer = 10
	
	'' Declares a two dimensional static array of elements of type STRING..
	Extern arrayOfStrings(maxLowerBound To maxUpperBound, 20) As String

	'' Declares a one-dimensional static array of elements of type BYTE,
	'' big enough to hold an INTEGER..
	Extern arrayOfBytes(SizeOf(Integer)) As Byte
