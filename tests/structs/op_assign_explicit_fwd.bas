#include "fbcunit.bi"

SUITE( fbc_tests.structs.op_assign_explicit_fwd )

	'' fwd type
	type bar_ as bar

	type bar
		'' this field should create an implicit clone()
		value as string
		
		'' but we are proving one.. but using a forward type that wasn't resolved yet
		declare operator let ( byref rhs as bar_ )
		
	end type

	operator bar.let ( byref rhs as bar_ )
		value = rhs.value
	end operator

	TEST( all )
		dim as bar b1, b2
		
		b1.value = "1234"
		b2 = b1
		
		CU_ASSERT_EQUAL( b1.value, b2.value )
		
	END_TEST

END_SUITE
