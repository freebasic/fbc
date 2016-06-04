# include "fbcu.bi"

namespace fbc_tests.overloads.only_one_vararg_in_type

type foo
	declare function bar cdecl( byval i as integer, ... ) as integer
	declare sub bar2 cdecl( byval i as integer, ... )
	as integer baz
end type

sub test_1 cdecl
	'' this just has to compile!
	CU_ASSERT_EQUAL( 1, 1 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.overload.type_vararg")
	fbcu.add_test("1", @test_1)

end sub

end namespace
