'' examples/manual/proguide/arrays/varlen_decl.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Variable-length Arrays'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgVarLenArrays
'' --------

'' Declares a one-dimensional variable-length array of integers, with initially 2 elements (0 and 1)
ReDim a(0 To 1) As Integer

'' Declares a 1-dimensional variable-length array without initial bounds.
'' It must be resized using Redim before it can be used for the first time.
Dim b(Any) As Integer

'' Same, but 2-dimensional
Dim c(Any, Any) As Integer

Dim myLowerBound As Integer = -5
Dim myUpperBound As Integer = 10

'' Declares a 1-dimensional variable-length array by specifying variable (non-constant) boundaries.
'' The array will have myUpperBound - myLowerBound + 1 elements.
Dim d(myLowerBound To myUpperBound) As Integer

'' Declares a variable-length array whose amount of dimensions will be determined
'' by the first Redim or array access found. The array has no initial bounds and must
'' be resized using Redim before it can be used for the first time.
Dim e() As Integer
