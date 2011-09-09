''
'' test -- calls a mydll's function and prints the result
'' 
'' compile as: fbc test.bas (couldn't be simplier, eh?)
''

#include "mydll.bi"

	randomize timer
	
	dim as integer x = rnd * 10
	dim as integer y = rnd * 10
	
	print x; " +"; y; " ="; addnumbers( x, y )