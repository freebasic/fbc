'Calling functions in the GSL 
'main site http://www.gnu.org/software/gsl/ 
'a windows port is at http://gnuwin32.sourceforge.net/packages/gsl.htm 
' 
#include "gsl\gsl_math.bi" 
#include "gsl\gsl_matrix.bi" 

	dim y as double 
	'Two elementary math functions 

	'raise the value of 3.141 to the fourth power 
	y = gsl_pow_4 (3.141) 
	? "3.141 ^ 4 = "; y 
	? 

	'Find the hypotenuse of a right triangle with sides 3 and 4 
	y = gsl_hypot(3,4) 
	? "The hypotenuse of a right triangle with sides of length 3 and 4 is";y 
	? 

	'an example from the matrix library 
	dim i as integer 
	dim j as integer 
	dim m as gsl_matrix ptr 

	'gsl uses the c-style row major order, unlike VB and ForTran 
	? "A 3x3 matrix" 
	m = gsl_matrix_alloc(3, 3) 
	for i = 0 to 2 
   		for j = 0 to 2 
      		gsl_matrix_set (m, i, j, 0.23 + 100*i + j) 
   		next j 
	next i 

	for i = 0 to 2 
   		for j = 0 to 2 
      		print "m(";i;",";j;") = "; gsl_matrix_get (m, i, j) 
   		next j 
	next i 
	? 
	
	gsl_matrix_transpose(m) 
	? "And its transpose" 
	for i = 0 to 2 
   		for j = 0 to 2 
      		print "m(";i;",";j;") = "; gsl_matrix_get (m, i, j) 
   		next j 
	next i 
	
	sleep
