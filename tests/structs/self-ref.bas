# include "fbcu.bi"

namespace fbc_tests.structs.selfref

'' C backend regression test
type T
	as T ptr ptr ptr ppp
	as integer a
end type

sub test cdecl( )
	dim as T x
	dim as T ptr p = @x
	dim as T ptr ptr pp = @p
	x.ppp = @pp
	x.a = 123

	CU_ASSERT( (**x.ppp)->a = 123 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite("fb-tests-structs:selfref")
	fbcu.add_test( "test", @test )
end sub

end namespace
