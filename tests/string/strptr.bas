# include "fbcu.bi"

namespace fbc_tests.string_.strptr_

sub test_basic cdecl ()
	dim as string ptr foo
	dim as string bar = "1234"
	dim as zstring ptr p

	foo = @bar
	p = strptr( *foo )
	CU_ASSERT_EQUAL( *p, "1234" )
end sub
	
private sub ctor () constructor

	fbcu.add_suite("fbc_tests.string.strptr")
	fbcu.add_test("test_basic", @test_basic)

end sub
	
end namespace