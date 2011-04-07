# include "fbcu.bi"

namespace fbc_tests.struct.obj_meth_static

enum TEST_RES
	TEST_RES_INT
	TEST_RES_DBL
	TEST_RES_LNG
	TEST_RES_STR
end enum

type foo
	declare function bar ( i as integer ) as TEST_RES
	declare function bar ( i as string ) as TEST_RES
	declare static function bar( i as double ) as TEST_RES
	declare static function bar( i as longint ) as TEST_RES
	
	pad as byte
end type

sub test_1 cdecl	
	dim f as foo
	
	CU_ASSERT_EQUAL( f.bar( 1.0 ), TEST_RES_DBL )
	CU_ASSERT_EQUAL( f.bar( 1 ), TEST_RES_INT )
	CU_ASSERT_EQUAL( f.bar( 1LL ), TEST_RES_LNG )
	CU_ASSERT_EQUAL( f.bar( "1" ), TEST_RES_STR )
	
end sub

sub test_2 cdecl	
	dim pf as foo ptr = new foo
	
	CU_ASSERT_EQUAL( pf->bar( 1.0 ), TEST_RES_DBL )
	CU_ASSERT_EQUAL( pf->bar( 1 ), TEST_RES_INT )
	CU_ASSERT_EQUAL( pf->bar( 1LL ), TEST_RES_LNG )
	CU_ASSERT_EQUAL( pf->bar( "1" ), TEST_RES_STR )
	
	delete pf
end sub

sub test_3 cdecl	
	dim f as foo
	
	CU_ASSERT_EQUAL( foo.bar( 1.0 ), TEST_RES_DBL )
	CU_ASSERT_EQUAL( foo.bar( 1LL ), TEST_RES_LNG )
	
end sub

function foo.bar( i as integer ) as TEST_RES
	function = TEST_RES_INT
end function

function foo.bar( i as double ) as TEST_RES
	function = TEST_RES_DBL
end function

function foo.bar( i as longint ) as TEST_RES
	function = TEST_RES_LNG
end function

function foo.bar( i as string ) as TEST_RES
	function = TEST_RES_STR
end function

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.meth_static")
	fbcu.add_test("1", @test_1)
	fbcu.add_test("2", @test_2)
	fbcu.add_test("3", @test_3)
	
end sub

end namespace
