# include "fbcu.bi"

namespace fbc_tests.structs.clear_

const ARRAY_LB = 0
const ARRAY_UB = 3

type foo_1
	as integer arr(0 to 0)
end type

type foo_2
	as integer arr(0 to 1)
end type

type foo_3
	as integer arr(0 to 3)
end type

type foo_4
	as integer arr(0 to 4)
end type

#macro dotest( base, elems )
	for i  as integer = 0 to elems-1
		CU_ASSERT_EQUAL( base##arr(i), 0 )
	next
#endmacro

sub test_1 cdecl
	dim f as foo_1
	dotest( f., 1 )

	dim pf as foo_1 ptr = new foo_1
	dotest( pf->, 1 )
	delete pf
end sub	

sub test_2 cdecl
	dim f as foo_2
	dotest( f., 2 )

	dim pf as foo_2 ptr = new foo_2
	dotest( pf->, 2 )
	delete pf
end sub	

sub test_3 cdecl
	dim f as foo_3
	dotest( f., 3 )

	dim pf as foo_3 ptr = new foo_3
	dotest( pf->, 3 )
	delete pf
end sub	

sub test_4 cdecl
	dim f as foo_4
	dotest( f., 4 )

	dim pf as foo_4 ptr = new foo_4
	dotest( pf->, 4 )
	delete pf
end sub	

private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:clear_")
	fbcu.add_test( "1", @test_1)
	fbcu.add_test( "2", @test_2)
	fbcu.add_test( "3", @test_3)
	fbcu.add_test( "4", @test_4)

end sub
	
end namespace	