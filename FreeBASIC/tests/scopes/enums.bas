# include "fbcu.bi"




'//
'// test for enums defined locally
'//

namespace fbc_tests.scopes.enums

sub test_1 cdecl ()
	enum foo: foo_val = 3: end enum
	CU_ASSERT_EQUAL( foo_val, 3 )
end sub

sub test_2 cdecl ()
	enum foo: foo_val = 4: end enum
	CU_ASSERT_EQUAL( foo_val, 4 )
end sub

sub test_3 cdecl ()
	scope
		enum foo: foo_val = 1: end enum
		CU_ASSERT_EQUAL( foo_val, 1 )
	end scope

	scope
		enum foo: foo_val = 2: end enum
		CU_ASSERT_EQUAL( foo_val, 2 )
	end scope
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.scopes.enums")
	fbcu.add_test("test 1", @test_1)
	fbcu.add_test("test 2", @test_2)
	fbcu.add_test("test 3", @test_3)

end sub

end namespace
