#include "fbcu.bi"

namespace fbc_tests.dim_.dynamic_huge

'' ASM backend regression test (Win32 stack overflow): No stack space should be
'' reserved for dynamic array symbols; only the array descriptor should be
'' allocated on stack.

'' So big that it's likely to produce a stack overflow if it was allocated on
'' stack.
const BIGSIZE = 100 * 1024 * 1024

type BigUdt
	big(0 to BIGSIZE-1) as byte
end type

#assert( sizeof( BigUdt ) = BIGSIZE )

private sub test cdecl( )
	dim array() as BigUdt
	CU_ASSERT( lbound( array ) = 0 )
	CU_ASSERT( ubound( array ) = -1 )
	CU_ASSERT( sizeof( array(0) ) = BIGSIZE )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/dynamic-huge" )
	fbcu.add_test( "1", @test )
end sub

end namespace
