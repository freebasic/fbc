# include "fbcu.bi"

namespace fbc_tests.numbers.tostring

sub test_f cdecl ()
	dim as single v1, v2
	v1 = csng(1.234567)
	v2 = val( "1.234567" )
	CU_ASSERT( v1 = v2 )
end sub
		
sub test_d cdecl ()	
	dim as single v1, v2
	v1 = cdbl(1.234567890123456)
	v2 = val( "1.234567890123456" )
	CU_ASSERT( v1 = v2 )
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.numbers.tostring")
	fbcu.add_test("test_d", @test_f)
	fbcu.add_test("test_f", @test_d)

end sub

end namespace
