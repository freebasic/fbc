'' default ctor with optional params

#include "fbcunit.bi"

SUITE( fbc_tests.structs.ctor_default )

	const TEST_XVAL = 1234
	const TEST_YVAL = 9876

	type bar
		x as integer
		y as integer
		declare constructor( byval x as integer = TEST_XVAL, byval y as integer = TEST_YVAL )
	end type

	constructor bar( byval x as integer, byval y as integer )
		this.x = x
		this.y = y
	end constructor

	TEST( all )
		dim as bar b
		CU_ASSERT_EQUAL( b.x, TEST_XVAL )
		CU_ASSERT_EQUAL( b.y, TEST_YVAL )
	END_TEST
		
END_SUITE
