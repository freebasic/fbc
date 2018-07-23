#include "fbcunit.bi"

SUITE( fbc_tests.overload_.type_vararg )

	type foo
		declare function bar cdecl( byval i as integer, ... ) as integer
		declare sub bar2 cdecl( byval i as integer, ... )
		as integer baz
	end type

	TEST( only_one_vararg_in_type )
		'' this just has to compile!
		CU_ASSERT_EQUAL( 1, 1 )
	END_TEST

END_SUITE
