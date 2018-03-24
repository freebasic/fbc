#include "fbcunit.bi"

SUITE( fbc_tests.pointers.funptr_fwdbyref )

	enum TEST_RES
		TEST_FOO 
		TEST_BAR
	end enum

	type foo_ as foo
	type bar_ as bar

	type fooproto as function(byref as foo_) as TEST_RES
	type barproto as function(byref as bar_) as TEST_RES

	declare function fun overload (byref as foo_) as TEST_RES
	declare function fun overload (byref as bar_) as TEST_RES

	type foo
		foo as fooproto
	end type

	type bar
		bar as barproto
	end type

	function fun(byref p as foo) as TEST_RES
		function = TEST_FOO
	end function

	function fun(byref p as bar) as TEST_RES
		function = TEST_BAR
	end function

	TEST( all )

		dim f as foo
		dim b as bar
		
		f.foo = @fun
		b.bar = @fun
		
		CU_ASSERT_EQUAL( f.foo(f), TEST_FOO )
		CU_ASSERT_EQUAL( b.bar(b), TEST_BAR )

	END_TEST

END_SUITE
