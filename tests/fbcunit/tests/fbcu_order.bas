#include once "fbcunit.bi"

dim shared init_done as boolean = false
dim shared cleanup_done as boolean = false

namespace tests.fbcunit.order1

	sub test1 cdecl ( )
		CU_ASSERT_EQUAL( init_done, false )
		CU_ASSERT_EQUAL( cleanup_done, false )
	end sub

end namespace

namespace tests.fbcunit.order2

	function init cdecl () as long
		init_done = true
		function = 0
	end function

	function cleanup cdecl () as long
		cleanup_done = true
		function = 0
	end function

	sub test2 cdecl ( )
		CU_ASSERT_EQUAL( init_done, true )
		CU_ASSERT_EQUAL( cleanup_done, false )
	end sub

end namespace

namespace tests.fbcunit.order3

	sub test3 cdecl ( )
		CU_ASSERT_EQUAL( init_done, true )
		CU_ASSERT_EQUAL( cleanup_done, true )
	end sub

end namespace


private sub ctor ( ) constructor
	'' using a custom module constructor to control
	'' how procs are added to fbcunit to simulate
	'' out of order module constructors.
	'' Even though we have no control over module
	'' constructor execution order, we do expect the
	'' fbcunit framework to execute the tests in the
	'' order added.

	'' add a suite
	fbcu.add_suite( "fbcunit.order1" )

	'' add a test before adding the suite with init/cleanup procs
	fbcu.add_test( "fbcunit.order2", "fbcunit.order2.test2", @tests.fbcunit.order2.test2 )
	fbcu.add_suite( "fbcunit.order2", @tests.fbcunit.order2.init, @tests.fbcunit.order2.cleanup )

	fbcu.add_test( "fbcunit.order1", "fbcunit.order1.test1", @tests.fbcunit.order1.test1 )

	'' add a test, new suite, no init/cleanup procs
	fbcu.add_test( "fbcunit.order3", "fbcunit.order3.test3", @tests.fbcunit.order3.test3 )

end sub
