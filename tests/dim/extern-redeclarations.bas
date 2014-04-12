#include "fbcu.bi"

namespace fbc_tests.dim_.extern_redeclarations

'' Duplicate EXTERNs like this should be allowed,
'' as long as there is no conflict. (just like #defines or typedefs)

extern a as integer
extern a as integer
dim a as integer

extern b() as integer
extern b() as integer
dim b() as integer

extern c(1 to 2) as integer
extern c(1 to 2) as integer
dim c(1 to 2) as integer

private sub test cdecl( )
	CU_ASSERT( a = 0 )
	CU_ASSERT( (ubound( b ) - lbound( b ) + 1) = 0 )
	CU_ASSERT( lbound( c ) = 1 )
	CU_ASSERT( ubound( c ) = 2 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/extern-redeclarations" )
	fbcu.add_test( "test", @test )
end sub

end namespace
