''
'' test -- calls mydll's function and prints the result
''
'' compile as: fbc test.bas
'' (mydll must be compiled first)
''

#include "mydll.bi"
#inclib "mydll"

randomize( timer( ) )

dim as integer x = rnd( ) * 10
dim as integer y = rnd( ) * 10

print x; " +"; y; " ="; AddNumbers( x, y )
