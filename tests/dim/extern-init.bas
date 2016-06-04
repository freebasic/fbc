#include "fbcu.bi"

namespace fbc_tests.dim_.extern_init

'' Should compile fine under -gen gcc
extern p1 as integer ptr
dim shared x1 as integer
dim shared p1 as integer ptr = @x1

extern p2 as integer ptr
dim shared x2 as integer = 1
dim shared p2 as integer ptr = @x2

sub test cdecl( )
	CU_ASSERT( p1 = @x1 )
	CU_ASSERT( x1 = 0 )

	CU_ASSERT( p2 = @x2 )
	CU_ASSERT( x2 = 1 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.dim.extern-init" )
	fbcu.add_test( "test", @test )
end sub

end namespace
