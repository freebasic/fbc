'' examples/manual/libraries/gsl2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibgsl
'' --------

'' Matrix example
#include "gsl/gsl_matrix.bi"

'' gsl uses the c-style row major order, unlike VB or Fortran 
? "A 3x3 matrix" 
Dim As gsl_matrix Ptr m = gsl_matrix_alloc(3, 3)
For i As Integer = 0 To 2
	For j As Integer = 0 To 2
		gsl_matrix_set (m, i, j, 0.23 + 100*i + j)
	Next
Next

For i As Integer = 0 To 2
	For j As Integer = 0 To 2
		Print "m(";i;",";j;") = "; gsl_matrix_get (m, i, j)
	Next
Next
?

gsl_matrix_transpose(m)

? "And its transpose"
For i As Integer = 0 To 2
	For j As Integer = 0 To 2
		Print "m(";i;",";j;") = "; gsl_matrix_get (m, i, j)
	Next
Next

Sleep
