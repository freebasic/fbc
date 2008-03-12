# include "fbcu.bi"

extern const_extern_integer as const integer

dim shared const_extern_integer as const integer = 1234

namespace fbc_tests.const_.extern_

sub test_extern cdecl
	
	CU_ASSERT_EQUAL( const_extern_integer, 1234 )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("tests/const/extern")
	fbcu.add_test("extern", @test_extern)

end sub

end namespace