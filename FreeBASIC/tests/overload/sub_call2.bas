# include "fbcu.bi"

namespace fbc_tests.overloads.sub_call2

sub foo overload ()
end sub
 
function foo overload (byval v as integer) as integer
	function = v
end function

sub test_basic cdecl ()
	CU_ASSERT_EQUAL( foo(1234), 1234 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-overload:sub_call2")
	fbcu.add_test("test_basic", @test_basic)

end sub

end namespace