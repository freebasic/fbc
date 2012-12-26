#include "fbcu.bi"

#include "extern-array-1.bi"

namespace fbc_tests.dim_.extern_array_2

hInsertTest1( )

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/extern-array-2" )
	fbcu.add_test( "1", @test1 )
end sub

end namespace
