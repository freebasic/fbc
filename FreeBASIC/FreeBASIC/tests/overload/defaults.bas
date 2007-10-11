# include "fbcu.bi"

namespace fbc_tests.overloads.default_params

function foo overload ( byval i as integer, byref s as string ) as integer
	function = 2
end function
function foo overload ( byval i as integer, byval j as integer = 0, byval k as integer = 0, byval l as integer = 0, byval m as integer = 0, byval n as integer = 0 ) as integer
	function = 1
end function

sub test_1 cdecl
	CU_ASSERT_EQUAL( foo( 0, "hi" ), 2 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-overload:default_params")
	fbcu.add_test("1", @test_1)

end sub

end namespace
