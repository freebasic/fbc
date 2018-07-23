#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_meth_static2 )

	enum TEST_RES
		TEST_RES_INT
		TEST_RES_DBL
	end enum

	type foo
		declare static function bar( i as integer ) as TEST_RES
		declare function bar( d as double ) as TEST_RES

		pad as byte
	end type

	function foo.bar( i as integer ) as TEST_RES
		function = TEST_RES_INT
	end function

	function foo.bar( d as double ) as TEST_RES
		CU_ASSERT_EQUAL( foo.bar( cint( d ) ), TEST_RES_INT )
		CU_ASSERT_EQUAL( this.bar( cint( d ) ), TEST_RES_INT )
		CU_ASSERT_EQUAL( bar( cint( d ) ), TEST_RES_INT )

		'' just check if it's ok to use them as subs
		foo.bar cint( d )
		this.bar cint( d )
		bar cint( d )
		
		function = TEST_RES_DBL
		
	end function

	TEST( test1 )
		dim f as foo
		
		CU_ASSERT_EQUAL( f.bar( 1.234 ), TEST_RES_DBL )
		CU_ASSERT_EQUAL( foo.bar( 1 ), TEST_RES_INT )

	END_TEST

	TEST( test2 )
		dim f as foo
		
		'' just check if it's ok to use them as subs
		f.bar 1.234
		foo.bar 1

	END_TEST

END_SUITE
