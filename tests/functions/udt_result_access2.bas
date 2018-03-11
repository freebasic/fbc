# include "fbcunit.bi"

SUITE( fbc_tests.functions.udt_result_access2 )

	const TEST_VALUE = &hdeadbeef

	type tbaz
		as integer value = TEST_VALUE
	end type

	type tbar
		as tbaz prop
		declare function baz(  ) as tbaz
	end type

	function tbar.baz(  ) as tbaz
		return prop
	end function

	type tfoo
		as tbar prop
		declare function bar( byval unused1 as integer ) as tbar
	end type

	function tfoo.bar( byval unused1 as integer ) as tbar
		return prop
	end function

	type tudt
		as tfoo prop
		declare function foo( byval unused1 as integer, byval unused2 as integer ) as tfoo
	end type

	function tudt.foo( byval unused1 as integer, byval unused2 as integer ) as tfoo
		return prop
	end function

	TEST( testproc )
		dim myudt as tudt
		
		CU_ASSERT_EQUAL( myudt.foo( 1, 2 ).bar( 3 ).baz( ).value, TEST_VALUE )
		
		dim res as integer = myudt.foo( 1, 2 ).bar( 3 ).baz( ).value
		CU_ASSERT_EQUAL( res, TEST_VALUE )
		
	END_TEST

END_SUITE
