# include "fbcu.bi"

namespace fbc_tests.overload_.uop_coersion

type udt
	value as integer
	declare operator cast as integer
end type

operator udt.cast as integer
	operator = value
end operator

const TEST_VAL = 1234

sub test cdecl ()
	dim as udt v = ( TEST_VAL )
	
	'' auto-coercion from UDT to integer using the op ovl
	CU_ASSERT_EQUAL( -v, -TEST_VAL )

	'' ditto
	CU_ASSERT_EQUAL( not v, not TEST_VAL )

end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-overload:uop_coersion")
	fbcu.add_test("test_basic", @test)

end sub

end namespace
