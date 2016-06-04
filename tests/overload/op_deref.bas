# include "fbcu.bi"

namespace fbc_tests.overload_.op_deref

type foo
	data as integer
end type

operator * ( byref lhs as foo ) as integer
	return lhs.data
end operator

operator -> ( byref lhs as foo ) as foo
	return lhs
end operator

sub test_1 cdecl
	dim as foo f = ( 1234 )
	
	CU_ASSERT_EQUAL( f->data, 1234 )
	CU_ASSERT_EQUAL( *f, 1234 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.overload.op_deref")
	fbcu.add_test("1", @test_1)

end sub

end namespace
