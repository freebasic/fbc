#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_property2 )

	type bar
		declare property v as integer
		declare property v ( new_v as integer )

		as integer p_v = 1
	end type

	property bar.v as integer
		property = p_v
	end property

	property bar.v ( new_v as integer)
		'' note: the property get will be called here
		p_v += v
	end property

	TEST( all )
		dim as bar b1
		
		b1.v = 1
		CU_ASSERT_EQUAL( b1.v, 1+1 )

	END_TEST
	
END_SUITE
