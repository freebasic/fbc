# include "fbcu.bi"

namespace fbc_tests.overloads.sub_call

const TEST_VAL = 1234

type udt : __ as byte : end type 

function proc overload (byval udt as udt) as udt 
	CU_FAIL_FATAL("")
	return udt
end function 

sub proc overload (byval i as integer) 
	CU_ASSERT_EQUAL( i, TEST_VAL )
end sub 

private sub test_basic cdecl ()
	proc( TEST_VAL )
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-overload:sub_call")
	fbcu.add_test("test_basic", @test_basic)

end sub

end namespace
