# include "fbcu.bi"

namespace fbc_tests.structs.obj_inner_enum

const TEST_ENUM1 = -1
const TEST_ENUM2 = 2
const TEST_CONST1 = 1234.5
const TEST_CONST2 = -4567.8

type foo
	enum bar
		enum1 = TEST_ENUM1
		enum2 = TEST_ENUM2
	end enum
	
	const as double const1 = TEST_CONST1, const2 = TEST_CONST2
	
	__ as integer
	
	declare sub func ( ) 
end type

sub foo.func ( ) 
	CU_ASSERT_EQUAL( enum1, TEST_ENUM1 )
	CU_ASSERT_EQUAL( enum2, TEST_ENUM2 )
	CU_ASSERT_EQUAL( const1, TEST_CONST1 )
	CU_ASSERT_EQUAL( const2, TEST_CONST2 )
end sub

sub test1 cdecl ()
	CU_ASSERT_EQUAL( foo.enum1, TEST_ENUM1 )
	CU_ASSERT_EQUAL( foo.enum2, TEST_ENUM2 )
	CU_ASSERT_EQUAL( foo.const1, TEST_CONST1 )
	CU_ASSERT_EQUAL( foo.const2, TEST_CONST2 )
end sub

sub test2 cdecl ()
	dim as foo f
	f.func
end sub

private sub ctor () constructor

	fbcu.add_suite( "tests/structs/obj_inner_enum" )
	fbcu.add_test( "#1", @test1 )
	fbcu.add_test( "#2", @test2 )

end sub

end namespace