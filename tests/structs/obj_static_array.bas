#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_static_array )

	const ARRAY_LB = 0
	const ARRAY_UB = 4

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

	sub func
		static as bar b1(ARRAY_LB to ARRAY_UB)
		
		dim as integer i
		for i = ARRAY_LB to ARRAY_UB
			CU_ASSERT_EQUAL( b1(i).v, 1 + i )
		next
		
	end sub

	TEST( all )
		
		'' run twice, the ctor should be called only once
		func
		func
		
	END_TEST
	
END_SUITE
