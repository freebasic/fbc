#include "fbcunit.bi"
	
SUITE( fbc_tests.overload_.arg_cast )
	
	type A
		member as integer
	end type
	
	type B
		declare operator cast as A
		member as integer
	end type

	operator B.cast as A : return type(0) : end operator
	sub f overload (x as integer) : CU_ASSERT(0): end sub
	sub f (x as A) : end sub
	
	TEST( arg_udt_cast )
		/'dim x as B
		f x'/
	END_TEST
	
END_SUITE
