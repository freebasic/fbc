#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_property_stmt )

	type tfoo
		declare function fun () as integer
		pad as byte
	end type

	function tfoo.fun () as integer
		function = 1234
	end function

	type bar
		declare property foo () as tfoo
		pad as byte
	end type

	property bar.foo() as tfoo
		return type(1)
	end property

	TEST( all )
		dim b as bar

		CU_ASSERT_EQUAL( b.foo.fun(), 1234 )
		
		'' invoke the property get, not the set
		b.foo.fun()
	END_TEST

END_SUITE