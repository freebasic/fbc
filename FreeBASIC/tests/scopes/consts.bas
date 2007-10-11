# include "fbcu.bi"




'//
'// test for constants defined locally
'//

namespace fbc_tests.scopes.consts

sub test_1 cdecl ()
	const foo = 3
	CU_ASSERT_EQUAL( foo, 3 )
end sub

sub test_2 cdecl ()
	const foo = 4
	CU_ASSERT_EQUAL( foo, 4 )
end sub

sub test_3 cdecl ()
	scope
		const foo = 1
		CU_ASSERT_EQUAL( foo, 1 )
	end scope

	scope
		const foo = 2
		CU_ASSERT_EQUAL( foo, 2 )
	end scope
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.scopes.constants")
	fbcu.add_test("test 1", @test_1)
	fbcu.add_test("test 2", @test_2)
	fbcu.add_test("test 3", @test_3)

end sub

end namespace
