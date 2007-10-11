# include "fbcu.bi"




'//
'// test for macros defined locally
'//

namespace fbc_tests.scopes.macros

sub test_1 cdecl ()
	#define foo(x) x
	CU_ASSERT_EQUAL( foo(3), 3 )
end sub

sub test_2 cdecl ()
	#define foo(x) x
	CU_ASSERT_EQUAL( foo(4), 4 )
end sub

sub test_3 cdecl ()
	scope
		#define foo(x) x
		CU_ASSERT_EQUAL( foo(1), 1 )
	end scope

	scope
		#define foo(x) x
		CU_ASSERT_EQUAL( foo(2), 2 )
	end scope
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.scopes.macros")
	fbcu.add_test("test 1", @test_1)
	fbcu.add_test("test 2", @test_2)
	fbcu.add_test("test 3", @test_3)

end sub

end namespace
