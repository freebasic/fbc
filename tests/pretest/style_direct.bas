#include "fbcunit.bi"

/'
	This style of suite/test is how the test suite
	used to be written.  If there is a need for it,
	it is still available.  

	namespace typically has the form:
	  fbc_tests.<PATHNAME>.<FILENAME>

	test entry points must be CDECL, and each needs to
	be added through the module constructor.
'/

namespace fbc_tests.pretest.style_direct

	sub test1 cdecl ( )
		CU_ASSERT_TRUE( -1 )
	end sub

	sub test2 cdecl ( )
		CU_ASSERT_FALSE( 0 )
	end sub

	private sub ctor () constructor
	
		#define SUITE_NAME "fbc_tests.pretest.style_direct"
		fbcu.add_suite( SUITE_NAME )
		fbcu.add_test( SUITE_NAME, "test1", @test1)
		fbcu.add_test( SUITE_NAME, "test2", @test2)
	
	end sub

end namespace
