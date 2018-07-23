#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_vis_static )

	type foo
		pad as integer
		
		declare static function bar(i as integer) as integer
	private:
		declare static function bar as integer
	end type

	function foo.bar as integer 
		return 1234 
	end function

	function foo.bar(i as integer) as integer 
		return -1234 
	end function

	TEST( all )
		CU_ASSERT_EQUAL( foo.bar(1), -1234 )
	END_TEST

END_SUITE
