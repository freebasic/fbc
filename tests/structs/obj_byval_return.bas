#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_byval_return )

	type bar1
	  as single x, y, z
	  declare function foo(as bar1) as bar1
	end type

	function bar1.foo(b as bar1) as bar1
	  return type(b.x+1.0, b.y+2.0, b.z+3.0)
	end function

	TEST( default ) '' bar1_test
		dim as bar1 b = type(0, 0, 0)
		
		b = b.foo( b )
		
		CU_ASSERT_EQUAL( b.x, 1.0 )
		CU_ASSERT_EQUAL( b.y, 2.0 )
		CU_ASSERT_EQUAL( b.z, 3.0 )

	END_TEST

	type bar2
	  as single x, y, z
	  declare function foo(as bar2) as bar2
	  declare destructor()
	end type

	destructor bar2()
	end destructor

	function bar2.foo(b as bar2) as bar2
	  return type(b.x+1.0, b.y+2.0, b.z+3.0)
	end function

	TEST( bar2_test )
		dim as bar2 b = type(-1, -2, -3)
		
		b = b.foo( b )
		
		CU_ASSERT_EQUAL( b.x, 0 )
		CU_ASSERT_EQUAL( b.y, 0 )
		CU_ASSERT_EQUAL( b.z, 0 )

	END_TEST

END_SUITE
