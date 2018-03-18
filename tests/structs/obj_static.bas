#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_static )

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
		static as bar b1
		CU_ASSERT_EQUAL( b1.v, 1 )
		
		scope
			static as bar b2
			CU_ASSERT_EQUAL( b2.v, 2 )

			scope
				static as bar b3
				CU_ASSERT_EQUAL( b3.v, 3 )
			end scope
		end scope
		
	end sub

	TEST( all )
		
		'' run twice, the ctor should be called only once
		func
		func
		
	END_TEST
		
END_SUITE
