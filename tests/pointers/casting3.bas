#include "fbcunit.bi"

SUITE( fbc_tests.pointers.casting3 )

	type foo 
	  s as string 
	  l as longint
	end type 

	TEST( all )

		const TEST_VAL = &hdeadbeefdeadc0de

		dim as foo ptr bar

		bar = allocate( len( foo ) ) 

		bar->l = TEST_VAL

		*cast( byte ptr, @bar->l ) = 0

		CU_ASSERT_EQUAL( bar->l, (TEST_VAL and not 255) )

		'' free bar otherwise is considered memory leak
		deallocate bar

	END_TEST

END_SUITE
