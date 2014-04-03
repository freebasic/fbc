#include "fbcu.bi"

#include "extern-array-1.bi"

dim externarray1(0 to ...) as integer = { 1, 2 }
'dim externarray2() as integer
dim externarray3(0 to 1) as integer
dim externarray4(10 to 10, 20 to 20, 30 to 30) as integer = { { { 123 } } }
dim externarray5(10 to 10, 20 to ...) as integer = { { 12 } }

namespace fbc_tests.dim_.extern_array_1

hInsertTest1( )

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/extern-array-1" )
	fbcu.add_test( "1", @test1 )
end sub

end namespace
