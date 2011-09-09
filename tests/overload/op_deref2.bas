# include "fbcu.bi"

namespace fbc_tests.overload_.op_deref2

type bar
	data as integer
end type

type foo
	b as bar
end type

operator -> ( byref lhs as foo ) as bar
	return lhs.b
end operator

sub test_1 cdecl
	dim as foo f = ( ( 1234 ) )
	
	CU_ASSERT_EQUAL( f->data, 1234 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-overload:op-deref2")
	fbcu.add_test("1", @test_1)

end sub

end namespace
