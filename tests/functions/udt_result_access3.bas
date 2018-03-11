# include "fbcunit.bi"

SUITE( fbc_tests.functions.udt_result_access3 )

	static shared as integer dtor_cnt = 0

	const TEST_VALUE = &hdeadbeef

	type tbaz
		as integer value = TEST_VALUE
		declare destructor( )
	end type

	destructor tbaz( )
		dtor_cnt += 1
	end destructor

	type tbar
		as tbaz prop
		declare function baz(  ) as tbaz
		declare destructor( )
	end type

	function tbar.baz(  ) as tbaz
		return prop
	end function

	destructor tbar( )
		dtor_cnt += 1
	end destructor

	type tfoo
		as tbar prop
		declare function bar( byval unused1 as integer ) as tbar
		declare destructor( )
	end type

	function tfoo.bar( byval unused1 as integer ) as tbar
		return prop
	end function

	destructor tfoo( )
		dtor_cnt += 1
	end destructor

	type tudt
		as tfoo prop
		declare function foo( byval unused1 as integer, byval unused2 as integer ) as tfoo
	end type

	function tudt.foo( byval unused1 as integer, byval unused2 as integer ) as tfoo
		return prop
	end function

	TEST( testproc )
		dim myudt as tudt
		
		dtor_cnt = 0
		CU_ASSERT_EQUAL( myudt.foo( 1, 2 ).bar( 3 ).baz( ).value, TEST_VALUE )
		
		CU_ASSERT_EQUAL( dtor_cnt, 1 + 2 + 3 )
		
		dim res as integer = any
		
		dtor_cnt = 0
		res = myudt.foo( 1, 2 ).bar( 3 ).baz( ).value
		CU_ASSERT_EQUAL( res, TEST_VALUE )
		
		CU_ASSERT_EQUAL( dtor_cnt, 1 + 2 + 3 )
		
	END_TEST

END_SUITE
