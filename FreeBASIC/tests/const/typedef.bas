# include "fbcu.bi"

namespace fbc_tests.const_.typedef

sub test_enum cdecl
	type foo as bar
	
	enum bar
		val1 = 1, val2 = 2, val3 = 3
	end enum
	
	CU_ASSERT_EQUAL( foo.val2, 2 )
	
end sub

sub test_type cdecl
	type foo as bar
	
	type bar
		const val1 = 1, val2 = 2, val3 = 3
		pad as byte
	end type
	
	CU_ASSERT_EQUAL( foo.val2, 2 )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("tests/const/typedef")
	fbcu.add_test("enum", @test_enum)
	fbcu.add_test("type", @test_type)

end sub

end namespace