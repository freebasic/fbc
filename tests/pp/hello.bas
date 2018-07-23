#include "fbcunit.bi"

SUITE( fbc_tests.pp.hello )

	#define merge(seq) letter seq
	#define letter(seq) #seq + letter
	#define letter__ ""

	TEST( helloTest )

		if( merge( (H)(e)(l)(l)(o)(.)(W)(o)(r)(l)(d)(!)__ ) <> "Hello.World!" ) then
			CU_ASSERT( 0 )
		end if

	END_TEST

END_SUITE
