# include "fbcu.bi"

namespace fbc_tests.overload_.op_addrof

type foo
	declare operator @ () as integer ptr
	data as integer
end type

operator foo.@ () as integer ptr
	return @data
end operator

sub test_1 cdecl
	dim as foo f = ( -1234 )
	
	CU_ASSERT_EQUAL( *@f, -1234 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.overload.op_addrof")
	fbcu.add_test("1", @test_1)

end sub

end namespace
