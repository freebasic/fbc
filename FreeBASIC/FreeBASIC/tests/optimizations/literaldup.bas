# include "fbcu.bi"


	
namespace fbc_tests.optimizations.literaldup

function str1 as any ptr
	function = @"common lit string"
end function

function str2 as any ptr
	function = @"common lit string"
end function

sub test_literal_reuse cdecl ()
	CU_ASSERT_EQUAL( str1, str2 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests-optimizations:literal duplication")
	fbcu.add_test("test_literal_reuse", @test_literal_reuse)
end sub

end namespace
	
