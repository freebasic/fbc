#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_global )

	const ARRAY_LB = 0
	const ARRAY_UB = 3

	type bar
		as integer v = any
		declare constructor
		declare destructor
	end type

	constructor bar
		static as integer cnt = 0
		cnt += 1
		v = cnt
	end constructor

	destructor bar
		v = 0
	end destructor

	#macro test_array( array, baseidx )
		scope
			dim as integer i
			for i = ARRAY_LB to ARRAY_UB
				CU_ASSERT_EQUAL( array(i).v, 1 + baseidx + i )
			next
		end scope
	#endmacro

	static shared as bar b_static(ARRAY_LB to ARRAY_UB)
		
	TEST( static_ )
		test_array( b_static, (((ARRAY_UB - ARRAY_LB)+1) * 0) )
	END_TEST

	dim shared as bar b_shared(ARRAY_LB to ARRAY_UB)
		
	TEST( shared_ )
		test_array( b_shared, (((ARRAY_UB - ARRAY_LB)+1) * 1) )
	END_TEST

END_SUITE
