# include "fbcu.bi"

namespace fbc_tests.structs.enum_decl

enum TEST_RES
	TEST_BAR1 = 1
	TEST_BAR2 = 2
end enum

type foo
	enum bar1
		val1
	end enum

	enum bar2
		val2
	end enum
	
	as byte pad
end type

function func overload ( b as foo.bar1 ) as TEST_RES
	function = TEST_BAR1
end function

function func ( b as foo.bar2 ) as TEST_RES
	function = TEST_BAR2
end function

sub test_1 cdecl
	dim as foo.bar1 b1
	dim b2 as foo.bar2
	
	CU_ASSERT_EQUAL( func( b1 ), TEST_BAR1 )
	CU_ASSERT_EQUAL( func( b2 ), TEST_BAR2 )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.enum_decl")
	fbcu.add_test( "1", @test_1)

end sub
	
end namespace