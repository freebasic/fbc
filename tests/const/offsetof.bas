# include "fbcu.bi"

namespace fbc_tests.const_.offsetof_

type foo
	as integer field1
	as integer field2
end type

const field1_ofs = offsetof(foo, field1)
const field2_ofs = offsetof(foo, field2)

sub test cdecl ()
	CU_ASSERT_EQUAL( field1_ofs, len( integer ) * 0 )
	CU_ASSERT_EQUAL( field2_ofs, len( integer ) * 1 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.const.offsetof")
	fbcu.add_test("offset", @test)

end sub

end namespace