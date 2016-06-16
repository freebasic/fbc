# include "fbcu.bi"

namespace fbc_tests.typedef.incomplete

'' A = forward-declared type
'' A_ = forward reference
type A as A_

'' typedef to forward-declared type (not to the forward reference)
type B as A

type A_
	as integer a, b, c
end type

#assert typeof(A) = typeof(B)
#assert typeof(A) = "FBC_TESTS.TYPEDEF.INCOMPLETE.A_"
#assert typeof(B) = "FBC_TESTS.TYPEDEF.INCOMPLETE.A_"

sub test cdecl( )
	'' A and B should both refer to the same UDT (A_)
	CU_ASSERT( sizeof( A ) = sizeof( integer ) * 3 )
	CU_ASSERT( sizeof( B ) = sizeof( integer ) * 3 )
	dim x1 as A
	dim x2 as B
	CU_ASSERT( sizeof( x1 ) = sizeof( integer ) * 3 )
	CU_ASSERT( sizeof( x2 ) = sizeof( integer ) * 3 )
	CU_ASSERT( x1.a = 0 )
	CU_ASSERT( x1.b = 0 )
	CU_ASSERT( x1.c = 0 )
	CU_ASSERT( x2.a = 0 )
	CU_ASSERT( x2.b = 0 )
	CU_ASSERT( x2.c = 0 )
	x1 = x2
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.typedef.incomplete" )
	fbcu.add_test( "test", @test )
end sub

end namespace
