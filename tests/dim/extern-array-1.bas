#include "fbcunit.bi"

#include "extern-array-1.bi"

dim externarray1(0 to ...) as integer = { 1, 2 }
dim externarray2() as integer
dim externarray3(0 to 1) as integer
dim externarray4(10 to 10, 20 to 20, 30 to 30) as integer = { { { 123 } } }
dim externarray5(10 to 10, 20 to ...) as integer = { { 12 } }
redim externarray6(6 to 6) as integer
redim shared externarray7(7 to 7) as integer
dim externarray8(any) as integer
redim externarray9(9 to 9) as integer

SUITE( fbc_tests.dim_.extern_array_1 )

hInsertTest1( )

END_SUITE
