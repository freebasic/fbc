# include "fbcu.bi"

namespace fbc_tests.dim_.array_static_ini

type foo
	bar(0 to 3) as integer
end type

sub test_1 cdecl	
	static arr(0 to 10) as foo
	static pf as foo ptr = @arr(10)

	arr(10).bar(3) = -1234
	
	CU_ASSERT_EQUAL( pf->bar(3), -1234 )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.dim.array_static_init")
	fbcu.add_test("1", @test_1)

end sub

end namespace
		