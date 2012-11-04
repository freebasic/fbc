#include "fbcu.bi"

namespace fbc_tests.ns.op

namespace foo
	type UDT
		as integer a
	end type

	declare sub test( )

	'' if global operators are allowed inside namespaces...
	declare operator +( a as UDT, b as UDT ) as integer

	operator -( a as UDT, b as UDT ) as integer
		operator = a.a - b.a - 2
	end operator
end namespace

'' and outside-of-namespace bodies like this are allowed...
sub foo.test( )
end sub

'' then this outside-of-namespace operator body should be allowed too:
operator foo.+( a as foo.UDT, b as foo.UDT ) as integer
	operator = a.a + b.a + 2
end operator

sub test cdecl( )
	dim as foo.UDT a, b

	a.a = 1
	b.a = 1
	CU_ASSERT( a + b = 4 )
	CU_ASSERT( a - b = -2 )

	a.a = 3
	b.a = 7
	CU_ASSERT( a + b = 12 )
	CU_ASSERT( a - b = -6 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/namespace/operator" )
	fbcu.add_test( "1", @test )
end sub

end namespace
