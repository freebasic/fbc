#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_cast_ovl )

	type A
	    member as integer
	end type
	
	type B
		declare operator cast as A
	    member as integer
	end type
	
	operator B.cast as A
		return type(0)
	end operator
	
	function f overload as integer
		return 0
	end function 
	
	function f overload (x as A) as integer
		return -1
	end function
	
	TEST( all )
			dim x as B
			CU_ASSERT( f( x ) )
	END_TEST

END_SUITE
