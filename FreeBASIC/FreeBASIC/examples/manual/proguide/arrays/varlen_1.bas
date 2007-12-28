'' examples/manual/proguide/arrays/varlen_1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgVarLenArrays
'' --------

Dim maxLowerBound As Integer = -5
Dim maxUpperBound As Integer = 10

'' Declares a two dimensional variable-length array of elements of type STRING..
Extern arrayOfStrings(maxLowerBound To maxUpperBound, 20) As String

'' Declares a one-dimensional variable-length array of elements of type BYTE..
Extern arrayOfBytes() As Byte
